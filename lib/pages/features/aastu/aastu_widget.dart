import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'aastu_model.dart';
export 'aastu_model.dart';

class AastuWidget extends StatefulWidget {
  const AastuWidget({super.key});

  @override
  State<AastuWidget> createState() => _AastuWidgetState();
}

class _AastuWidgetState extends State<AastuWidget> {
  late AastuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AastuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'AASTU',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    automaticallyImplyLeading: false,
                    leading: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                    actions: [],
                    centerTitle: true,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: StreamBuilder<List<AboutAastuRecord>>(
                stream: queryAboutAastuRecord(singleRecord: true),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  final aboutAastuRecords = snapshot.data ?? [];
                  final aboutAastuRecord = aboutAastuRecords.isNotEmpty
                      ? aboutAastuRecords.first
                      : null;

                  // Resolve fields with fallback to hardcoded defaults.
                  final title = (aboutAastuRecord != null &&
                          aboutAastuRecord.title.isNotEmpty)
                      ? aboutAastuRecord.title
                      : 'Addis Ababa Science and Technology University';
                  final established = (aboutAastuRecord != null &&
                          aboutAastuRecord.established.isNotEmpty)
                      ? aboutAastuRecord.established
                      : 'Est 2011 GC ';
                  final history = (aboutAastuRecord != null &&
                          aboutAastuRecord.history.isNotEmpty)
                      ? aboutAastuRecord.history
                      : 'Addis Ababa Science and Technology University (AASTU) was established in 2011. AASTU is the first University to be established as a specialized institution for science and technology in the history of Ethiopia. Due to the special attention given for AASTU by the Ethiopian government, the university is accountable to the F.D.R.E Ministry of Science and Technology.';
                  final vision = (aboutAastuRecord != null &&
                          aboutAastuRecord.vision.isNotEmpty)
                      ? aboutAastuRecord.vision
                      : 'The university has a vision to be "an internationally recognized and respected hub of science and technology with strong national commitment and significant continental repute by 2025"';
                  final bannerImage = (aboutAastuRecord != null &&
                          aboutAastuRecord.bannerImage.isNotEmpty)
                      ? aboutAastuRecord.bannerImage
                      : '';
                  final logoImage = (aboutAastuRecord != null &&
                          aboutAastuRecord.logoImage.isNotEmpty)
                      ? aboutAastuRecord.logoImage
                      : '';
                  final locationTitle = (aboutAastuRecord != null &&
                          aboutAastuRecord.locationTitle.isNotEmpty)
                      ? aboutAastuRecord.locationTitle
                      : 'Akaki Kality, Wereda 08,';
                  final locationSubtitle = (aboutAastuRecord != null &&
                          aboutAastuRecord.locationSubtitle.isNotEmpty)
                      ? aboutAastuRecord.locationSubtitle
                      : 'Addis Ababa, Ethiopia';
                  final latitude = (aboutAastuRecord != null &&
                          aboutAastuRecord.hasLatitude())
                      ? aboutAastuRecord.latitude
                      : 8.88553639408486;
                  final longitude = (aboutAastuRecord != null &&
                          aboutAastuRecord.hasLongitude())
                      ? aboutAastuRecord.longitude
                      : 38.80966756395657;
                  final websiteUrl = (aboutAastuRecord != null &&
                          aboutAastuRecord.websiteUrl.isNotEmpty)
                      ? aboutAastuRecord.websiteUrl
                      : 'http://www.aastu.edu.et/';
                  final officialsYear = (aboutAastuRecord != null &&
                          aboutAastuRecord.officialsYear.isNotEmpty)
                      ? aboutAastuRecord.officialsYear
                      : '2024';
                  final officials = (aboutAastuRecord != null &&
                          aboutAastuRecord.officials.isNotEmpty)
                      ? aboutAastuRecord.officials
                      : <OfficialStruct>[];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  constraints: BoxConstraints(
                                    maxWidth: 570.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            title,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        // Banner + Logo stack
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: bannerImage.isNotEmpty
                                                    ? CachedNetworkImage(
                                                        imageUrl: bannerImage,
                                                        width: double.infinity,
                                                        height: 230.0,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          'assets/images/aastu.jpg',
                                                          width:
                                                              double.infinity,
                                                          height: 230.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/aastu.jpg',
                                                        width: double.infinity,
                                                        height: 230.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(
                                                      1.0, 1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 180.0, 4.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: logoImage.isNotEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: logoImage,
                                                          width: 50.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment(
                                                              1.0, 1.0),
                                                          placeholder:
                                                              (context, url) =>
                                                                  SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'assets/images/images_(2).png',
                                                            width: 50.0,
                                                            height: 50.0,
                                                            fit: BoxFit.cover,
                                                            alignment:
                                                                Alignment(
                                                                    1.0, 1.0),
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          'assets/images/images_(2).png',
                                                          width: 50.0,
                                                          height: 50.0,
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment(
                                                              1.0, 1.0),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // History heading
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            'History',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        // Established
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 4.0, 0.0, 0.0),
                                          child: Text(
                                            established,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Figtree',
                                                  color:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        // History text
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 12.0),
                                          child: Text(
                                            history,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Figtree',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        // Vision text
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            vision,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Figtree',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        // Location card
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              maxWidth: 570.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                16.0, 4.0),
                                                    child: Text(
                                                      'Location',
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
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: Text(
                                                      locationTitle,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 12.0),
                                                    child: Text(
                                                      locationSubtitle,
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
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchMap(
                                                              location: LatLng(
                                                                  latitude,
                                                                  longitude),
                                                              title: title,
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 32.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Open Map',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Figtree',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Officials heading
                                        Text(
                                          'Officials ($officialsYear)',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'Figtree',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        // Officials list
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 32.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: officials.isNotEmpty
                                                  ? officials
                                                      .map((official) =>
                                                          _buildOfficialColumn(
                                                              context,
                                                              official))
                                                      .toList()
                                                  : [
                                                      // Fallback hardcoded officials
                                                      _buildFallbackOfficialColumn(
                                                        context,
                                                        'assets/images/Screenshot_2024-10-27_102051.png',
                                                        'Dr Dereje Engida',
                                                        'President',
                                                      ),
                                                      _buildFallbackOfficialColumn(
                                                        context,
                                                        'assets/images/Screenshot_2024-10-27_103218.png',
                                                        'Kemal Ibrahim',
                                                        'VP Academic Affairs',
                                                      ),
                                                      _buildFallbackOfficialColumn(
                                                        context,
                                                        'assets/images/60.5659.jpg',
                                                        'Dr. Abraham Debebe',
                                                        'VP Research & TT',
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
                            ],
                          ),
                        ),
                      ),
                      // Website button
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 8.0, 16.0, 12.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await launchURL(websiteUrl);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).accent1,
                                width: 2.0,
                              ),
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Visit Website',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Figtree',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }

  /// Builds a column for a single official from Firestore data.
  Widget _buildOfficialColumn(BuildContext context, OfficialStruct official) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 12.0, 2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: official.photoUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: official.photoUrl,
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 80.0,
                      height: 80.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80.0,
                      height: 80.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Icon(
                        Icons.person,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 40.0,
                      ),
                    ),
                  )
                : Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      Icons.person,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 40.0,
                    ),
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
          child: Text(
            official.name,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Text(
          official.title,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                fontSize: 12.0,
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }

  /// Builds a fallback official column using local assets.
  Widget _buildFallbackOfficialColumn(
    BuildContext context,
    String assetPath,
    String name,
    String title,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 12.0, 2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              assetPath,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
          child: Text(
            name,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Text(
          title,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                fontSize: 12.0,
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }
}
