import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'store_item_detail_widget.dart' show StoreItemDetailWidget;
import 'package:flutter/material.dart';

class StoreItemDetailModel extends FlutterFlowModel<StoreItemDetailWidget> {
  // Page controller for image carousel
  PageController? pageController;
  int currentImageIndex = 0;

  // Review form
  final reviewFormKey = GlobalKey<FormState>();
  FocusNode? reviewFocusNode;
  TextEditingController? reviewTextController;
  double reviewRating = 5.0;

  // Created review
  StoreReviewsRecord? newReview;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    pageController?.dispose();
    reviewFocusNode?.dispose();
    reviewTextController?.dispose();
  }
}
