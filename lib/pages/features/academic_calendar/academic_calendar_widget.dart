import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'academic_calendar_model.dart';
export 'academic_calendar_model.dart';

class AcademicCalendarWidget extends StatefulWidget {
  const AcademicCalendarWidget({super.key});

  @override
  State<AcademicCalendarWidget> createState() => _AcademicCalendarWidgetState();
}

class _AcademicCalendarWidgetState extends State<AcademicCalendarWidget> {
  late AcademicCalendarModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AcademicCalendarModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color _categoryColor(BuildContext context, String category) {
    switch (category.toLowerCase()) {
      case 'registration':
        return Color(0xFF4CAF50);
      case 'exam':
        return Color(0xFFE53935);
      case 'holiday':
        return Color(0xFFFF9800);
      case 'academic':
        return FlutterFlowTheme.of(context).primary;
      default:
        return FlutterFlowTheme.of(context).secondaryText;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'registration':
        return Icons.app_registration_rounded;
      case 'exam':
        return Icons.quiz_rounded;
      case 'holiday':
        return Icons.celebration_rounded;
      case 'academic':
        return Icons.school_rounded;
      default:
        return Icons.event_rounded;
    }
  }

  String _formatDateRange(AcademicEventStruct event) {
    final df = DateFormat('MMM d');
    final dfYear = DateFormat('MMM d, y');
    if (!event.hasDateStart()) return 'TBD';
    final start = event.dateStart!;
    if (!event.hasDateEnd()) return dfYear.format(start);
    final end = event.dateEnd!;
    if (start.year == end.year && start.month == end.month &&
        start.day == end.day) {
      return dfYear.format(start);
    }
    if (start.year == end.year) {
      return '${df.format(start)} - ${dfYear.format(end)}';
    }
    return '${dfYear.format(start)} - ${dfYear.format(end)}';
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'AcademicCalendar',
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
                padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 0.0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Academic Calendar',
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
                          'Events and important dates',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                fontFamily: 'Figtree',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: StreamBuilder<List<AcademicEventRecord>>(
                  stream: queryAcademicEventRecord(
                    queryBuilder: (q) => q.orderBy('year', descending: true),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      );
                    }

                    final records = snapshot.data!;
                    if (records.isEmpty) {
                      return _buildEmptyState();
                    }

                    // Select first year by default
                    final years = records.map((r) => r.year).toList();
                    if (_selectedYear == null ||
                        !years.contains(_selectedYear)) {
                      _selectedYear = years.first;
                    }

                    final selectedRecord = records
                        .firstWhere((r) => r.year == _selectedYear);
                    final events = selectedRecord.events
                        .toList()
                      ..sort((a, b) {
                        if (!a.hasDateStart()) return 1;
                        if (!b.hasDateStart()) return -1;
                        return a.dateStart!.compareTo(b.dateStart!);
                      });

                    return Column(
                      children: [
                        // Year tabs
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: SizedBox(
                            height: 40.0,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: years.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 8.0),
                              itemBuilder: (context, index) {
                                final year = years[index];
                                final isSelected = year == _selectedYear;
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () =>
                                      safeSetState(() => _selectedYear = year),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? FlutterFlowTheme.of(context)
                                              .primary
                                          : FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: isSelected
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      year,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Figtree',
                                            color: isSelected
                                                ? Colors.white
                                                : FlutterFlowTheme.of(
                                                        context)
                                                    .primaryText,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Event count
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 12.0, 20.0, 4.0),
                          child: Row(
                            children: [
                              Text(
                                '${events.length} event${events.length == 1 ? '' : 's'}',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: 'Figtree',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Events list
                        Expanded(
                          child: events.isEmpty
                              ? Center(
                                  child: Text(
                                    'No events for this year yet.',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 8.0, 16.0, 32.0),
                                  itemCount: events.length,
                                  itemBuilder: (context, index) {
                                    final event = events[index];
                                    return _buildEventCard(context, event);
                                  },
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
    );
  }

  Widget _buildEventCard(BuildContext context, AcademicEventStruct event) {
    final color = _categoryColor(context, event.category);
    final icon = _categoryIcon(event.category);
    final categoryLabel = event.category.isEmpty
        ? 'Event'
        : event.category[0].toUpperCase() + event.category.substring(1);

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color:
                FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.5),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category icon
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(icon, color: color, size: 20.0),
              ),
              SizedBox(width: 12.0),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 13.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryText,
                        ),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            _formatDateRange(event),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            categoryLabel,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: color,
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
      ),
    );
  }

  Widget _buildEmptyState() {
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
                    .primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_month_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 40.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'No Calendar Data',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Academic calendar events will appear here once published.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Figtree',
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
