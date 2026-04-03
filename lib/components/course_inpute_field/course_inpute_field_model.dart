import '/flutter_flow/flutter_flow_util.dart';
import 'course_inpute_field_widget.dart' show CourseInputeFieldWidget;
import 'package:flutter/material.dart';

class CourseInputeFieldModel extends FlutterFlowModel<CourseInputeFieldWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
