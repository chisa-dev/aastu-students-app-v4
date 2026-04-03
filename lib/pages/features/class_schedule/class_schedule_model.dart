import '/flutter_flow/flutter_flow_util.dart';
import 'class_schedule_widget.dart' show ClassScheduleWidget;
import 'package:flutter/material.dart';

class ScheduleEntry {
  final String courseName;
  final String courseCode;
  final String room;
  final String day; // 'Mon', 'Tue', etc.
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color color;

  ScheduleEntry({
    required this.courseName,
    required this.courseCode,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'courseName': courseName,
        'courseCode': courseCode,
        'room': room,
        'day': day,
        'startHour': startTime.hour,
        'startMinute': startTime.minute,
        'endHour': endTime.hour,
        'endMinute': endTime.minute,
        'colorValue': color.value,
      };

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) => ScheduleEntry(
        courseName: json['courseName'] as String,
        courseCode: json['courseCode'] as String? ?? '',
        room: json['room'] as String? ?? '',
        day: json['day'] as String,
        startTime: TimeOfDay(
          hour: json['startHour'] as int,
          minute: json['startMinute'] as int,
        ),
        endTime: TimeOfDay(
          hour: json['endHour'] as int,
          minute: json['endMinute'] as int,
        ),
        color: Color(json['colorValue'] as int),
      );
}

class ClassScheduleModel extends FlutterFlowModel<ClassScheduleWidget> {
  List<ScheduleEntry> entries = [];

  // Add course form controllers
  TextEditingController? courseNameController;
  TextEditingController? courseCodeController;
  TextEditingController? roomController;
  FocusNode? courseNameFocusNode;
  FocusNode? courseCodeFocusNode;
  FocusNode? roomFocusNode;

  @override
  void initState(BuildContext context) {
    courseNameController = TextEditingController();
    courseCodeController = TextEditingController();
    roomController = TextEditingController();
    courseNameFocusNode = FocusNode();
    courseCodeFocusNode = FocusNode();
    roomFocusNode = FocusNode();
  }

  @override
  void dispose() {
    courseNameController?.dispose();
    courseCodeController?.dispose();
    roomController?.dispose();
    courseNameFocusNode?.dispose();
    courseCodeFocusNode?.dispose();
    roomFocusNode?.dispose();
  }
}
