import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'virtual_identity_widget.dart' show VirtualIdentityWidget;
import 'package:flutter/material.dart';

class VirtualIdentityModel extends FlutterFlowModel<VirtualIdentityWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
