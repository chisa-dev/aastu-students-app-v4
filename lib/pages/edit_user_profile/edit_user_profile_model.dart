import '/flutter_flow/flutter_flow_util.dart';
import 'edit_user_profile_widget.dart' show EditUserProfileWidget;
import 'package:flutter/material.dart';

class EditUserProfileModel extends FlutterFlowModel<EditUserProfileWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // State field(s) for userName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameTextController;
  String? Function(BuildContext, String?)? userNameTextControllerValidator;
  // State field(s) for idNumber widget.
  FocusNode? idNumberFocusNode;
  TextEditingController? idNumberTextController;
  String? Function(BuildContext, String?)? idNumberTextControllerValidator;
  // State field(s) for department widget.
  FocusNode? departmentFocusNode1;
  TextEditingController? departmentTextController1;
  String? Function(BuildContext, String?)? departmentTextController1Validator;
  // State field(s) for department widget.
  FocusNode? departmentFocusNode2;
  TextEditingController? departmentTextController2;
  String? Function(BuildContext, String?)? departmentTextController2Validator;
  // State field(s) for college widget.
  FocusNode? collegeFocusNode;
  TextEditingController? collegeTextController;
  String? Function(BuildContext, String?)? collegeTextControllerValidator;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for bio widget.
  FocusNode? bioFocusNode;
  TextEditingController? bioTextController;
  String? Function(BuildContext, String?)? bioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    userNameFocusNode?.dispose();
    userNameTextController?.dispose();

    idNumberFocusNode?.dispose();
    idNumberTextController?.dispose();

    departmentFocusNode1?.dispose();
    departmentTextController1?.dispose();

    departmentFocusNode2?.dispose();
    departmentTextController2?.dispose();

    collegeFocusNode?.dispose();
    collegeTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    bioFocusNode?.dispose();
    bioTextController?.dispose();
  }
}
