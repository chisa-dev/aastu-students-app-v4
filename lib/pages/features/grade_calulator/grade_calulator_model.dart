import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'grade_calulator_widget.dart' show GradeCalulatorWidget;
import 'package:flutter/material.dart';

class GradeCalulatorModel extends FlutterFlowModel<GradeCalulatorWidget> {
  ///  Local state fields for this page.

  bool showResult = false;

  List<Color> colors = [
    Color(637829496),
    Color(637829423),
    Color(637813377),
    Color(637820033)
  ];
  void addToColors(Color item) => colors.add(item);
  void removeFromColors(Color item) => colors.remove(item);
  void removeAtIndexFromColors(int index) => colors.removeAt(index);
  void insertAtIndexInColors(int index, Color item) =>
      colors.insert(index, item);
  void updateColorsAtIndex(int index, Function(Color) updateFn) =>
      colors[index] = updateFn(colors[index]);

  int colorIndex = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - calculateGrade] action in Button widget.
  StudentResultStruct? results;

  // AI insight state.
  String? insightText;
  bool isLoadingInsight = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
