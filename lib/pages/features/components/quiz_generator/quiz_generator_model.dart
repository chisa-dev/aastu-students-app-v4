import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quiz_generator_widget.dart' show QuizGeneratorWidget;
import 'package:flutter/material.dart';

class QuizGeneratorModel extends FlutterFlowModel<QuizGeneratorWidget> {
  ///  Local state fields for this component.

  int generatedID = 0;
  bool isGenerating = false;
  bool isLoadingSubtopics = false;
  String? selectedCourse;
  List<String> subtopics = [];
  List<String> selectedSubtopics = [];
  String? errorMessage;

  // State field(s) for courseSearch widget.
  FocusNode? courseSearchFocusNode;
  TextEditingController? courseSearchTextController;

  // State field(s) for courseContent widget.
  FocusNode? courseContentFocusNode;
  TextEditingController? courseContentTextController;
  String? Function(BuildContext, String?)? courseContentTextControllerValidator;

  // State field(s) for numberofQuestions widget.
  FocusNode? numberofQuestionsFocusNode;
  TextEditingController? numberofQuestionsTextController;
  String? Function(BuildContext, String?)?
      numberofQuestionsTextControllerValidator;

  // Stores action output result for quiz generation.
  List<QuestionModelStruct>? generatedQuestionFromGPT;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    courseSearchFocusNode?.dispose();
    courseSearchTextController?.dispose();

    courseContentFocusNode?.dispose();
    courseContentTextController?.dispose();

    numberofQuestionsFocusNode?.dispose();
    numberofQuestionsTextController?.dispose();
  }
}
