import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/blocked_account_widget.dart';
import '/components/create_modal/create_modal_widget.dart';
import '/components/download_available/download_available_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_widget.dart' show HomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  int assignmentNo = 0;

  int testNo = 0;

  int otherNo = 0;

  int premiumAccountsCount = -1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ConstantsRecord? latestVersion;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  DailyNegaritRecord? myDailyNegarit;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  List<MyNotesRecord>? myNotes;
  // Stores action output result for [Custom Action - countNotesItems] action in home widget.
  List<int>? getTaskNoList;
  // Model for Side_nav component.
  late SideNavModel sideNavModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
  }

  @override
  void dispose() {
    sideNavModel.dispose();
    tabBarController?.dispose();
  }
}
