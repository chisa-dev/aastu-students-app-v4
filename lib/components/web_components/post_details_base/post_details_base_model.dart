import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_details_base_widget.dart' show PostDetailsBaseWidget;
import 'package:flutter/material.dart';

class PostDetailsBaseModel extends FlutterFlowModel<PostDetailsBaseWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please fill in the comment...';
    }

    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PostCommentsRecord? newComment;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
