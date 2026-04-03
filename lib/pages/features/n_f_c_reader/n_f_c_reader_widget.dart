import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'n_f_c_reader_model.dart';
export 'n_f_c_reader_model.dart';

class NFCReaderWidget extends StatefulWidget {
  const NFCReaderWidget({super.key});

  @override
  State<NFCReaderWidget> createState() => _NFCReaderWidgetState();
}

class _NFCReaderWidgetState extends State<NFCReaderWidget>
    with TickerProviderStateMixin {
  late NFCReaderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NFCReaderModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
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

  /// Parse student name from QR data.
  /// Virtual ID QR format: "Full Name (ID) - College StudyLevel"
  String? _parseNameFromQR(String qrData) {
    final match = RegExp(r'^(.+?)\s*\(').firstMatch(qrData);
    return match?.group(1)?.trim();
  }

  bool _isValidStudentQR(String qrData) {
    return RegExp(r'^.+\s*\(.+\)\s*-\s*.+').hasMatch(qrData);
  }

  void _showScanResult(BuildContext context, String qrData) {
    final isValid = _isValidStudentQR(qrData);
    final studentName = isValid ? _parseNameFromQR(qrData) : null;

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 20.0,
                color: Color(0x30000000),
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: isValid
                      ? Color(0xFF0B6B41).withValues(alpha: 0.12)
                      : FlutterFlowTheme.of(context).error.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isValid ? Icons.verified_user_rounded : Icons.error_outline_rounded,
                  color: isValid ? Color(0xFF0B6B41) : FlutterFlowTheme.of(context).error,
                  size: 32.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                isValid ? 'Identity Verified' : 'Invalid QR Code',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
              SizedBox(height: 8.0),
              if (isValid && studentName != null) ...[
                Text(
                  studentName,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Figtree',
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 6.0),
                Text(
                  qrData,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        fontFamily: 'Figtree',
                        letterSpacing: 0.0,
                      ),
                ),
              ] else if (!isValid) ...[
                Text(
                  'The scanned QR code does not match a valid AASTU student ID.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Figtree',
                        letterSpacing: 0.0,
                      ),
                ),
              ],
              SizedBox(height: 24.0),
              FFButtonWidget(
                onPressed: () => Navigator.of(dialogContext).pop(),
                text: 'Done',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 44.0,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Figtree',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'ID Scanner',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: responsiveVisibility(
            context: context,
            tabletLandscape: false,
            desktop: false,
          )
              ? AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                  automaticallyImplyLeading: false,
                  leading: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 28.0,
                    ),
                    onPressed: () async {
                      context.pop();
                    },
                  ),
                  title: Text(
                    'ID Scanner',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                  centerTitle: false,
                  elevation: 0.0,
                )
              : null,
          body: SafeArea(
            top: true,
            child: StreamBuilder<List<MyVirtualIDRecord>>(
              stream: queryMyVirtualIDRecord(
                queryBuilder: (q) => q.where('uid', isEqualTo: currentUserUid),
                singleRecord: true,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }

                final hasVirtualId = snapshot.data!.isNotEmpty;
                final virtualIdRecord = hasVirtualId ? snapshot.data!.first : null;

                // QR data matches virtual ID page format
                final qrData = hasVirtualId && virtualIdRecord != null
                    ? '${virtualIdRecord.fullName} (${virtualIdRecord.idNumber}) - ${virtualIdRecord.college} ${virtualIdRecord.studyLevel}'
                    : '';

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (hasVirtualId) ...[
                          // ── QR Card ──
                          Text(
                            'Your Student QR Code',
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Show this to verify your identity, or scan another student\'s code.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 24.0),
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxWidth: 400.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 16.0,
                                  color: Color(0x1A000000),
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(28.0),
                              child: Column(
                                children: [
                                  QrImageView(
                                    data: qrData,
                                    version: QrVersions.auto,
                                    size: 220.0,
                                    backgroundColor: Colors.white,
                                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    virtualIdRecord?.fullName ?? currentUserDisplayName,
                                    style: TextStyle(
                                      fontFamily: 'Figtree',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF15161E),
                                    ),
                                  ),
                                  if ((virtualIdRecord?.idNumber ?? '').isNotEmpty) ...[
                                    SizedBox(height: 4.0),
                                    Text(
                                      virtualIdRecord!.idNumber,
                                      style: TextStyle(
                                        fontFamily: 'Figtree',
                                        fontSize: 13.0,
                                        color: Color(0xFF57636C),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ] else ...[
                          // ── No Virtual ID state ──
                          SizedBox(height: 32.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.badge_outlined,
                                  size: 56.0,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'No Virtual ID Found',
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                        fontFamily: 'Figtree',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'You need to create your Virtual ID before you can show your QR code.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Figtree',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                SizedBox(height: 20.0),
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('registerID');
                                  },
                                  text: 'Create Virtual ID',
                                  icon: Icon(Icons.add_card_rounded, size: 18.0),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 46.0,
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Figtree',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // ── Scan button (always visible) ──
                        SizedBox(height: 24.0),
                        FFButtonWidget(
                          onPressed: () async {
                            final ctx = context;
                            final result = await actions.simpleBarCodeScanner(ctx);
                            if (!mounted) return;
                            if (result != '-1' && result != 'null' && result.isNotEmpty) {
                              _showScanResult(this.context, result);
                            }
                          },
                          text: 'Scan QR Code',
                          icon: Icon(Icons.qr_code_scanner_rounded, size: 20.0),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 52.0,
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Figtree',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
