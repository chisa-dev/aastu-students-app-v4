import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'grading_system_model.dart';
export 'grading_system_model.dart';

class _GradeEntry {
  final int minMark;
  final int maxMark;
  final String range;
  final String letter;
  final double point;
  final String status;
  final Color Function(BuildContext) color;

  const _GradeEntry({
    required this.minMark,
    required this.maxMark,
    required this.range,
    required this.letter,
    required this.point,
    required this.status,
    required this.color,
  });
}

final _gradeTable = <_GradeEntry>[
  _GradeEntry(minMark: 90, maxMark: 100, range: '90 – 100', letter: 'A+', point: 4.0, status: 'Excellent', color: (c) => Color(0xFF2E7D32)),
  _GradeEntry(minMark: 85, maxMark: 89, range: '85 – 89', letter: 'A', point: 4.0, status: 'Excellent', color: (c) => Color(0xFF388E3C)),
  _GradeEntry(minMark: 80, maxMark: 84, range: '80 – 84', letter: 'A-', point: 3.75, status: 'Very Good', color: (c) => Color(0xFF43A047)),
  _GradeEntry(minMark: 75, maxMark: 79, range: '75 – 79', letter: 'B+', point: 3.5, status: 'Very Good', color: (c) => Color(0xFF66BB6A)),
  _GradeEntry(minMark: 70, maxMark: 74, range: '70 – 74', letter: 'B', point: 3.0, status: 'Good', color: (c) => Color(0xFFFFA726)),
  _GradeEntry(minMark: 65, maxMark: 69, range: '65 – 69', letter: 'B-', point: 2.75, status: 'Good', color: (c) => Color(0xFFFF9800)),
  _GradeEntry(minMark: 50, maxMark: 64, range: '50 – 64', letter: 'C', point: 2.0, status: 'Satisfactory', color: (c) => Color(0xFFEF6C00)),
  _GradeEntry(minMark: 45, maxMark: 49, range: '45 – 49', letter: 'C-', point: 1.75, status: 'Unsatisfactory', color: (c) => Color(0xFFE53935)),
  _GradeEntry(minMark: 40, maxMark: 44, range: '40 – 44', letter: 'D', point: 1.0, status: 'Very Poor', color: (c) => Color(0xFFC62828)),
  _GradeEntry(minMark: 0, maxMark: 39, range: '0 – 39', letter: 'F', point: 0.0, status: 'Fail', color: (c) => Color(0xFFB71C1C)),
];

_GradeEntry _gradeForMark(double mark) {
  for (final entry in _gradeTable) {
    if (mark >= entry.minMark && mark <= entry.maxMark) return entry;
  }
  return _gradeTable.last;
}

class GradingSystemWidget extends StatefulWidget {
  const GradingSystemWidget({super.key});

  @override
  State<GradingSystemWidget> createState() => _GradingSystemWidgetState();
}

class _GradingSystemWidgetState extends State<GradingSystemWidget> {
  late GradingSystemModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  _GradeEntry? _playgroundGrade;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradingSystemModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _checkGrade() {
    final text = _model.markController?.text.trim() ?? '';
    if (text.isEmpty) {
      safeSetState(() => _playgroundGrade = null);
      return;
    }
    final mark = double.tryParse(text);
    if (mark == null || mark < 0 || mark > 100) {
      safeSetState(() => _playgroundGrade = null);
      return;
    }
    safeSetState(() => _playgroundGrade = _gradeForMark(mark));
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'GradingSystem',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: responsiveVisibility(
            context: context,
            tabletLandscape: false,
            desktop: false,
          )
              ? AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
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
                  title: Text(
                    'Grading System',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Outfit',
                          letterSpacing: 0.0,
                        ),
                  ),
                  centerTitle: false,
                  elevation: 0.0,
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Grade Playground --
                  _buildPlayground(context),
                  SizedBox(height: 24.0),

                  // -- Grading Table --
                  _buildSectionTitle(context, 'Grade Scale'),
                  SizedBox(height: 12.0),
                  _buildGradeTable(context),
                  SizedBox(height: 28.0),

                  // -- How it works --
                  _buildSectionTitle(context, 'How Grading Works'),
                  SizedBox(height: 12.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.school_rounded,
                    title: 'Good Standing',
                    body:
                        'A student who earned a 2.0 (C) grade or above in all courses of a semester shall be in good standing.',
                  ),
                  SizedBox(height: 10.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.replay_rounded,
                    title: 'Course Retake Limit',
                    body:
                        'A student cannot register a course for more than three times in any way.',
                  ),
                  SizedBox(height: 10.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.warning_amber_rounded,
                    title: 'Academic Dismissal',
                    body:
                        'Any consecutive warning leads to Academic Dismissal.',
                  ),
                  SizedBox(height: 28.0),

                  // -- First Year Students --
                  _buildSectionTitle(context, 'First Year Students'),
                  SizedBox(height: 12.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.dangerous_rounded,
                    title: 'Dismissal (1st Semester)',
                    body:
                        'A student who, at the end of the first semester, receives an SGPA of less than 1.50 shall be dismissed for academic reasons.',
                    accentColor: FlutterFlowTheme.of(context).error,
                  ),
                  SizedBox(height: 10.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.notification_important_rounded,
                    title: 'Warning (1st Semester)',
                    body:
                        'A student who scores an SGPA of 1.50 up to 1.74 (both inclusive) shall be warned.',
                    accentColor: Color(0xFFFF9800),
                  ),
                  SizedBox(height: 10.0),
                  _buildInfoCard(
                    context,
                    icon: Icons.gavel_rounded,
                    title: '2nd Semester After Warning',
                    body:
                        'If a warned student fails to maintain an SGPA of 1.75 or a CGPA of 2.00 during the second semester, they are subject to dismissal unless put on probation by the academic commission.',
                    accentColor: FlutterFlowTheme.of(context).error,
                  ),
                  SizedBox(height: 16.0),
                  // Source note
                  Text(
                    'Source: AASTU Student\'s Handbook',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Figtree',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: FlutterFlowTheme.of(context).titleMedium.override(
            fontFamily: 'Outfit',
            color: FlutterFlowTheme.of(context).primaryText,
            fontSize: 18.0,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildPlayground(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).primary.withValues(alpha: 0.8),
          ],
          begin: AlignmentDirectional(-1.0, -0.5),
          end: AlignmentDirectional(1.0, 0.5),
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Checker',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Figtree',
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Enter your mark to see your grade',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Figtree',
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: TextField(
                      controller: _model.markController,
                      focusNode: _model.markFocusNode,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,3}\.?\d{0,2}')),
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Figtree',
                            color: Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                      decoration: InputDecoration(
                        hintText: 'e.g. 85',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Figtree',
                                  color: Colors.white.withValues(alpha: 0.5),
                                  letterSpacing: 0.0,
                                ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            14.0, 0.0, 14.0, 0.0),
                      ),
                      onChanged: (_) => _checkGrade(),
                      onSubmitted: (_) => _checkGrade(),
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                InkWell(
                  onTap: _checkGrade,
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    height: 48.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        'Check',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_playgroundGrade != null) ...[
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: _playgroundGrade!.color(context),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          _playgroundGrade!.letter,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _playgroundGrade!.status,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Grade Point: ${_playgroundGrade!.point}',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: Colors.white.withValues(alpha: 0.8),
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGradeTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                _tableHeader(context, 'Mark %', flex: 2),
                _tableHeader(context, 'Grade', flex: 1),
                _tableHeader(context, 'Point', flex: 1),
                _tableHeader(context, 'Status', flex: 2),
              ],
            ),
          ),
          // Rows
          ...List.generate(_gradeTable.length, (index) {
            final entry = _gradeTable[index];
            final isLast = index == _gradeTable.length - 1;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 11.0),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: FlutterFlowTheme.of(context)
                              .alternate
                              .withValues(alpha: 0.5),
                          width: 0.5,
                        ),
                      ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.range,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: entry.color(context).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        entry.letter,
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'Figtree',
                                  color: entry.color(context),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      entry.point.toStringAsFixed(entry.point == 4.0 || entry.point == 3.0 || entry.point == 2.0 || entry.point == 1.0 || entry.point == 0.0 ? 1 : 2),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.status,
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Figtree',
                            color:
                                FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _tableHeader(BuildContext context, String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).labelSmall.override(
              fontFamily: 'Figtree',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.0,
            ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String body,
    Color? accentColor,
  }) {
    final color = accentColor ?? FlutterFlowTheme.of(context).primary;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 20.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Figtree',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
