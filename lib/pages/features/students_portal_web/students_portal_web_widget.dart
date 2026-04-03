import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'students_portal_web_model.dart';
export 'students_portal_web_model.dart';

class StudentsPortalWebWidget extends StatefulWidget {
  const StudentsPortalWebWidget({
    super.key,
    required this.url,
  });

  final String? url;

  @override
  State<StudentsPortalWebWidget> createState() =>
      _StudentsPortalWebWidgetState();
}

class _StudentsPortalWebWidgetState extends State<StudentsPortalWebWidget> {
  late StudentsPortalWebModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  WebViewController? _webViewController;
  double _loadingProgress = 0.0;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  String _pageTitle = 'Student Portal';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentsPortalWebModel());
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      _initWebView();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          safeSetState(() {
            _loadingProgress = progress / 100.0;
            _isLoading = progress < 100;
          });
        },
        onPageStarted: (url) {
          safeSetState(() {
            _isLoading = true;
            _hasError = false;
          });
        },
        onPageFinished: (url) {
          safeSetState(() {
            _isLoading = false;
            _loadingProgress = 1.0;
          });
          _webViewController?.getTitle().then((title) {
            if (title != null && title.isNotEmpty && mounted) {
              safeSetState(() => _pageTitle = title);
            }
          });
        },
        onWebResourceError: (error) {
          safeSetState(() {
            _hasError = true;
            _isLoading = false;
            _errorMessage = error.description;
          });
        },
        onNavigationRequest: (request) {
          // Open external links (WhatsApp, tel, mailto) in system browser
          final uri = Uri.tryParse(request.url);
          if (uri != null &&
              !uri.scheme.startsWith('http') &&
              uri.scheme != 'about') {
            launchUrl(uri, mode: LaunchMode.externalApplication);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.url ?? 'about:blank'));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'StudentPortal',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () => context.safePop(),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _pageTitle.length > 30
                      ? '${_pageTitle.substring(0, 30)}...'
                      : _pageTitle,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Figtree',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
                ),
                if (_isLoading)
                  Text(
                    'Loading...',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Figtree',
                          fontSize: 11.0,
                          letterSpacing: 0.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  safeSetState(() {
                    _hasError = false;
                    _isLoading = true;
                  });
                  _webViewController?.reload();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.open_in_browser_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  final url = widget.url;
                  if (url != null) {
                    launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ],
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: _isLoading
                  ? LinearProgressIndicator(
                      value: _loadingProgress > 0 ? _loadingProgress : null,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                      minHeight: 2.5,
                    )
                  : SizedBox(height: 2.5),
            ),
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (kIsWeb) {
      return Center(
        child: Text(
          'Web view is not supported on this platform.\nOpen the link in your browser.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Figtree',
                letterSpacing: 0.0,
              ),
        ),
      );
    }

    if (_hasError) {
      return _buildErrorState();
    }

    if (_webViewController == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      );
    }

    return WebViewWidget(controller: _webViewController!);
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context)
                    .error
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                color: FlutterFlowTheme.of(context).error,
                size: 40.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Failed to Load Page',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 8.0),
            Text(
              _errorMessage.isNotEmpty
                  ? _errorMessage
                  : 'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Figtree',
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: () {
                safeSetState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _webViewController?.reload();
              },
              icon: Icon(Icons.refresh_rounded, size: 20.0),
              label: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
