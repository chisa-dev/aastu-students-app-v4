import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import 'pages/eula/eula_agreement_page.dart';
import 'services/anonymous_user_service.dart';
import 'services/notification_service.dart';
import 'services/push_notification_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  final environmentValues = FFDevEnvironmentValues();
  await environmentValues.initialize();

  await initFirebase();

  await NotificationService().initialize();
  await PushNotificationService().initialize();

  await FlutterFlowTheme.initialize();

  // Auto sign-in anonymously if no user is logged in.
  // This allows the app to work without requiring registration.
  final currentFirebaseUser = FirebaseAuth.instance.currentUser;
  if (currentFirebaseUser == null) {
    await AnonymousUserService().signInAnonymously();
  } else {
    // Ensure a Firestore user document exists for the current user.
    // Handles edge case where auth exists but doc was never created.
    await AnonymousUserService().ensureUserDocumentExists(currentFirebaseUser);
  }

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.entryPage});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  final Widget? entryPage;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier, widget.entryPage);
    userStream = aastuStudentsFirebaseUserStream()
      ..listen((user) {
        print('[DEBUG] Auth stream emitted user: ${user.uid}, loggedIn: ${user.loggedIn}');
        _appStateNotifier.update(user);
        final uid = user.uid;
        if (user.loggedIn && uid != null && uid.isNotEmpty) {
          PushNotificationService().setupForUser(uid);
        }
      }, onError: (e) {
        print('[DEBUG] Auth stream error: $e');
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: isWeb ? 0 : 1000),
      () {
        print('[DEBUG] Stopping splash image. loading=${_appStateNotifier.loading}, user=${_appStateNotifier.user?.uid}');
        _appStateNotifier.stopShowingSplashImage();
      },
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AASTU STUDENTS',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.dragged)) {
              return Color(4293257195);
            }
            if (states.contains(MaterialState.hovered)) {
              return Color(4293257195);
            }
            return Color(4293257195);
          }),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.dragged)) {
              return Color(4281414722);
            }
            if (states.contains(MaterialState.hovered)) {
              return Color(4281414722);
            }
            return Color(4281414722);
          }),
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'home';
  late Widget? _currentPage;
  bool _eulaChecked = false;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
    _checkEula();
  }

  Future<void> _checkEula() async {
    final accepted = await hasAcceptedEula();
    if (!accepted && mounted) {
      await ensureEulaAccepted(context);
    }
    if (mounted) {
      setState(() => _eulaChecked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'home': HomeWidget(),
      'main_Feed': MainFeedWidget(),
      'Store': StoreWidget(),
      'main_Profile': MainProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: Visibility(
        visible: responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => safeSetState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          selectedItemColor: FlutterFlowTheme.of(context).primary,
          unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 24.0,
              ),
              label: 'Home',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                size: 24.0,
              ),
              label: 'Feed',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.storefront,
                size: 24.0,
              ),
              label: 'Store',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 24.0,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                size: 24.0,
              ),
              label: 'Profile',
              tooltip: '',
            )
          ],
        ),
      ),
    );
  }
}
