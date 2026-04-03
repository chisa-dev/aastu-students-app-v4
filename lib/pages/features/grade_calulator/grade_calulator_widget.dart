import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/course_inpute_field/course_inpute_field_widget.dart';
import '/components/credit_hour_input_field/credit_hour_input_field_widget.dart';
import '/components/delete_grade_history/delete_grade_history_widget.dart';
import '/components/empty_list_grade/empty_list_grade_widget.dart';
import '/components/grade_drop_down/grade_drop_down_widget.dart';
import '/components/save_gpa_component/save_gpa_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '/backend/gemini/gemini_service.dart';
import 'grade_calulator_model.dart';
export 'grade_calulator_model.dart';

class GradeCalulatorWidget extends StatefulWidget {
  const GradeCalulatorWidget({super.key});

  @override
  State<GradeCalulatorWidget> createState() => _GradeCalulatorWidgetState();
}

class _GradeCalulatorWidgetState extends State<GradeCalulatorWidget> {
  late GradeCalulatorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradeCalulatorModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  String _getGradeLetter(double gpa) {
    if (gpa >= 3.75) return 'A';
    if (gpa >= 3.5) return 'A-';
    if (gpa >= 3.0) return 'B+';
    if (gpa >= 2.75) return 'B';
    if (gpa >= 2.5) return 'B-';
    if (gpa >= 2.25) return 'C+';
    if (gpa >= 2.0) return 'C';
    if (gpa >= 1.5) return 'D';
    return 'F';
  }

  String _getGradeStatus(double gpa) {
    if (gpa >= 3.5) return 'Excellent';
    if (gpa >= 3.0) return 'Very Good';
    if (gpa >= 2.5) return 'Good';
    if (gpa >= 2.0) return 'Satisfactory';
    if (gpa >= 1.5) return 'Needs Improvement';
    return 'Failing';
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.5) return const Color(0xFF0B6B41);
    if (gpa >= 3.0) return const Color(0xFF1A7E5A);
    if (gpa >= 2.5) return const Color(0xFF1565C0);
    if (gpa >= 2.0) return const Color(0xFFE65100);
    return const Color(0xFFC62828);
  }

  Future<void> _fetchInsights() async {
    if (_model.isLoadingInsight) return;
    _model.isLoadingInsight = true;
    _model.insightText = null;
    safeSetState(() {});

    final courses = FFAppState().MyGPAList.map((e) => {
      'course': e.course,
      'creditHour': e.creditHour.toString(),
      'grade': e.grade,
    }).toList();

    final text = await GeminiService.instance.generateGpaInsights(
      gpa: _model.results?.gpa ?? '0',
      totalCourses: _model.results?.totalCourses ?? 0,
      totalCreditHour: _model.results?.totalCreditHour ?? 0,
      courses: courses,
    );

    _model.insightText = text;
    _model.isLoadingInsight = false;
    safeSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
        title: 'grade_calulator',
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
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 0.0),
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Grade Calculator',
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
                                Text(
                                  'Calculate your GPA',
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
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: valueOrDefault<double>(
                              () {
                                if (MediaQuery.sizeOf(context).width <
                                    kBreakpointSmall) {
                                  return double.infinity;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointMedium) {
                                  return double.infinity;
                                } else if (MediaQuery.sizeOf(context).width <
                                    kBreakpointLarge) {
                                  return 500.0;
                                } else {
                                  return double.infinity;
                                }
                              }(),
                              500.0,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 50.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 20.0, 12.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Header row with reset button
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 4.0, 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Courses',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async {
                                                  FFAppState().MyGPAList = [];
                                                  FFAppState().gradeIndex = 1;
                                                  safeSetState(() {});
                                                  _model.showResult = false;
                                                  safeSetState(() {});
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.replay,
                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                      size: 18.0,
                                                    ),
                                                    SizedBox(width: 4.0),
                                                    Text(
                                                      'Reset',
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily: 'Figtree',
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Column headers
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              4.0, 0.0, 4.0, 6.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Course Name',
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 68.0,
                                                child: Text(
                                                  'CrHr',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(width: 6.0),
                                              SizedBox(
                                                width: 72.0,
                                                child: Text(
                                                  'Grade',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Course rows
                                        Builder(
                                          builder: (context) {
                                            final gpaList = FFAppState()
                                                .MyGPAList
                                                .toList();

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: gpaList.length,
                                              itemBuilder: (context, gpaListIndex) {
                                                final gpaListItem = gpaList[gpaListIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                      0.0, 4.0, 0.0, 4.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: CourseInputeFieldWidget(
                                                          key: Key('Key0hr_${gpaListIndex}_of_${gpaList.length}'),
                                                          value: gpaListItem.course,
                                                          index: gpaListIndex,
                                                        ),
                                                      ),
                                                      SizedBox(width: 6.0),
                                                      CreditHourInputFieldWidget(
                                                        key: Key('Keyeg5_${gpaListIndex}_of_${gpaList.length}'),
                                                        value: gpaListItem.creditHour,
                                                        index: gpaListIndex,
                                                      ),
                                                      SizedBox(width: 6.0),
                                                      GradeDropDownWidget(
                                                        key: Key('Keyod1_${gpaListIndex}_of_${gpaList.length}'),
                                                        value: gpaListItem.grade,
                                                        index: gpaListIndex,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        // Add course button
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              FFAppState().addToMyGPAList(
                                                  MyGPAStruct(
                                                course: 'Course ${FFAppState().gradeIndex.toString()}',
                                                creditHour: 4,
                                                grade: 'A',
                                              ));
                                              FFAppState().gradeIndex =
                                                  FFAppState().gradeIndex + 1;
                                              safeSetState(() {});
                                            },
                                            text: 'Add Course',
                                            icon: Icon(
                                              Icons.add_rounded,
                                              size: 20.0,
                                              color: FlutterFlowTheme.of(context).primary,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              color: Colors.transparent,
                                              textStyle: FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Figtree',
                                                    color: FlutterFlowTheme.of(context).primary,
                                                    letterSpacing: 0.0,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).primary,
                                                width: 1.5,
                                              ),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await Future.delayed(
                                            const Duration(milliseconds: 400));
                                        _model.results =
                                            await actions.calculateGrade(
                                          FFAppState().MyGPAList.toList(),
                                        );
                                        _model.showResult = true;
                                        _model.colorIndex = valueOrDefault<int>(
                                          random_data.randomInteger(0, 3),
                                          0,
                                        );
                                        safeSetState(() {});

                                        safeSetState(() {});
                                      },
                                      text: 'Calculate Result',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
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
                                  if (_model.showResult)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                                      child: Builder(builder: (context) {
                                        final gpaValue = functions.stringToDouble(_model.results?.gpa ?? '0');
                                        final gradeLetter = _getGradeLetter(gpaValue);
                                        final gradeStatus = _getGradeStatus(gpaValue);
                                        final bannerColor = _getGpaColor(gpaValue);
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                            borderRadius: BorderRadius.circular(16.0),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 12.0,
                                                color: Color(0x18000000),
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: FlutterFlowTheme.of(context).alternate,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // ── Banner ──
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
                                                decoration: BoxDecoration(
                                                  color: bannerColor,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(16.0),
                                                    topRight: Radius.circular(16.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Semester Result',
                                                      style: TextStyle(
                                                        fontFamily: 'Figtree',
                                                        fontSize: 13.0,
                                                        color: Colors.white70,
                                                        letterSpacing: 1.2,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          _model.results?.gpa ?? 'N/A',
                                                          style: TextStyle(
                                                            fontFamily: 'Figtree',
                                                            fontSize: 52.0,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w800,
                                                            height: 1.0,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.0),
                                                        Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                          margin: EdgeInsets.only(bottom: 6.0),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white24,
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            border: Border.all(color: Colors.white38, width: 1.0),
                                                          ),
                                                          child: Text(
                                                            gradeLetter,
                                                            style: TextStyle(
                                                              fontFamily: 'Figtree',
                                                              fontSize: 20.0,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius: BorderRadius.circular(20.0),
                                                      ),
                                                      child: Text(
                                                        gradeStatus,
                                                        style: TextStyle(
                                                          fontFamily: 'Figtree',
                                                          fontSize: 13.0,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // ── Stats row ──
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: _StatChip(
                                                        label: 'Courses',
                                                        value: (_model.results?.totalCourses ?? 0).toString(),
                                                        icon: Icons.book_outlined,
                                                        color: FlutterFlowTheme.of(context).primary,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    Expanded(
                                                      child: _StatChip(
                                                        label: 'Credit Hrs',
                                                        value: (_model.results?.totalCreditHour ?? 0).toString(),
                                                        icon: Icons.access_time_rounded,
                                                        color: bannerColor,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    Expanded(
                                                      child: _StatChip(
                                                        label: 'Status',
                                                        value: gpaValue >= 2.0 ? 'Pass' : 'Fail',
                                                        icon: gpaValue >= 2.0 ? Icons.check_circle_outline : Icons.cancel_outlined,
                                                        color: gpaValue >= 2.0 ? Color(0xFF0B6B41) : Color(0xFFC62828),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 1.0,
                                                thickness: 1.0,
                                                indent: 16.0,
                                                endIndent: 16.0,
                                                color: FlutterFlowTheme.of(context).alternate,
                                              ),
                                              // ── Action buttons ──
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton.icon(
                                                        onPressed: _model.isLoadingInsight ? null : _fetchInsights,
                                                        icon: _model.isLoadingInsight
                                                            ? SizedBox(
                                                                width: 14.0,
                                                                height: 14.0,
                                                                child: CircularProgressIndicator(
                                                                  strokeWidth: 2.0,
                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                    FlutterFlowTheme.of(context).primary,
                                                                  ),
                                                                ),
                                                              )
                                                            : Icon(Icons.auto_awesome_rounded, size: 16.0),
                                                        label: Text(
                                                          _model.isLoadingInsight ? 'Loading...' : 'AI Insights',
                                                          style: TextStyle(
                                                            fontFamily: 'Figtree',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: OutlinedButton.styleFrom(
                                                          foregroundColor: FlutterFlowTheme.of(context).primary,
                                                          side: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                                          padding: EdgeInsets.symmetric(vertical: 10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Builder(
                                                      builder: (context) => ElevatedButton.icon(
                                                        onPressed: () async {
                                                          await showDialog(
                                                            context: context,
                                                            builder: (dialogContext) {
                                                              return Dialog(
                                                                elevation: 0,
                                                                insetPadding: EdgeInsets.zero,
                                                                backgroundColor: Colors.transparent,
                                                                alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                child: WebViewAware(
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(dialogContext).unfocus();
                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                    },
                                                                    child: SaveGpaComponentWidget(
                                                                      result: _model.results,
                                                                      gpa: FFAppState().MyGPAList,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(Icons.cloud_upload_outlined, size: 16.0),
                                                        label: Text(
                                                          'Save',
                                                          style: TextStyle(
                                                            fontFamily: 'Figtree',
                                                            fontSize: 13.0,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: bannerColor,
                                                          foregroundColor: Colors.white,
                                                          elevation: 0,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // ── AI Insights panel ──
                                              if (_model.insightText != null && _model.insightText!.isNotEmpty)
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(14.0),
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(
                                                        color: FlutterFlowTheme.of(context).alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.auto_awesome_rounded,
                                                              size: 15.0,
                                                              color: FlutterFlowTheme.of(context).primary,
                                                            ),
                                                            SizedBox(width: 6.0),
                                                            Text(
                                                              'AI Insights',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    fontFamily: 'Figtree',
                                                                    fontWeight: FontWeight.w700,
                                                                    letterSpacing: 0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        Text(
                                                          _model.insightText!,
                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                fontFamily: 'Figtree',
                                                                letterSpacing: 0.0,
                                                              ).copyWith(height: 1.5),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 30.0, 16.0, 0.0),
                                    child: StreamBuilder<List<GradeRecord>>(
                                      stream: queryGradeRecord(
                                        queryBuilder: (gradeRecord) =>
                                            gradeRecord.where(
                                          'id',
                                          isEqualTo: currentUserUid,
                                        ),
                                        singleRecord: true,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<GradeRecord>
                                            columnGradeRecordList =
                                            snapshot.data!;
                                        // Return an empty Container when the item does not exist.
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final columnGradeRecord =
                                            columnGradeRecordList.isNotEmpty
                                                ? columnGradeRecordList.first
                                                : null;

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'My Grade',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                StreamBuilder<
                                                    List<MyGradeRecord>>(
                                                  stream: queryMyGradeRecord(
                                                    parent: columnGradeRecord
                                                        ?.reference,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
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
                                                      );
                                                    }
                                                    List<MyGradeRecord>
                                                        containerMyGradeRecordList =
                                                        snapshot.data!;

                                                    return Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: RichText(
                                                        textScaler:
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaler,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: '(CGPA) ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Figtree',
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                functions
                                                                    .calculateCGPAFunction(
                                                                        containerMyGradeRecordList
                                                                            .toList())
                                                                    .toString(),
                                                                'NA',
                                                              ),
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Figtree',
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            StreamBuilder<List<MyGradeRecord>>(
                                              stream: queryMyGradeRecord(
                                                parent: columnGradeRecord
                                                    ?.reference,
                                                queryBuilder: (myGradeRecord) =>
                                                    myGradeRecord
                                                        .orderBy('created_at'),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
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
                                                  );
                                                }
                                                List<MyGradeRecord>
                                                    listViewMyGradeRecordList =
                                                    snapshot.data!;
                                                if (listViewMyGradeRecordList
                                                    .isEmpty) {
                                                  return Center(
                                                    child:
                                                        EmptyListGradeWidget(),
                                                  );
                                                }

                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      listViewMyGradeRecordList
                                                          .length,
                                                  itemBuilder:
                                                      (context, listViewIndex) {
                                                    final listViewMyGradeRecord =
                                                        listViewMyGradeRecordList[
                                                            listViewIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x19000000),
                                                              offset: Offset(
                                                                0.0,
                                                                2.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                color: Color(
                                                                    0x00000000),
                                                                child:
                                                                    ExpandableNotifier(
                                                                  initialExpanded:
                                                                      false,
                                                                  child:
                                                                      ExpandablePanel(
                                                                    header:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          12.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        listViewMyGradeRecord
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Figtree',
                                                                              fontSize: 17.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    collapsed:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          12.0, 4.0, 44.0, 12.0),
                                                                      child: Row(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        children: [
                                                                          // GPA chip
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                                                            decoration: BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Text(
                                                                                  listViewMyGradeRecord.gpa,
                                                                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                        fontFamily: 'Figtree',
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w800,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  'GPA',
                                                                                  style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                        fontFamily: 'Figtree',
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10.0),
                                                                          Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Icon(Icons.access_time_rounded, size: 13.0, color: FlutterFlowTheme.of(context).secondaryText),
                                                                                  SizedBox(width: 4.0),
                                                                                  Text(
                                                                                    '${listViewMyGradeRecord.totalCreditHour} Credit Hours',
                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                          fontFamily: 'Figtree',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(height: 4.0),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(Icons.book_outlined, size: 13.0, color: FlutterFlowTheme.of(context).secondaryText),
                                                                                  SizedBox(width: 4.0),
                                                                                  Text(
                                                                                    '${listViewMyGradeRecord.totalCourses} Courses',
                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                          fontFamily: 'Figtree',
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    expanded:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          12.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // Table header
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderRadius: BorderRadius.circular(6.0),
                                                                            ),
                                                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    'Course',
                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          fontFamily: 'Figtree',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 52.0,
                                                                                  child: Text(
                                                                                    'CrHr',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          fontFamily: 'Figtree',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 52.0,
                                                                                  child: Text(
                                                                                    'Grade',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                          fontFamily: 'Figtree',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // Table rows
                                                                          Builder(
                                                                            builder: (context) {
                                                                              final detailCoursesList = listViewMyGradeRecord.detailList.toList();
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: List.generate(detailCoursesList.length, (detailCoursesListIndex) {
                                                                                  final detailCoursesListItem = detailCoursesList[detailCoursesListIndex];
                                                                                  final isEven = detailCoursesListIndex % 2 == 0;
                                                                                  return Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: isEven
                                                                                          ? Colors.transparent
                                                                                          : FlutterFlowTheme.of(context).primaryBackground.withValues(alpha: 0.5),
                                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                                    ),
                                                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(detailCoursesListItem.course, 'Course'),
                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                  fontFamily: 'Figtree',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 52.0,
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(detailCoursesListItem.creditHour.toString(), '0'),
                                                                                            textAlign: TextAlign.center,
                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                  fontFamily: 'Figtree',
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 52.0,
                                                                                          child: Container(
                                                                                            alignment: Alignment.center,
                                                                                            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
                                                                                              borderRadius: BorderRadius.circular(4.0),
                                                                                            ),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(detailCoursesListItem.grade, '-'),
                                                                                              textAlign: TextAlign.center,
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    fontFamily: 'Figtree',
                                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                                    fontWeight: FontWeight.w700,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                              );
                                                                            },
                                                                          ),
                                                                          Divider(
                                                                            thickness: 1.0,
                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                          ),
                                                                          // Summary footer
                                                                          Padding(
                                                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      'GPA: ',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Figtree',
                                                                                            fontWeight: FontWeight.w700,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      listViewMyGradeRecord.gpa,
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Figtree',
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            fontWeight: FontWeight.w700,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      'Total CrHr: ',
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Figtree',
                                                                                            fontWeight: FontWeight.w700,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                    Text(
                                                                                      listViewMyGradeRecord.totalCreditHour.toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            fontFamily: 'Figtree',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    theme:
                                                                        ExpandableThemeData(
                                                                      tapHeaderToExpand:
                                                                          true,
                                                                      tapBodyToExpand:
                                                                          true,
                                                                      tapBodyToCollapse:
                                                                          true,
                                                                      headerAlignment:
                                                                          ExpandablePanelHeaderAlignment
                                                                              .top,
                                                                      hasIcon:
                                                                          true,
                                                                      iconSize:
                                                                          34.0,
                                                                      iconColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.0,
                                                                      -1.0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) =>
                                                                        Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          50.0,
                                                                          14.0,
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
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                WebViewAware(
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  FocusScope.of(dialogContext).unfocus();
                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                },
                                                                                child: DeleteGradeHistoryWidget(
                                                                                  mygradeRef: listViewMyGradeRecord.reference,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete_outline_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.0, color: color),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Figtree',
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Figtree',
              fontSize: 11.0,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
