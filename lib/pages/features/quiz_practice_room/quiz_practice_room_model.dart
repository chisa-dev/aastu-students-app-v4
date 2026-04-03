import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'quiz_practice_room_widget.dart' show QuizPracticeRoomWidget;
import 'package:flutter/material.dart';

class QuizPracticeRoomModel extends FlutterFlowModel<QuizPracticeRoomWidget> {
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

  List<CorrectChoiceModelStruct> correctChoice = [];
  void addToCorrectChoice(CorrectChoiceModelStruct item) =>
      correctChoice.add(item);
  void removeFromCorrectChoice(CorrectChoiceModelStruct item) =>
      correctChoice.remove(item);
  void removeAtIndexFromCorrectChoice(int index) =>
      correctChoice.removeAt(index);
  void insertAtIndexInCorrectChoice(int index, CorrectChoiceModelStruct item) =>
      correctChoice.insert(index, item);
  void updateCorrectChoiceAtIndex(
          int index, Function(CorrectChoiceModelStruct) updateFn) =>
      correctChoice[index] = updateFn(correctChoice[index]);

  int clickedQIndex = 100;

  int clieckedAIndex = 100;

  List<QuestionModelStruct> questionsListData = [];
  void addToQuestionsListData(QuestionModelStruct item) =>
      questionsListData.add(item);
  void removeFromQuestionsListData(QuestionModelStruct item) =>
      questionsListData.remove(item);
  void removeAtIndexFromQuestionsListData(int index) =>
      questionsListData.removeAt(index);
  void insertAtIndexInQuestionsListData(int index, QuestionModelStruct item) =>
      questionsListData.insert(index, item);
  void updateQuestionsListDataAtIndex(
          int index, Function(QuestionModelStruct) updateFn) =>
      questionsListData[index] = updateFn(questionsListData[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
