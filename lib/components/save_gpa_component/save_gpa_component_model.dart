import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'save_gpa_component_widget.dart' show SaveGpaComponentWidget;
import 'package:flutter/material.dart';

class SaveGpaComponentModel extends FlutterFlowModel<SaveGpaComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  GradeRecord? gpaCreated;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MyGradeRecord? myGradeCreated;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
