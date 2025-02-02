import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'quiz_generator_widget.dart' show QuizGeneratorWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizGeneratorModel extends FlutterFlowModel<QuizGeneratorWidget> {
  ///  Local state fields for this component.

  int generatedID = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for courseName widget.
  FocusNode? courseNameFocusNode;
  TextEditingController? courseNameTextController;
  String? Function(BuildContext, String?)? courseNameTextControllerValidator;
  // State field(s) for courseContent widget.
  FocusNode? courseContentFocusNode;
  TextEditingController? courseContentTextController;
  String? Function(BuildContext, String?)? courseContentTextControllerValidator;
  // Stores action output result for [Custom Action - pasteFromClipboard] action in Icon widget.
  String? pastedText;
  // State field(s) for numberofQuestions widget.
  FocusNode? numberofQuestionsFocusNode;
  TextEditingController? numberofQuestionsTextController;
  String? Function(BuildContext, String?)?
      numberofQuestionsTextControllerValidator;
  // Stores action output result for [Backend Call - API (ChatGPT)] action in Button widget.
  ApiCallResponse? jSONResponse;
  // Stores action output result for [Custom Action - jsonToQuestionsModel] action in Button widget.
  List<QuestionModelStruct>? generatedQuestionFromGPT;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    courseNameFocusNode?.dispose();
    courseNameTextController?.dispose();

    courseContentFocusNode?.dispose();
    courseContentTextController?.dispose();

    numberofQuestionsFocusNode?.dispose();
    numberofQuestionsTextController?.dispose();
  }
}
