import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/config/virtual_id_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/features/components/delete_virtual_i_d/delete_virtual_i_d_widget.dart';
import '/services/virtual_id_image_service.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:octo_image/octo_image.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'virtual_identity_model.dart';
export 'virtual_identity_model.dart';

class VirtualIdentityWidget extends StatefulWidget {
  const VirtualIdentityWidget({super.key});

  @override
  State<VirtualIdentityWidget> createState() => _VirtualIdentityWidgetState();
}

class _VirtualIdentityWidgetState extends State<VirtualIdentityWidget> {
  late VirtualIdentityModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _frontCardKey = GlobalKey();
  final _backCardKey = GlobalKey();

  String? _frontImageUrl;
  String? _backImageUrl;
  String? _frontBlurhash;
  String? _backBlurhash;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VirtualIdentityModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    _loadCardImages();
  }

  Future<void> _loadCardImages() async {
    // Seed from cache first so the card renders instantly offline.
    final cached = await VirtualIdImageService.getFromCache();
    if (mounted) {
      safeSetState(() {
        _frontImageUrl = cached.frontUrl;
        _backImageUrl = cached.backUrl;
        _frontBlurhash = cached.frontBlurhash;
        _backBlurhash = cached.backBlurhash;
      });
    }
    // Refresh from Firestore in background.
    final fresh = await VirtualIdImageService.fetchAndCache();
    if (mounted) {
      safeSetState(() {
        if (fresh.frontUrl != null) _frontImageUrl = fresh.frontUrl;
        if (fresh.backUrl != null) _backImageUrl = fresh.backUrl;
        if (fresh.frontBlurhash != null) _frontBlurhash = fresh.frontBlurhash;
        if (fresh.backBlurhash != null) _backBlurhash = fresh.backBlurhash;
      });
    }
  }

  /// Builds a card background with optional blurhash placeholder while
  /// the network image loads. Falls back to the bundled asset when no URL.
  Widget _buildCardBackground(
      String? networkUrl, String assetFallback, String? blurhash) {
    if (networkUrl != null && networkUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: networkUrl,
        fit: BoxFit.contain,
        width: VirtualIdConfig.cardWidth,
        height: VirtualIdConfig.cardHeight,
        placeholder: (_, __) => blurhash != null && blurhash.isNotEmpty
            ? SizedBox(
                width: VirtualIdConfig.cardWidth,
                height: VirtualIdConfig.cardHeight,
                child: BlurHash(hash: blurhash),
              )
            : SizedBox(
                width: VirtualIdConfig.cardWidth,
                height: VirtualIdConfig.cardHeight,
                child: Image.asset(assetFallback, fit: BoxFit.contain),
              ),
        errorWidget: (_, __, ___) =>
            Image.asset(assetFallback, fit: BoxFit.contain),
      );
    }
    return Image.asset(assetFallback,
        width: VirtualIdConfig.cardWidth,
        height: VirtualIdConfig.cardHeight,
        fit: BoxFit.contain);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  /// Builds a value-only text for the front card overlay.
  /// Labels are already printed on the card image.
  Widget _buildCardField(String label, String value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Figtree',
        fontSize: VirtualIdConfig.valueFontSize,
        color: Color(0xFF15161E),
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
    );
  }

  /// Builds a date text widget for the back card.
  Widget _buildDateText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Figtree',
        fontSize: VirtualIdConfig.dateFontSize,
        color: Color(0xFF15161E),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Returns "September 1, YYYY" where YYYY is the year the ID was created.
  String _formatIssuedDate(String? createdAt) {
    final now = DateTime.now();
    int year = now.year;
    if (createdAt != null && createdAt.isNotEmpty) {
      final parsed = DateTime.tryParse(createdAt);
      if (parsed != null) year = parsed.year;
    }
    return '1/9/$year';
  }

  /// Returns "1/9/YYYY+1" (one year after issued date).
  String _formatExpiryDate(String? createdAt) {
    final now = DateTime.now();
    int year = now.year;
    if (createdAt != null && createdAt.isNotEmpty) {
      final parsed = DateTime.tryParse(createdAt);
      if (parsed != null) year = parsed.year;
    }
    return '1/9/${year + 1}';
  }

  /// Builds a label+value row for the Student Information section.
  Widget _buildInfoField(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
          Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  fontSize: 15.0,
                  letterSpacing: 0.0,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'virtual_identity',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // ── Header row ──
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.chevron_left,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 34.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'My Virtual ID',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                child: FaIcon(
                                  FontAwesomeIcons.wifi,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Stream data ──
                    if (true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 24.0, 2.0, 40.0),
                        child: StreamBuilder<List<MyVirtualIDRecord>>(
                          stream: queryMyVirtualIDRecord(
                            queryBuilder: (myVirtualIDRecord) =>
                                myVirtualIDRecord.where(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
                            // Loading state.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<MyVirtualIDRecord>
                                columnMyVirtualIDRecordList = snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final columnMyVirtualIDRecord =
                                columnMyVirtualIDRecordList.isNotEmpty
                                    ? columnMyVirtualIDRecordList.first
                                    : null;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Card carousel (front + back) ──
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 12.0, 0.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // ── FRONT CARD ──
                                        RepaintBoundary(
                                          key: _frontCardKey,
                                          child: SizedBox(
                                          width: VirtualIdConfig.cardWidth,
                                          height: VirtualIdConfig.cardHeight,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: _buildCardBackground(
                                                  _frontImageUrl,
                                                  VirtualIdConfig.frontCardImage,
                                                  _frontBlurhash,
                                                ),
                                              ),
                                              // Photo on the RIGHT side
                                              Positioned(
                                                left: VirtualIdConfig.photoX,
                                                top: VirtualIdConfig.photoY,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(0.0),
                                                  child: OctoImage(
                                                    placeholderBuilder: (_) =>
                                                        SizedBox.expand(
                                                      child: Image(
                                                        image: BlurHashImage(
                                                            columnMyVirtualIDRecord!
                                                                .photoBlur),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    image: NetworkImage(
                                                      valueOrDefault<String>(
                                                        columnMyVirtualIDRecord
                                                            ?.photoUrl,
                                                        'https://wildearthguardians.org/wp-content/uploads/2018/12/placeholder-user.png',
                                                      ),
                                                    ),
                                                    width: VirtualIdConfig
                                                        .photoWidth,
                                                    height: VirtualIdConfig
                                                        .photoHeight,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),

                                              // Text fields on the LEFT side
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .fullNameOffsetY,
                                                child: _buildCardField(
                                                  'Full Name',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.fullName,
                                                    'NA',
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .genderOffsetY,
                                                child: _buildCardField(
                                                  'Gender',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.gender,
                                                    'NA',
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .collegeOffsetY,
                                                child: _buildCardField(
                                                  'College',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.college,
                                                    'NA',
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .studyLevelOffsetY,
                                                child: _buildCardField(
                                                  'Study Level',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.studyLevel,
                                                    'NA',
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .admissionOffsetY,
                                                child: _buildCardField(
                                                  'Admission',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.admission,
                                                    'NA',
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left:
                                                    VirtualIdConfig.fieldsStartX,
                                                top:
                                                    VirtualIdConfig.fieldsStartY +
                                                        VirtualIdConfig
                                                            .phoneNoOffsetY,
                                                child: _buildCardField(
                                                  'Phone No.',
                                                  valueOrDefault<String>(
                                                    columnMyVirtualIDRecord
                                                        ?.phoneNo,
                                                    'NA',
                                                  ),
                                                ),
                                              ),

                                              // Website URL (bottom center)
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                top: VirtualIdConfig.websiteUrlY,
                                                child: Center(
                                                  child: Text(
                                                    'www.aastu.edu.et',
                                                    style: TextStyle(
                                                      fontFamily: 'Figtree',
                                                      fontSize: VirtualIdConfig.websiteUrlFontSize,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Rotated SID number (right edge, vertical)
                                              Positioned(
                                                left: VirtualIdConfig.sidX,
                                                top: VirtualIdConfig.sidY,
                                                child: RotatedBox(
                                                  quarterTurns: 3,
                                                  child: Text(
                                                    'SID No. ${columnMyVirtualIDRecord?.idNumber ?? 'NA'}',
                                                    style: TextStyle(
                                                      fontFamily: 'Figtree',
                                                      fontSize: VirtualIdConfig.sidFontSize,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ),

                                        // ── BACK CARD with QR + dates ──
                                        RepaintBoundary(
                                          key: _backCardKey,
                                          child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: SizedBox(
                                            width: VirtualIdConfig.cardWidth,
                                            height: VirtualIdConfig.cardHeight,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: _buildCardBackground(
                                                    _backImageUrl,
                                                    VirtualIdConfig.backCardImage,
                                                    _backBlurhash,
                                                  ),
                                                ),
                                                // QR Code (left-bottom)
                                                Positioned(
                                                  left: VirtualIdConfig.qrX,
                                                  top: VirtualIdConfig.qrY,
                                                  child: Container(
                                                    width: VirtualIdConfig.qrSize,
                                                    height: VirtualIdConfig.qrSize,
                                                    padding: EdgeInsets.all(2.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(4.0),
                                                    ),
                                                    child: BarcodeWidget(
                                                      data:
                                                          '${columnMyVirtualIDRecord?.fullName ?? 'NA'} (${columnMyVirtualIDRecord?.idNumber ?? 'NA'}) - ${columnMyVirtualIDRecord?.college ?? 'NA'} ${columnMyVirtualIDRecord?.studyLevel ?? 'NA'}',
                                                      barcode: Barcode.qrCode(),
                                                      color: Color(0xFF15161E),
                                                      backgroundColor:
                                                          Colors.white,
                                                      errorBuilder:
                                                          (_context, _error) =>
                                                              SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                                // Issued Date
                                                Positioned(
                                                  left: VirtualIdConfig.issuedDateX,
                                                  top: VirtualIdConfig.issuedDateY,
                                                  child: _buildDateText(
                                                    _formatIssuedDate(columnMyVirtualIDRecord?.createdAt),
                                                  ),
                                                ),
                                                // Expiry Date
                                                Positioned(
                                                  left: VirtualIdConfig.expiryDateX,
                                                  top: VirtualIdConfig.expiryDateY,
                                                  child: _buildDateText(
                                                    _formatExpiryDate(columnMyVirtualIDRecord?.createdAt),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // ── Student Information heading ──
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      7.0, 12.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'Student Information',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Figtree',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ── Student Information fields ──
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 14.0, 0.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Full Name',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Figtree',
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                columnMyVirtualIDRecord
                                                    ?.fullName,
                                                'NA',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Figtree',
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'ID Number',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.idNumber,
                                          'NA',
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'Gender',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.gender,
                                          'NA',
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'College',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.college,
                                          'NA',
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'Study Level (Department)',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.studyLevel,
                                          'NA',
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'Admission',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.admission,
                                          'NA',
                                        ),
                                      ),
                                      _buildInfoField(
                                        context,
                                        'Phone No.',
                                        valueOrDefault<String>(
                                          columnMyVirtualIDRecord?.phoneNo,
                                          'NA',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ── Download & Delete buttons ──
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 36.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 8.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(16.0),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.info_outline,
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          size: 40.0,
                                                        ),
                                                        SizedBox(height: 12.0),
                                                        Text(
                                                          'Disclaimer',
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Text(
                                                          'This Virtual ID is a feature designed to allow students to hold a digital copy of their university-issued ID. This feature was built through the contribution of our online community. We do not take responsibility or credit for any misuse of generated IDs.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Figtree',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                        ),
                                                        SizedBox(height: 20.0),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                dialogContext);
                                                            await _saveCardToGallery(
                                                                _frontCardKey,
                                                                'Virtual_ID_Front');
                                                            await _saveCardToGallery(
                                                                _backCardKey,
                                                                'Virtual_ID_Back');
                                                            if (context.mounted) {
                                                              ScaffoldMessenger.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'ID cards saved to gallery'),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          text:
                                                              'Save to Gallery',
                                                          icon: Icon(
                                                            Icons
                                                                .save_alt_rounded,
                                                            size: 18.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 48.0,
                                                            color:
                                                                FlutterFlowTheme
                                                                        .of(
                                                                            context)
                                                                    .primary,
                                                            textStyle:
                                                                FlutterFlowTheme
                                                                        .of(
                                                                            context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Figtree',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: ' Download    ',
                                          icon: FaIcon(
                                            FontAwesomeIcons.download,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                            iconPadding: EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      AlignmentDirectional(
                                                              0.0, 0.0)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: WebViewAware(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        FocusScope.of(
                                                                dialogContext)
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                      },
                                                      child:
                                                          DeleteVirtualIDWidget(
                                                        vritualIDRef:
                                                            columnMyVirtualIDRecord!
                                                                .reference,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          text: 'Delete This Card',
                                          icon: Icon(
                                            Icons.delete,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  /// Captures a widget by its GlobalKey and saves to gallery.
  Future<void> _saveCardToGallery(GlobalKey key, String name) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final pngBytes = byteData.buffer.asUint8List();
      await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(pngBytes),
        quality: 100,
        name: name,
      );
    } catch (e) {
      debugPrint('Error saving card: $e');
    }
  }
}
