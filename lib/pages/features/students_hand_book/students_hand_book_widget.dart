import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'students_hand_book_model.dart';
export 'students_hand_book_model.dart';

class StudentsHandBookWidget extends StatefulWidget {
  const StudentsHandBookWidget({super.key});

  @override
  State<StudentsHandBookWidget> createState() => _StudentsHandBookWidgetState();
}

class _StudentsHandBookWidgetState extends State<StudentsHandBookWidget> {
  late StudentsHandBookModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  PdfControllerPinch? _pdfController;
  bool _isLoading = true;
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentsHandBookModel());
    _loadPdf();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _loadPdf() async {
    try {
      final document =
          await PdfDocument.openAsset('assets/pdfs/1730017179741.pdf');
      _pdfController = PdfControllerPinch(
        document: Future.value(document),
      );
      safeSetState(() => _isLoading = false);
    } catch (e) {
      safeSetState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'StudentsHandBook',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 0.0),
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => context.safePop(),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 28.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Students Handbook',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: false,
                                ),
                          ),
                          if (_totalPages > 0)
                            Text(
                              'Page $_currentPage of $_totalPages',
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: 'Figtree',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    // Page navigation buttons
                    if (_totalPages > 0) ...[
                      _buildNavButton(
                        icon: Icons.keyboard_arrow_up_rounded,
                        onTap: _currentPage > 1
                            ? () => _pdfController?.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                )
                            : null,
                      ),
                      SizedBox(width: 4.0),
                      _buildNavButton(
                        icon: Icons.keyboard_arrow_down_rounded,
                        onTap: _currentPage < _totalPages
                            ? () => _pdfController?.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                )
                            : null,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              // PDF Viewer
              Expanded(
                child: _isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Loading handbook...',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Figtree',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : _pdfController != null
                        ? PdfViewPinch(
                            controller: _pdfController!,
                            onDocumentLoaded: (document) {
                              safeSetState(
                                  () => _totalPages = document.pagesCount);
                            },
                            onPageChanged: (page) {
                              safeSetState(() => _currentPage = page);
                            },
                            builders: PdfViewPinchBuilders<
                                DefaultBuilderOptions>(
                              options: const DefaultBuilderOptions(),
                              documentLoaderBuilder: (_) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                              pageLoaderBuilder: (_) => Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                              errorBuilder: (_, error) => Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        size: 48.0,
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'Failed to load PDF',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Outfit',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Unable to load handbook',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Figtree',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Icon(
          icon,
          color: isEnabled
              ? FlutterFlowTheme.of(context).primaryText
              : FlutterFlowTheme.of(context).alternate,
          size: 22.0,
        ),
      ),
    );
  }
}
