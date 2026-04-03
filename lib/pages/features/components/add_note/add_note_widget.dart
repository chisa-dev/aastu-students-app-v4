import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/notification_service.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'add_note_model.dart';
export 'add_note_model.dart';

class AddNoteWidget extends StatefulWidget {
  const AddNoteWidget({super.key});

  @override
  State<AddNoteWidget> createState() => _AddNoteWidgetState();
}

class _AddNoteWidgetState extends State<AddNoteWidget> {
  late AddNoteModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNoteModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.noteNameTextController ??= TextEditingController();
    _model.noteNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  static const List<Map<String, dynamic>> _reminderOptions = [
    {'label': '5 min before', 'value': 5},
    {'label': '10 min before', 'value': 10},
    {'label': '15 min before', 'value': 15},
    {'label': '30 min before', 'value': 30},
    {'label': '1 hour before', 'value': 60},
  ];

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4.0, 72.0, 4.0, 16.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 570.0,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 2.0),
                  )
                ],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).accent1,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 44.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Add Your Tasks',
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
                          Form(
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Task name field
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 20.0, 2.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.noteNameTextController,
                                    focusNode: _model.noteNameFocusNode,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Task Name',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Figtree',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                          ),
                                      alignLabelWithHint: true,
                                      hintText: 'What are you going to do?',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Figtree',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 4.0, 20.0, 24.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                        ),
                                    minLines: 1,
                                    cursorColor:
                                        FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .noteNameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                // Date picker
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: _buildDatePicker(context),
                                ),
                                // Start time & End time row
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child:
                                              _buildStartTimePicker(context)),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                          child: _buildEndTimePicker(context)),
                                    ],
                                  ),
                                ),
                                // Reminder dropdown
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: _buildReminderDropdown(context),
                                ),
                                // Category selector
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildCategoryChip(
                                          context, 'assignment', 'Assignment'),
                                      SizedBox(width: 8.0),
                                      _buildCategoryChip(
                                          context, 'test', 'Test'),
                                      SizedBox(width: 8.0),
                                      _buildCategoryChip(
                                          context, 'other', 'Other'),
                                    ],
                                  ),
                                ),
                                // Add button
                                if (!(isWeb
                                    ? MediaQuery.viewInsetsOf(context).bottom >
                                        0
                                    : _isKeyboardVisible))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 22.0, 4.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: _onAddPressed,
                                      text: 'ADD TASK',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 44.0,
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
                                              fontSize: 15.0,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
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
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final datePicked = await showDatePicker(
          context: context,
          initialDate: getCurrentTimestamp,
          firstDate: getCurrentTimestamp,
          lastDate: DateTime(2050),
          builder: (context, child) {
            return wrapInMaterialDatePickerTheme(
              context,
              child!,
              headerBackgroundColor: FlutterFlowTheme.of(context).primary,
              headerForegroundColor: FlutterFlowTheme.of(context).info,
              headerTextStyle:
                  FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily: 'Outfit',
                        fontSize: 32.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
              pickerBackgroundColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
              selectedDateTimeBackgroundColor:
                  FlutterFlowTheme.of(context).primary,
              selectedDateTimeForegroundColor:
                  FlutterFlowTheme.of(context).info,
              actionButtonForegroundColor:
                  FlutterFlowTheme.of(context).primaryText,
              iconSize: 24.0,
            );
          },
        );

        if (datePicked != null) {
          safeSetState(() {
            _model.datePicked1 = DateTime(
              datePicked.year,
              datePicked.month,
              datePicked.day,
            );
            _model.selectedDate =
                functions.dateToHumanReadable(_model.datePicked1!);
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _model.selectedDate ?? 'Select Date',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      color: _model.selectedDate != null
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              Icon(
                Icons.calendar_today_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 22.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartTimePicker(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(getCurrentTimestamp),
          builder: (context, child) {
            return wrapInMaterialTimePickerTheme(
              context,
              child!,
              headerBackgroundColor: FlutterFlowTheme.of(context).primary,
              headerForegroundColor: FlutterFlowTheme.of(context).info,
              headerTextStyle:
                  FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily: 'Outfit',
                        fontSize: 32.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
              pickerBackgroundColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
              selectedDateTimeBackgroundColor:
                  FlutterFlowTheme.of(context).primary,
              selectedDateTimeForegroundColor:
                  FlutterFlowTheme.of(context).info,
              actionButtonForegroundColor:
                  FlutterFlowTheme.of(context).primaryText,
              iconSize: 24.0,
            );
          },
        );
        if (timePicked != null) {
          safeSetState(() {
            _model.datePicked2 = DateTime(
              getCurrentTimestamp.year,
              getCurrentTimestamp.month,
              getCurrentTimestamp.day,
              timePicked.hour,
              timePicked.minute,
            );
            _model.selectedStartTime =
                functions.timeToHumanReadableTime(_model.datePicked2!);

            // Auto-set end time to 30 minutes after start if not already set
            if (_model.datePicked3 == null) {
              _model.datePicked3 =
                  _model.datePicked2!.add(Duration(minutes: 30));
              _model.selectedEndTime =
                  functions.timeToHumanReadableTime(_model.datePicked3!);
            }
          });
        }
      },
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 8.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _model.selectedStartTime ?? 'Start Time',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      color: _model.selectedStartTime != null
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              Icon(
                Icons.access_time_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndTimePicker(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final timePicked = await showTimePicker(
          context: context,
          initialTime: _model.datePicked3 != null
              ? TimeOfDay.fromDateTime(_model.datePicked3!)
              : TimeOfDay.fromDateTime(
                  getCurrentTimestamp.add(Duration(minutes: 30))),
          builder: (context, child) {
            return wrapInMaterialTimePickerTheme(
              context,
              child!,
              headerBackgroundColor: FlutterFlowTheme.of(context).primary,
              headerForegroundColor: FlutterFlowTheme.of(context).info,
              headerTextStyle:
                  FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily: 'Outfit',
                        fontSize: 32.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
              pickerBackgroundColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
              selectedDateTimeBackgroundColor:
                  FlutterFlowTheme.of(context).primary,
              selectedDateTimeForegroundColor:
                  FlutterFlowTheme.of(context).info,
              actionButtonForegroundColor:
                  FlutterFlowTheme.of(context).primaryText,
              iconSize: 24.0,
            );
          },
        );
        if (timePicked != null) {
          safeSetState(() {
            _model.datePicked3 = DateTime(
              getCurrentTimestamp.year,
              getCurrentTimestamp.month,
              getCurrentTimestamp.day,
              timePicked.hour,
              timePicked.minute,
            );
            _model.selectedEndTime =
                functions.timeToHumanReadableTime(_model.datePicked3!);
          });
        }
      },
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 8.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _model.selectedEndTime ?? 'End (optional)',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      color: _model.selectedEndTime != null
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              Icon(
                Icons.access_time_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderDropdown(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
        child: Row(
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Remind me',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Figtree',
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                  ),
            ),
            Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _model.remindBefore,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                dropdownColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                items: _reminderOptions
                    .map((opt) => DropdownMenuItem<int>(
                          value: opt['value'] as int,
                          child: Text(opt['label'] as String),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    safeSetState(() => _model.remindBefore = value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
      BuildContext context, String value, String label) {
    final isSelected = _model.selectedTask == value;
    Color chipColor;
    switch (value) {
      case 'assignment':
        chipColor = FFAppState().taskColors.assignement;
        break;
      case 'test':
        chipColor = FFAppState().taskColors.test;
        break;
      default:
        chipColor = FFAppState().taskColors.other;
    }

    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => safeSetState(() => _model.selectedTask = value),
        child: Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: isSelected ? chipColor.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isSelected ? chipColor : FlutterFlowTheme.of(context).alternate,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: isSelected
                      ? chipColor
                      : FlutterFlowTheme.of(context).primaryBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: chipColor,
                    width: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                child: Text(
                  label,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Figtree',
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? chipColor
                            : FlutterFlowTheme.of(context).primaryText,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAddPressed() async {
    if (_model.formKey.currentState == null ||
        !_model.formKey.currentState!.validate()) {
      return;
    }
    if (_model.datePicked1 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }
    if (_model.datePicked2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a start time'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
      return;
    }

    // Auto-set end time to 30 min after start if not picked
    _model.datePicked3 ??= _model.datePicked2!.add(Duration(minutes: 30));

    // Create DailyNegarit parent doc
    var dailyNegaritRecordReference =
        DailyNegaritRecord.collection.doc(currentUserUid);
    await dailyNegaritRecordReference.set(createDailyNegaritRecordData(
      id: currentUserUid,
    ));
    _model.dailyNegaritCreated = DailyNegaritRecord.getDocumentFromData(
      createDailyNegaritRecordData(id: currentUserUid),
      dailyNegaritRecordReference,
    );

    // Create MyNotes child doc
    var myNotesRecordReference =
        MyNotesRecord.createDoc(_model.dailyNegaritCreated!.reference);
    await myNotesRecordReference.set(createMyNotesRecordData(
      uid: currentUserUid,
      note: _model.noteNameTextController.text,
      date: _model.datePicked1,
      startTime: _model.datePicked2,
      endTime: _model.datePicked3,
      remindMe: true,
      remindBefore: _model.remindBefore,
      category: _model.selectedTask,
      completed: false,
    ));
    _model.myNoteCreated = MyNotesRecord.getDocumentFromData(
      createMyNotesRecordData(
        uid: currentUserUid,
        note: _model.noteNameTextController.text,
        date: _model.datePicked1,
        startTime: _model.datePicked2,
        endTime: _model.datePicked3,
        remindMe: true,
        remindBefore: _model.remindBefore,
        category: _model.selectedTask,
        completed: false,
      ),
      myNotesRecordReference,
    );

    // Schedule reminder notification
    final scheduledTime = DateTime(
      _model.datePicked1!.year,
      _model.datePicked1!.month,
      _model.datePicked1!.day,
      _model.datePicked2!.hour,
      _model.datePicked2!.minute,
    );
    final notifId =
        NotificationService.generateId(myNotesRecordReference.path);
    final reminderMin = _model.remindBefore;
    await NotificationService().scheduleTaskReminder(
      id: notifId,
      title:
          'Upcoming: ${_model.selectedTask[0].toUpperCase()}${_model.selectedTask.substring(1)}',
      body:
          '${_model.noteNameTextController.text} starts in $reminderMin minutes',
      scheduledTime: scheduledTime,
      category: _model.selectedTask,
      reminderMinutes: reminderMin,
    );

    FFAppState().NoteAdded = true;
    FFAppState().update(() {});
    if (mounted) {
      Navigator.pop(context);
    }

    safeSetState(() {});
  }
}
