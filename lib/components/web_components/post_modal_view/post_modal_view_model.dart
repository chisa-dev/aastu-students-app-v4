import '/backend/backend.dart';
import '/components/web_components/post_details_base/post_details_base_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'dart:ui';
import 'post_modal_view_widget.dart' show PostModalViewWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PostModalViewModel extends FlutterFlowModel<PostModalViewWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for postDetails_Base component.
  late PostDetailsBaseModel postDetailsBaseModel;

  @override
  void initState(BuildContext context) {
    postDetailsBaseModel = createModel(context, () => PostDetailsBaseModel());
  }

  @override
  void dispose() {
    postDetailsBaseModel.dispose();
  }
}
