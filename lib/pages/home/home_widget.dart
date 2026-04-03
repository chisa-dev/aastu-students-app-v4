import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/blocked_account_widget.dart';
import '/components/create_modal/create_modal_widget.dart';
import '/components/download_available/download_available_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/account_gate_service.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '/flutter_flow/blurhash_image.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
    bool? update,
  }) : this.update = update ?? false;

  final bool update;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  Future<void> _loadTodayClassCount() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('class_schedule');
    if (raw == null) return;
    final list = jsonDecode(raw) as List;
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final todayIndex = DateTime.now().weekday - 1; // 0=Mon
    if (todayIndex < 0 || todayIndex >= dayNames.length) return;
    final today = dayNames[todayIndex];
    final count = list.where((e) => e['day'] == today).length;
    if (mounted) {
      safeSetState(() => _model.todayClassCount = count);
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // Initialize category items with defaults, then load saved order
    _model.academicsItems = List.from(HomeModel.defaultAcademics);
    _model.toolsItems = List.from(HomeModel.defaultTools);
    _model.campusLifeItems = List.from(HomeModel.defaultCampusLife);
    _model.loadCategoryOrder().then((_) {
      if (mounted) setState(() {});
    });
    _loadTodayClassCount();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.changeStatusBarColor(
        context,
        FlutterFlowTheme.of(context).primaryBackground,
      );
      if (valueOrDefault<bool>(currentUserDocument?.isBlocked, false) == true) {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: WebViewAware(
                child: BlockedAccountWidget(),
              ),
            );
          },
        );

        return;
      } else {
        // Run task count and version check in parallel for faster UI
        final versionFuture = queryConstantsRecordOnce(
          queryBuilder: (constantsRecord) => constantsRecord.where(
            'id',
            isEqualTo: 'app_constants',
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);

        // Task count query chain — updates UI as soon as ready
        () async {
          _model.myDailyNegarit = await queryDailyNegaritRecordOnce(
            queryBuilder: (dailyNegaritRecord) => dailyNegaritRecord.where(
              'id',
              isEqualTo: currentUserUid,
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if (_model.myDailyNegarit != null) {
            _model.myNotes = await queryMyNotesRecordOnce(
              parent: _model.myDailyNegarit?.reference,
              queryBuilder: (myNotesRecord) => myNotesRecord.where(
                'completed',
                isEqualTo: false,
              ),
            );
            if (_model.myNotes != null && _model.myNotes!.isNotEmpty) {
              _model.getTaskNoList = await actions.countNotesItems(
                _model.myNotes!.map((e) => e.reference).toList(),
              );
              _model.assignmentNo = _model.getTaskNoList?.elementAtOrNull(0) ?? 0;
              _model.testNo = _model.getTaskNoList?.elementAtOrNull(1) ?? 0;
              _model.otherNo = _model.getTaskNoList?.elementAtOrNull(2) ?? 0;
            }
          }
          safeSetState(() {});
        }();

        _model.latestVersion = await versionFuture;
        final packageInfo = await PackageInfo.fromPlatform();
        final localBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
        if (localBuildNumber < _model.latestVersion!.buildNo) {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: WebViewAware(
                  child: DownloadAvailableWidget(),
                ),
              );
            },
          );

          return;
        }
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    animationsMap.addAll({
      'iconOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildCategoryCard(
    BuildContext context,
    CategoryItem item, {
    required int index,
    required List<CategoryItem> items,
    required String orderKey,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          if (item.isSpecialRoute) {
            final canProceed = await requireAccount(
              context,
              featureName: 'create a Virtual ID',
            );
            if (!canProceed || !context.mounted) return;
            if (valueOrDefault<bool>(
                    currentUserDocument?.hasVirtualId, false) ==
                true) {
              context.pushNamed('virtual_identity');
            } else {
              context.pushNamed('registerID');
            }
          } else if (item.queryParameters != null) {
            context.pushNamed(
              item.route!,
              queryParameters: {
                for (final entry in item.queryParameters!.entries)
                  entry.key: serializeParam(
                    entry.value,
                    ParamType.String,
                  ),
              }.withoutNulls,
            );
          } else {
            context.pushNamed(item.route!);
          }
        },
        child: Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    item.imageAsset,
                    width: 70.0,
                    height: 70.0,
                    fit: item.imageFit,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Figtree',
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 0.0),
                          child: Text(
                            item.description,
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onSelected: (value) {
                      if (value == 'up' && index > 0) {
                        setState(() {
                          final item = items.removeAt(index);
                          items.insert(index - 1, item);
                        });
                        _model.saveCategoryOrder(orderKey, items);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Your order has been saved'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      } else if (value == 'down' && index < items.length - 1) {
                        setState(() {
                          final item = items.removeAt(index);
                          items.insert(index + 1, item);
                        });
                        _model.saveCategoryOrder(orderKey, items);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Your order has been saved'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      if (index > 0)
                        PopupMenuItem(
                          value: 'up',
                          height: 36.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_upward, size: 16.0),
                              SizedBox(width: 6.0),
                              Text('Move up', style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                        ),
                      if (index < items.length - 1)
                        PopupMenuItem(
                          value: 'down',
                          height: 36.0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_downward, size: 16.0),
                              SizedBox(width: 6.0),
                              Text('Move down', style: TextStyle(fontSize: 13.0)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReorderableTab({
    required List<CategoryItem> items,
    required String orderKey,
    required EdgeInsetsGeometry padding,
  }) {
    return Padding(
      padding: padding,
      child: ReorderableListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        proxyDecorator: (child, index, animation) {
          return Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.transparent,
            child: child,
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
          _model.saveCategoryOrder(orderKey, items);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Your order has been saved'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            key: ValueKey(item.id),
            child: _buildCategoryCard(context, item,
                index: index, items: items, orderKey: orderKey),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Title(
          title: 'home',
          color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: Visibility(
              visible: false,
              child: FloatingActionButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Color(0x00000000),
                    barrierColor: FlutterFlowTheme.of(context).accent4,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: CreateModalWidget(),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                backgroundColor: FlutterFlowTheme.of(context).primary,
                elevation: 8.0,
                child: Icon(
                  Icons.create_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
            body: SafeArea(
              top: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.sideNavModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SideNavWidget(
                      selectedNav: 1,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 1070.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: SingleChildScrollView(
                            primary: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 16.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          if (!(Theme.of(context).brightness ==
                                              Brightness.dark))
                                            Opacity(
                                              opacity: 0.9,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 0.0, 8.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    setDarkModeSetting(context,
                                                        ThemeMode.dark);
                                                    if (animationsMap[
                                                            'iconOnActionTriggerAnimation2'] !=
                                                        null) {
                                                      await animationsMap[
                                                              'iconOnActionTriggerAnimation2']!
                                                          .controller
                                                          .forward(from: 0.0);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.dark_mode_outlined,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 27.0,
                                                  ),
                                                ).animateOnActionTrigger(
                                                  animationsMap[
                                                      'iconOnActionTriggerAnimation1']!,
                                                ),
                                              ),
                                            ),
                                          if (!(Theme.of(context).brightness ==
                                              Brightness.light))
                                            Opacity(
                                              opacity: 0.9,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 0.0, 8.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    setDarkModeSetting(context,
                                                        ThemeMode.light);
                                                    if (animationsMap[
                                                            'iconOnActionTriggerAnimation1'] !=
                                                        null) {
                                                      await animationsMap[
                                                              'iconOnActionTriggerAnimation1']!
                                                          .controller
                                                          .forward(from: 0.0);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.light_mode,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 27.0,
                                                  ),
                                                ).animateOnActionTrigger(
                                                  animationsMap[
                                                      'iconOnActionTriggerAnimation2']!,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Unread notification badge
                                          StreamBuilder<List<ChatsRecord>>(
                                            stream: queryChatsRecord(
                                              queryBuilder: (chatsRecord) =>
                                                  chatsRecord
                                                      .where('users',
                                                          arrayContains:
                                                              currentUserReference)
                                                      .orderBy(
                                                          'last_message_time',
                                                          descending: true),
                                            ),
                                            builder: (context, snapshot) {
                                              int unreadCount = 0;
                                              if (snapshot.hasData) {
                                                unreadCount = snapshot.data!
                                                    .where((chat) => !chat
                                                        .lastMessageSeenBy
                                                        .contains(
                                                            currentUserReference))
                                                    .length;
                                              }
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context
                                                      .pushNamed('main_Chat');
                                                },
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 14.0, 0.0),
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .chat_bubble_outline_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 26.0,
                                                      ),
                                                      if (unreadCount > 0)
                                                        Positioned(
                                                          right: -6,
                                                          top: -4,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 18.0,
                                                              minHeight: 18.0,
                                                            ),
                                                            child: Text(
                                                              unreadCount > 9
                                                                  ? '9+'
                                                                  : '$unreadCount',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Figtree',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          // Profile icon
                                          AuthUserStreamWidget(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context
                                                    .pushNamed('main_Profile');
                                              },
                                              child: Container(
                                                width: 40.0,
                                                height: 40.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: currentUserPhoto
                                                        .isNotEmpty
                                                    ? BlurHashNetworkImage(
                                                        imageUrl:
                                                            currentUserPhoto,
                                                        blurHash:
                                                            currentUserDocument
                                                                ?.photoBlurHash,
                                                        width: 40.0,
                                                        height: 40.0,
                                                        fit: BoxFit.cover,
                                                        shape: BoxShape.circle,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .person_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 12.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 12.0, 0.0),
                                            child: Text(
                                              'AASTU Students Community',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 12.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Color(0x00000000),
                                                barrierColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                                context: context,
                                                builder: (context) {
                                                  return WebViewAware(
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          CreateModalWidget(),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            },
                                            text: 'New Post',
                                            icon: Icon(
                                              Icons.mode_edit,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              height: 44.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 2.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            showLoadingIndicator: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 8.0, 12.0, 0.0),
                                  child: Container(
                                    height: 76.0,
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Hello There,',
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .blueBlackText,
                                                        fontSize: 21.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 2.0, 0.0, 0.0),
                                                child: Text(
                                                  'How is your study?',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (false)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 4.0, 8.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.search,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          18.0, 0.0, 18.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 145.0,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 4.0,
                                                          color:
                                                              Color(0x33000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                          Color(0xFF819AFE),
                                                          Color(0xFF97A8ED)
                                                        ],
                                                        stops: [0.0, 0.5, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                                1.0, -1.0),
                                                        end:
                                                            AlignmentDirectional(
                                                                -1.0, 1.0),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                            'DailyNegarit');
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 100.0,
                                                            height: 100.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        30.0,
                                                                        2.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Daily Negarit',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Figtree',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        fontSize:
                                                                            20.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  'You have upcoming',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Figtree',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        fontSize:
                                                                            11.5,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              '${_model.assignmentNo + _model.testNo + _model.otherNo} ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Figtree',
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              'Tasks',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 15.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Figtree',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (_model.todayClassCount > 0)
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            2.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      '${_model.todayClassCount} Class${_model.todayClassCount == 1 ? '' : 'es'}',
                                                                      style: FlutterFlowTheme.of(context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily: 'Figtree',
                                                                            color: FlutterFlowTheme.of(context).secondaryBackground.withValues(alpha: 0.85),
                                                                            fontSize: 12.0,
                                                                            letterSpacing: 0.0,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      context.pushNamed(
                                                                          'DailyNegarit');
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          28.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            Colors.black,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.add_rounded,
                                                                              color: Colors.white,
                                                                              size: 14.0,
                                                                            ),
                                                                            SizedBox(width: 3.0),
                                                                            Text(
                                                                              'Add Task',
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    fontFamily: 'Figtree',
                                                                                    color: Colors.white,
                                                                                    fontSize: 11.5,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/robot_happy.png',
                                                    width: 200.0,
                                                    height: 163.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // ── Grade Calculator Quick Start Card ──
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 8.0, 16.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context
                                                .pushNamed('grade_calulator');
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 90.0,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF7B99FB),
                                                  Color(0xFF5B7FF0),
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: AlignmentDirectional(
                                                    -1.0, -0.5),
                                                end: AlignmentDirectional(
                                                    1.0, 0.5),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0x337B99FB),
                                                  offset: Offset(0.0, 4.0),
                                                )
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      18.0, 0.0, 14.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Calculate your grade',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Figtree',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    3.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          'GPA & CGPA calculator',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                color: Colors
                                                                    .white
                                                                    .withValues(
                                                                        alpha:
                                                                            0.8),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 36.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      border: Border.all(
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.4),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Start',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Figtree',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 16.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 20.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 0.0, 16.0),
                                                child: Text(
                                                  'Categories',
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .blueBlackText,
                                                        fontSize: 21.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 500.0,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0),
                                                    child:
                                                        FlutterFlowButtonTabBar(
                                                      useToggleButtonStyle:
                                                          true,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      unselectedLabelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      labelColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      unselectedLabelColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      backgroundColor:
                                                          Color(0x287B99FB),
                                                      unselectedBackgroundColor:
                                                          Colors.transparent,
                                                      borderColor:
                                                          Colors.transparent,
                                                      unselectedBorderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryBackground,
                                                      borderWidth: 0.0,
                                                      borderRadius: 12.0,
                                                      elevation: 0.0,
                                                      buttonMargin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                      tabs: [
                                                        Tab(
                                                          text: 'Academics',
                                                        ),
                                                        Tab(
                                                          text: 'Tools',
                                                        ),
                                                        Tab(
                                                          text: 'Campus Life',
                                                        ),
                                                      ],
                                                      controller: _model
                                                          .tabBarController,
                                                      onTap: (i) async {
                                                        [
                                                          () async {},
                                                          () async {},
                                                          () async {}
                                                        ][i]();
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TabBarView(
                                                      controller: _model
                                                          .tabBarController,
                                                      children: [
                                                        _buildReorderableTab(
                                                          items: _model.academicsItems,
                                                          orderKey: 'category_order_academics',
                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                        ),
                                                        _buildReorderableTab(
                                                          items: _model.toolsItems,
                                                          orderKey: 'category_order_tools',
                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                        ),
                                                        _buildReorderableTab(
                                                          items: _model.campusLifeItems,
                                                          orderKey: 'category_order_campus_life',
                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
