import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/features/components/add_note/add_note_widget.dart';
import '/pages/features/components/empty_list_task/empty_list_task_widget.dart';
import '/pages/features/components/empty_list_task_completed/empty_list_task_completed_widget.dart';
import '/pages/features/components/task_action/task_action_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'daily_negarit_widget.dart' show DailyNegaritWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class DailyNegaritModel extends FlutterFlowModel<DailyNegaritWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
