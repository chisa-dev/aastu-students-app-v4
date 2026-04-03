import '/flutter_flow/flutter_flow_util.dart';
import 'grading_system_widget.dart' show GradingSystemWidget;
import 'package:flutter/material.dart';

class GradingSystemModel extends FlutterFlowModel<GradingSystemWidget> {
  // Playground state
  TextEditingController? markController;
  FocusNode? markFocusNode;
  String? playgroundResult;

  @override
  void initState(BuildContext context) {
    markController = TextEditingController();
    markFocusNode = FocusNode();
  }

  @override
  void dispose() {
    markController?.dispose();
    markFocusNode?.dispose();
  }
}
