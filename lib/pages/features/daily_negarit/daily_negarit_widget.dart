import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/features/components/add_note/add_note_widget.dart';
import '/pages/features/components/task_action/task_action_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/services/notification_service.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'daily_negarit_model.dart';
export 'daily_negarit_model.dart';

class DailyNegaritWidget extends StatefulWidget {
  const DailyNegaritWidget({super.key});

  @override
  State<DailyNegaritWidget> createState() => _DailyNegaritWidgetState();
}

class _DailyNegaritWidgetState extends State<DailyNegaritWidget>
    with SingleTickerProviderStateMixin {
  late DailyNegaritModel _model;
  late TabController _tabController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Cache the negarit record to avoid re-showing loading spinner
  DailyNegaritRecord? _cachedNegaritRecord;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyNegaritModel());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        safeSetState(() => _model.selectedTab = _tabController.index);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _model.dispose();
    super.dispose();
  }

  Color _categoryColor(BuildContext context, String category) {
    switch (category) {
      case 'assignment':
        return FFAppState().taskColors.assignement;
      case 'test':
        return FFAppState().taskColors.test;
      case 'other':
        return FFAppState().taskColors.other;
      default:
        return FlutterFlowTheme.of(context).primary;
    }
  }

  String _categoryLabel(String category) {
    if (category.isEmpty) return 'Other';
    return category[0].toUpperCase() + category.substring(1);
  }

  String _reminderLabel(int minutes) {
    if (minutes >= 60) return '${minutes ~/ 60}h before';
    return '${minutes}m before';
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Title(
      title: 'DailyNegarit',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Color(0x00000000),
                barrierColor: FlutterFlowTheme.of(context).accent4,
                context: context,
                builder: (context) {
                  return WebViewAware(
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: AddNoteWidget(),
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 4.0,
            icon: Icon(Icons.add_rounded, color: Colors.white, size: 24.0),
            label: Text(
              'New Task',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Figtree',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 900.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 18.0, 16.0, 0.0),
                      child: Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => context.goNamed('home'),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryText,
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
                                  'Daily Negarit',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: false,
                                      ),
                                ),
                                Text(
                                  'Manage your tasks and reminders',
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
                    // Tab bar
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 0.0),
                      child: Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor:
                              FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                          unselectedLabelStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.0,
                              ),
                          indicator: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.all(3.0),
                          dividerHeight: 0,
                          tabs: [
                            Tab(text: 'Upcoming'),
                            Tab(text: 'Completed'),
                          ],
                        ),
                      ),
                    ),
                    // Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildTaskList(completed: false),
                          _buildTaskList(completed: true),
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
    );
  }

  Widget _buildTaskList({required bool completed}) {
    return StreamBuilder<List<DailyNegaritRecord>>(
      stream: queryDailyNegaritRecord(
        queryBuilder: (dailyNegaritRecord) => dailyNegaritRecord.where(
          'id',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, negaritSnapshot) {
        // Cache the record so subsequent rebuilds don't flash a spinner
        if (negaritSnapshot.hasData && negaritSnapshot.data!.isNotEmpty) {
          _cachedNegaritRecord = negaritSnapshot.data!.first;
        }

        if (_cachedNegaritRecord == null) {
          if (!negaritSnapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          if (negaritSnapshot.data!.isEmpty) {
            return _buildEmptyState(completed: completed);
          }
        }

        final negaritRecord = _cachedNegaritRecord!;

        return StreamBuilder<List<MyNotesRecord>>(
          stream: queryMyNotesRecord(
            parent: negaritRecord.reference,
            queryBuilder: (myNotesRecord) => myNotesRecord
                .where('completed', isEqualTo: completed)
                .orderBy('date')
                .orderBy('start_time'),
          ),
          builder: (context, notesSnapshot) {
            // Show empty state immediately if we got data but it's empty
            if (notesSnapshot.hasData && notesSnapshot.data!.isEmpty) {
              return _buildEmptyState(completed: completed);
            }

            // Only show loading on the very first load
            if (!notesSnapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              );
            }

            final notes = notesSnapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task count
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      20.0, 16.0, 20.0, 4.0),
                  child: Text(
                    '${notes.length} ${completed ? 'completed' : 'upcoming'} task${notes.length == 1 ? '' : 's'}',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Figtree',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 100.0),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      final isLast = index == notes.length - 1;
                      return _buildStepperCard(
                        context: context,
                        note: note,
                        isLast: isLast,
                        isCompleted: completed,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStepperCard({
    required BuildContext context,
    required MyNotesRecord note,
    required bool isLast,
    required bool isCompleted,
  }) {
    final color = _categoryColor(context, note.category);
    final categoryLabel = _categoryLabel(note.category);

    // Check if task is overdue (date + start time in the past and not completed)
    bool isOverdue = false;
    if (!isCompleted && note.hasDate() && note.hasStartTime()) {
      final taskDateTime = DateTime(
        note.date!.year,
        note.date!.month,
        note.date!.day,
        note.startTime!.hour,
        note.startTime!.minute,
      );
      isOverdue = taskDateTime.isBefore(DateTime.now());
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stepper line + dot
          SizedBox(
            width: 32.0,
            child: Column(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? FlutterFlowTheme.of(context).success
                        : isOverdue
                            ? FlutterFlowTheme.of(context).error
                            : color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted
                          ? FlutterFlowTheme.of(context)
                              .success
                              .withValues(alpha: 0.3)
                          : isOverdue
                              ? FlutterFlowTheme.of(context)
                                  .error
                                  .withValues(alpha: 0.3)
                              : color.withValues(alpha: 0.3),
                      width: 3.0,
                    ),
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, size: 8.0, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.0,
                      color: FlutterFlowTheme.of(context)
                          .alternate
                          .withValues(alpha: 0.6),
                    ),
                  ),
              ],
            ),
          ),
          // Card content
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: isOverdue
                        ? FlutterFlowTheme.of(context)
                            .error
                            .withValues(alpha: 0.4)
                        : FlutterFlowTheme.of(context)
                            .alternate
                            .withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: category chip + overdue badge + actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 6.0),
                                    Text(
                                      categoryLabel,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Figtree',
                                            color: color,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isOverdue) ...[
                                SizedBox(width: 6.0),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 3.0),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .error
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    'Overdue',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          fontSize: 11.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: false,
                                  avoidOverflow: false,
                                  targetAnchor:
                                      AlignmentDirectional(1.0, -1.0)
                                          .resolve(
                                              Directionality.of(context)),
                                  followerAnchor:
                                      AlignmentDirectional(1.0, -1.0)
                                          .resolve(
                                              Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () => FocusScope.of(
                                                  dialogContext)
                                              .unfocus(),
                                          child: TaskActionWidget(
                                            task: note.reference,
                                            showMark: !isCompleted,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      // Task title
                      Text(
                        valueOrDefault<String>(
                          functions.capitalizeFirstLetter(note.note),
                          'Untitled Task',
                        ),
                        style: FlutterFlowTheme.of(context)
                            .bodyLarge
                            .override(
                              fontFamily: 'Figtree',
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: isCompleted
                                  ? FlutterFlowTheme.of(context).secondaryText
                                  : FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                      SizedBox(height: 8.0),
                      // Date and time row
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14.0,
                            color:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            note.hasDate()
                                ? valueOrDefault<String>(
                                    functions
                                        .dateToHumanReadable(note.date!),
                                    'No date',
                                  )
                                : 'No date',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(width: 16.0),
                          Icon(
                            Icons.access_time_rounded,
                            size: 14.0,
                            color:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            _formatTimeRange(note),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                      // Reminder info for upcoming tasks
                      if (!isCompleted && note.remindMe) ...[
                        SizedBox(height: 6.0),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              size: 13.0,
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              _reminderLabel(note.remindBefore),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Figtree',
                                    color:
                                        FlutterFlowTheme.of(context).primary,
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                      // Quick complete button for upcoming tasks
                      if (!isCompleted) ...[
                        SizedBox(height: 10.0),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await note.reference.update(
                                createMyNotesRecordData(completed: true));
                            // Cancel scheduled reminder
                            final notifId = NotificationService.generateId(
                                note.reference.path);
                            await NotificationService()
                                .cancelNotification(notifId);
                            // Show completion notification
                            NotificationService().showInstantNotification(
                              id: notifId + 1,
                              title: 'Task Completed',
                              body:
                                  '${functions.capitalizeFirstLetter(note.note)} marked as done!',
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .success
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 16.0,
                                  color:
                                      FlutterFlowTheme.of(context).success,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  'Mark Complete',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Figtree',
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeRange(MyNotesRecord note) {
    final start = note.hasStartTime()
        ? valueOrDefault<String>(
            functions.timeToHumanReadableTime(note.startTime!), '')
        : '';
    final end = note.hasEndTime()
        ? valueOrDefault<String>(
            functions.timeToHumanReadableTime(note.endTime!), '')
        : '';
    if (start.isEmpty && end.isEmpty) return 'No time set';
    if (end.isEmpty) return start;
    return '$start - $end';
  }

  Widget _buildEmptyState({required bool completed}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color:
                    FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                completed
                    ? Icons.task_alt_rounded
                    : Icons.assignment_outlined,
                color: FlutterFlowTheme.of(context).primary,
                size: 40.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              completed ? 'No Completed Tasks' : 'No Upcoming Tasks',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 8.0),
            Text(
              completed
                  ? 'Tasks you mark as complete will show up here.'
                  : 'Tap the + button to add your first task.',
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
