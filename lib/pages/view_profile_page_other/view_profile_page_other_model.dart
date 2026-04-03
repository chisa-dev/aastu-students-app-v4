import '/backend/backend.dart';
import '/components/user_list/user_list_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'view_profile_page_other_widget.dart' show ViewProfilePageOtherWidget;
import 'package:flutter/material.dart';

class ViewProfilePageOtherModel
    extends FlutterFlowModel<ViewProfilePageOtherWidget> {
  ///  Local state fields for this page.

  int total = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in viewProfilePageOther widget.
  List<FriendsRecord>? totalFollowers;
  // Model for Side_nav component.
  late SideNavModel sideNavModel;
  // Stores action output result for [Backend Call - Create Document] action in follow widget.
  FriendsRecord? customFriendsDoc;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Models for userList dynamic component.
  late FlutterFlowDynamicModels<UserListModel> userListModels;

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
