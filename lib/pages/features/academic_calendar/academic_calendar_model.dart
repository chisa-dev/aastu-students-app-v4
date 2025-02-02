import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'academic_calendar_widget.dart' show AcademicCalendarWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AcademicCalendarModel extends FlutterFlowModel<AcademicCalendarWidget> {
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
