import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'register_i_d_widget.dart' show RegisterIDWidget;
import 'package:flutter/material.dart';

class RegisterIDModel extends FlutterFlowModel<RegisterIDWidget> {
  ///  Local state fields for this page.

  String selectTitle = 'Upload your personal photo (\u1309\u122D\u12F5 \u134E\u1276) ';

  bool photoSelected = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();

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
  // No mask - just uppercase, no spaces
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

  // State field(s) for Department searchable dropdown.
  String? collegeDropDownValue;
  FormFieldController<String>? collegeDropDownValueController;

  // State field(s) for StudyLevelDropDown widget.
  String? studyLevelDropDownValue;
  FormFieldController<String>? studyLevelDropDownValueController;

  // State field(s) for Admission dropdown.
  String? admissionDropDownValue;
  FormFieldController<String>? admissionDropDownValueController;

  // State field(s) for Phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {
    yourNameTextControllerValidator = _yourNameTextControllerValidator;
    idNumberTextControllerValidator = _idNumberTextControllerValidator;
    // dropdowns don't need validators in initState
  }

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    idNumberFocusNode?.dispose();
    idNumberTextController?.dispose();

    // dropdowns dispose automatically

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }
}
