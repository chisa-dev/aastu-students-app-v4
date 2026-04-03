import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'main_chat_widget.dart' show MainChatWidget;
import 'package:flutter/material.dart';

class MainChatModel extends FlutterFlowModel<MainChatWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Side_nav component.
  late SideNavModel sideNavModel;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
  }

  @override
  void dispose() {
    sideNavModel.dispose();
  }
}
