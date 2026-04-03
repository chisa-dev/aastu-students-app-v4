import '/components/web_components/post_details_base/post_details_base_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_details_page_widget.dart' show PostDetailsPageWidget;
import 'package:flutter/material.dart';

class PostDetailsPageModel extends FlutterFlowModel<PostDetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Side_nav component.
  late SideNavModel sideNavModel;
  // Model for postDetails_Base component.
  late PostDetailsBaseModel postDetailsBaseModel;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
    postDetailsBaseModel = createModel(context, () => PostDetailsBaseModel());
  }

  @override
  void dispose() {
    sideNavModel.dispose();
    postDetailsBaseModel.dispose();
  }
}
