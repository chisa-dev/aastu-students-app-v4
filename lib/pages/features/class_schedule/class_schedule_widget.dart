import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class_schedule_model.dart';
export 'class_schedule_model.dart';

const _kDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
const _kCourseColors = [
  Color(0xFF5B7FF0),
  Color(0xFF43A047),
  Color(0xFFEF6C00),
  Color(0xFFE53935),
  Color(0xFF8E24AA),
  Color(0xFF00897B),
  Color(0xFFF4511E),
  Color(0xFF3949AB),
];

class ClassScheduleWidget extends StatefulWidget {
  const ClassScheduleWidget({super.key});

  @override
  State<ClassScheduleWidget> createState() => _ClassScheduleWidgetState();
}

class _ClassScheduleWidgetState extends State<ClassScheduleWidget> {
  late ClassScheduleModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassScheduleModel());
    _loadSchedule();
    // Auto-select today
    final today = DateTime.now().weekday; // 1=Mon ... 6=Sat
    if (today >= 1 && today <= 6) {
      _selectedDayIndex = today - 1;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _loadSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('class_schedule');
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      _model.entries =
          list.map((e) => ScheduleEntry.fromJson(e as Map<String, dynamic>)).toList();
      safeSetState(() {});
    }
  }

  Future<void> _saveSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_model.entries.map((e) => e.toJson()).toList());
    await prefs.setString('class_schedule', raw);
  }

  void _addEntry(ScheduleEntry entry) {
    _model.entries.add(entry);
    _saveSchedule();
    safeSetState(() {});
  }

  void _deleteEntry(int index) {
    _model.entries.removeAt(index);
    _saveSchedule();
    safeSetState(() {});
  }

  void _editEntry(int globalIndex) {
    final entry = _model.entries[globalIndex];
    TimeOfDay startTime = entry.startTime;
    TimeOfDay endTime = entry.endTime;
    int colorIndex = _kCourseColors.indexWhere((c) => c.value == entry.color.value);
    if (colorIndex < 0) colorIndex = 0;
    String selectedDay = entry.day;

    _model.courseNameController?.text = entry.courseName;
    _model.courseCodeController?.text = entry.courseCode;
    _model.roomController?.text = entry.room;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Class',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            _deleteEntry(globalIndex);
                          },
                          borderRadius: BorderRadius.circular(8.0),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildTextField(
                      controller: _model.courseNameController!,
                      focusNode: _model.courseNameFocusNode!,
                      label: 'Course Name *',
                      hint: 'e.g. Data Structures',
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _model.courseCodeController!,
                            focusNode: _model.courseCodeFocusNode!,
                            label: 'Course Code',
                            hint: 'e.g. CS301',
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: _buildTextField(
                            controller: _model.roomController!,
                            focusNode: _model.roomFocusNode!,
                            label: 'Room',
                            hint: 'e.g. B-204',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    // Day selector (single for edit)
                    Text(
                      'Day',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 8.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _kDays.map((day) {
                          final isSelected = day == selectedDay;
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: ChoiceChip(
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (_) =>
                                  setSheetState(() => selectedDay = day),
                              selectedColor:
                                  FlutterFlowTheme.of(context).primary,
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Figtree',
                                    color: isSelected
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimePicker(
                            context: context,
                            label: 'Start',
                            time: startTime,
                            onPicked: (t) =>
                                setSheetState(() => startTime = t),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: _buildTimePicker(
                            context: context,
                            label: 'End',
                            time: endTime,
                            onPicked: (t) =>
                                setSheetState(() => endTime = t),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Color',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: List.generate(_kCourseColors.length, (i) {
                        final c = _kCourseColors[i];
                        final isSel = i == colorIndex;
                        return GestureDetector(
                          onTap: () => setSheetState(() => colorIndex = i),
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: isSel
                                  ? Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 2.5)
                                  : null,
                            ),
                            child: isSel
                                ? Icon(Icons.check,
                                    size: 16.0, color: Colors.white)
                                : null,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          final name =
                              _model.courseNameController?.text.trim() ?? '';
                          if (name.isEmpty) return;
                          _model.entries[globalIndex] = ScheduleEntry(
                            courseName: name,
                            courseCode:
                                _model.courseCodeController?.text.trim() ?? '',
                            room: _model.roomController?.text.trim() ?? '',
                            day: selectedDay,
                            startTime: startTime,
                            endTime: endTime,
                            color: _kCourseColors[colorIndex],
                          );
                          _saveSchedule();
                          safeSetState(() {});
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Save Changes',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<ScheduleEntry> _entriesForDay(String day) {
    final list = _model.entries.where((e) => e.day == day).toList();
    list.sort((a, b) {
      final aMin = a.startTime.hour * 60 + a.startTime.minute;
      final bMin = b.startTime.hour * 60 + b.startTime.minute;
      return aMin.compareTo(bMin);
    });
    return list;
  }

  void _showAddCourseSheet() {
    Set<String> selectedDays = {_kDays[_selectedDayIndex]};
    TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 9, minute: 30);
    int colorIndex = _model.entries.length % _kCourseColors.length;

    _model.courseNameController?.clear();
    _model.courseCodeController?.clear();
    _model.roomController?.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Add Class',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 16.0),
                    // Course name
                    _buildTextField(
                      controller: _model.courseNameController!,
                      focusNode: _model.courseNameFocusNode!,
                      label: 'Course Name *',
                      hint: 'e.g. Data Structures',
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _model.courseCodeController!,
                            focusNode: _model.courseCodeFocusNode!,
                            label: 'Course Code',
                            hint: 'e.g. CS301',
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: _buildTextField(
                            controller: _model.roomController!,
                            focusNode: _model.roomFocusNode!,
                            label: 'Room',
                            hint: 'e.g. B-204',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    // Day selector (multi-select)
                    Text(
                      'Days',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 8.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _kDays.map((day) {
                          final isSelected = selectedDays.contains(day);
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: FilterChip(
                              label: Text(day),
                              selected: isSelected,
                              onSelected: (selected) {
                                setSheetState(() {
                                  if (selected) {
                                    selectedDays.add(day);
                                  } else if (selectedDays.length > 1) {
                                    selectedDays.remove(day);
                                  }
                                });
                              },
                              selectedColor:
                                  FlutterFlowTheme.of(context).primary,
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              checkmarkColor: Colors.white,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Figtree',
                                    color: isSelected
                                        ? Colors.white
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Time pickers
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimePicker(
                            context: context,
                            label: 'Start',
                            time: startTime,
                            onPicked: (t) =>
                                setSheetState(() => startTime = t),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: _buildTimePicker(
                            context: context,
                            label: 'End',
                            time: endTime,
                            onPicked: (t) => setSheetState(() => endTime = t),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    // Color picker
                    Text(
                      'Color',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: List.generate(_kCourseColors.length, (i) {
                        final c = _kCourseColors[i];
                        final isSelected = i == colorIndex;
                        return GestureDetector(
                          onTap: () => setSheetState(() => colorIndex = i),
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 2.5)
                                  : null,
                            ),
                            child: isSelected
                                ? Icon(Icons.check,
                                    size: 16.0, color: Colors.white)
                                : null,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.0),
                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          final name =
                              _model.courseNameController?.text.trim() ?? '';
                          if (name.isEmpty) return;
                          for (final day in selectedDays) {
                            _addEntry(ScheduleEntry(
                              courseName: name,
                              courseCode:
                                  _model.courseCodeController?.text.trim() ?? '',
                              room: _model.roomController?.text.trim() ?? '',
                              day: day,
                              startTime: startTime,
                              endTime: endTime,
                              color: _kCourseColors[colorIndex],
                            ));
                          }
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add Class',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dayEntries = _entriesForDay(_kDays[_selectedDayIndex]);

    return Title(
      title: 'Class Schedule',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddCourseSheet,
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 4.0,
            child: Icon(Icons.add_rounded, color: Colors.white, size: 28.0),
          ),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Class Schedule',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
            centerTitle: false,
            elevation: 0.0,
          ),
          body: Column(
            children: [
              // Day tabs
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
                child: Container(
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: List.generate(_kDays.length, (i) {
                      final isSelected = i == _selectedDayIndex;
                      final isToday = DateTime.now().weekday == i + 1;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              safeSetState(() => _selectedDayIndex = i),
                          child: Container(
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? FlutterFlowTheme.of(context)
                                      .primary
                                      .withValues(alpha: 0.12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _kDays[i],
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: isSelected
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  if (isToday)
                                    Container(
                                      width: 4.0,
                                      height: 4.0,
                                      margin: EdgeInsets.only(top: 2.0),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              // Class count
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${dayEntries.length} class${dayEntries.length == 1 ? '' : 'es'} on ${_kDays[_selectedDayIndex]}',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.0,
                          ),
                    ),
                    if (_model.entries.isNotEmpty)
                      Text(
                        '${_model.entries.length} total',
                        style:
                            FlutterFlowTheme.of(context).labelSmall.override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                      ),
                  ],
                ),
              ),
              // Schedule list
              Expanded(
                child: dayEntries.isEmpty
                    ? _buildEmptyDay(context)
                    : ListView.builder(
                        padding:
                            EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 100.0),
                        itemCount: dayEntries.length,
                        itemBuilder: (context, index) {
                          final entry = dayEntries[index];
                          final globalIndex =
                              _model.entries.indexOf(entry);
                          return _buildClassCard(context, entry, globalIndex);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassCard(
      BuildContext context, ScheduleEntry entry, int globalIndex) {
    final startStr = _formatTime(entry.startTime);
    final endStr = _formatTime(entry.endTime);

    return Dismissible(
      key: ValueKey('${entry.day}_${entry.courseName}_$globalIndex'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).error,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      onDismissed: (_) => _deleteEntry(globalIndex),
      child: GestureDetector(
        onTap: () => _editEntry(globalIndex),
        child: Container(
          margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: IntrinsicHeight(
          child: Row(
            children: [
              // Color bar
              Container(
                width: 4.0,
                decoration: BoxDecoration(
                  color: entry.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                ),
              ),
              // Time column
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      startStr,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      width: 1.0,
                      height: 16.0,
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    Text(
                      endStr,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Figtree',
                            color:
                                FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              // Divider
              Container(
                width: 1.0,
                color: FlutterFlowTheme.of(context)
                    .alternate
                    .withValues(alpha: 0.5),
              ),
              // Course info
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.courseName,
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                      ),
                      if (entry.courseCode.isNotEmpty ||
                          entry.room.isNotEmpty) ...[
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            if (entry.courseCode.isNotEmpty) ...[
                              Icon(Icons.tag_rounded,
                                  size: 13.0,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              SizedBox(width: 3.0),
                              Text(
                                entry.courseCode,
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
                            if (entry.courseCode.isNotEmpty &&
                                entry.room.isNotEmpty)
                              SizedBox(width: 12.0),
                            if (entry.room.isNotEmpty) ...[
                              Icon(Icons.room_outlined,
                                  size: 13.0,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              SizedBox(width: 3.0),
                              Text(
                                entry.room,
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
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildEmptyDay(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context)
                    .primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 32.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'No classes on ${_kDays[_selectedDayIndex]}',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Figtree',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Tap + to add a class',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Figtree',
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Figtree',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding:
                EdgeInsetsDirectional.fromSTEB(14.0, 12.0, 14.0, 12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }

  Widget _buildTimePicker({
    required BuildContext context,
    required String label,
    required TimeOfDay time,
    required ValueChanged<TimeOfDay> onPicked,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Figtree',
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 6.0),
        InkWell(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) onPicked(picked);
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height: 46.0,
            padding: EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded,
                    size: 18.0,
                    color: FlutterFlowTheme.of(context).secondaryText),
                SizedBox(width: 8.0),
                Text(
                  _formatTime(time),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Figtree',
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$min $period';
  }
}
