import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'store_item_upload_widget.dart' show StoreItemUploadWidget;
import 'package:flutter/material.dart';

class StoreItemUploadModel extends FlutterFlowModel<StoreItemUploadWidget> {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controllers
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  FocusNode? telegramFocusNode;
  TextEditingController? telegramTextController;

  // Category
  String? selectedCategory;

  // Image upload state
  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];
  List<String> uploadedFileUrls = [];

  // Created item
  StoreItemsRecord? createdItem;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();
    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
    priceFocusNode?.dispose();
    priceTextController?.dispose();
    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
    telegramFocusNode?.dispose();
    telegramTextController?.dispose();
  }
}
