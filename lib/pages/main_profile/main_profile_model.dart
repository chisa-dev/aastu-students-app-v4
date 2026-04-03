import '/backend/backend.dart';
import '/components/user_list/user_list_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'main_profile_widget.dart' show MainProfileWidget;
import 'package:flutter/material.dart';

class MainProfileModel extends FlutterFlowModel<MainProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Side_nav component.
  late SideNavModel sideNavModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Models for userList dynamic component.
  late FlutterFlowDynamicModels<UserListModel> userListModels;
  // Stores action output result for [Backend Call - Read Document] action in userList widget.
  UsersRecord? follower;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
    userListModels = FlutterFlowDynamicModels(() => UserListModel());
  }

  @override
  void dispose() {
    sideNavModel.dispose();
    tabBarController?.dispose();
    userListModels.dispose();
  }
}
