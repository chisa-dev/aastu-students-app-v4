import '/flutter_flow/flutter_flow_util.dart';
import 'search_widget.dart' show SearchWidget;
import 'package:flutter/material.dart';

class SearchModel extends FlutterFlowModel<SearchWidget> {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
  }
}
