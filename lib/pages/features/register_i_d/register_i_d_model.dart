import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'register_i_d_widget.dart' show RegisterIDWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RegisterIDModel extends FlutterFlowModel<RegisterIDWidget> {
  ///  Local state fields for this page.

  String? barcode;

  String selectTitle = 'Upload your personal photo (ጉርድ ፎቶ) ';

  bool photoSelected = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - simpleBarCodeScanner] action in Container widget.
  String? resultBarcode;
  // State field(s) for barCode widget.
  FocusNode? barCodeFocusNode;
  TextEditingController? barCodeTextController;
  String? Function(BuildContext, String?)? barCodeTextControllerValidator;
  String? _barCodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please scan your ID to add barcode';
    }

    if (val.length < 2) {
      return 'Requires at least 2 characters.';
    }

    return null;
  }

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  String? _yourNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Student Name is required';
    }

    if (val.length < 3) {
      return 'Requires at least 3 characters.';
    }

    return null;
  }

  // State field(s) for IdNumber widget.
  FocusNode? idNumberFocusNode;
  TextEditingController? idNumberTextController;
  final idNumberMask = MaskTextInputFormatter(mask: 'AAA####/##');
  String? Function(BuildContext, String?)? idNumberTextControllerValidator;
  String? _idNumberTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Students Valid ID is required';
    }

    if (val.length < 5) {
      return 'Requires at least 5 characters.';
    }

    return null;
  }

  // State field(s) for DeptDropDown widget.
  String? deptDropDownValue;
  FormFieldController<String>? deptDropDownValueController;
  // State field(s) for GenderDropDown widget.
  String? genderDropDownValue;
  FormFieldController<String>? genderDropDownValueController;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {
    barCodeTextControllerValidator = _barCodeTextControllerValidator;
    yourNameTextControllerValidator = _yourNameTextControllerValidator;
    idNumberTextControllerValidator = _idNumberTextControllerValidator;
  }

  @override
  void dispose() {
    barCodeFocusNode?.dispose();
    barCodeTextController?.dispose();

    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    idNumberFocusNode?.dispose();
    idNumberTextController?.dispose();
  }
}
