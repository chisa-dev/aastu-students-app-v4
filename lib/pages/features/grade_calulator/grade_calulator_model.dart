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
import 'grade_calulator_widget.dart' show GradeCalulatorWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
