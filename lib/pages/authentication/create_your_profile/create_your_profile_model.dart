import 'dart:math';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/utils/input_validators.dart';
import 'create_your_profile_widget.dart' show CreateYourProfileWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateYourProfileModel extends FlutterFlowModel<CreateYourProfileWidget> {
  ///  Local state fields for this page.

  bool isStudent = true;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for firstName widget.
  FocusNode? firstNameFocusNode;
  TextEditingController? firstNameTextController;
  String? Function(BuildContext, String?)? firstNameTextControllerValidator;
  String? _firstNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) return 'First name is required';
    if (val.trim().length < 2) return 'At least 2 characters';
    return null;
  }

  // State field(s) for lastName widget.
  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;
  String? _lastNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) return 'Last name is required';
    if (val.trim().length < 2) return 'At least 2 characters';
    return null;
  }

  /// Combined display name from first + last name.
  String get fullDisplayName {
    final first = (firstNameTextController?.text ?? '').trim();
    final last = (lastNameTextController?.text ?? '').trim();
    return '$first $last'.trim();
  }

  /// Auto-generates a username from the first name.
  String generateUsername() {
    final first = (firstNameTextController?.text ?? '').trim().toLowerCase();
    final last = (lastNameTextController?.text ?? '').trim().toLowerCase();
    if (first.isEmpty) return '';

    // Clean to only alphanumeric
    final cleanFirst = first.replaceAll(RegExp(r'[^a-z0-9]'), '');
    final cleanLast = last.replaceAll(RegExp(r'[^a-z0-9]'), '');

    final random = Random();
    final suffix = random.nextInt(90) + 10; // 10-99

    if (cleanLast.isNotEmpty) {
      return '${cleanFirst}_$cleanLast$suffix';
    }
    return '${cleanFirst}_$suffix';
  }

  // State field(s) for userName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameTextController;
  String? Function(BuildContext, String?)? userNameTextControllerValidator;
  String? _userNameTextControllerValidator(BuildContext context, String? val) {
    return validateUsername(val);
  }

  // State field(s) for IdNumber widget.
  FocusNode? idNumberFocusNode;
  TextEditingController? idNumberTextController;
  final idNumberMask = MaskTextInputFormatter(mask: 'AAA####/##');
  String? Function(BuildContext, String?)? idNumberTextControllerValidator;
  // State field(s) for DeptDropDown widget.
  String? deptDropDownValue;
  FormFieldController<String>? deptDropDownValueController;
  // State field(s) for BathDropDown widget.
  String? bathDropDownValue;
  FormFieldController<String>? bathDropDownValueController;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  // Stores action output result for [Custom Action - getDeviceInfo] action in Button widget.
  DeviceInfoStruct? userDeviceInfo;

  @override
  void initState(BuildContext context) {
    firstNameTextControllerValidator = _firstNameTextControllerValidator;
    lastNameTextControllerValidator = _lastNameTextControllerValidator;
    userNameTextControllerValidator = _userNameTextControllerValidator;
  }

  @override
  void dispose() {
    firstNameFocusNode?.dispose();
    firstNameTextController?.dispose();

    lastNameFocusNode?.dispose();
    lastNameTextController?.dispose();

    userNameFocusNode?.dispose();
    userNameTextController?.dispose();

    idNumberFocusNode?.dispose();
    idNumberTextController?.dispose();
  }
}
