import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'activate_account_widget.dart' show ActivateAccountWidget;
import 'package:flutter/material.dart';

class ActivateAccountModel extends FlutterFlowModel<ActivateAccountWidget> {
  ///  Local state fields for this component.

  bool isValidEmail = false;

  String responseMessage = ' ';

  bool emailSent = false;

  bool buttonClicked = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for aastuEmail widget.
  FocusNode? aastuEmailFocusNode;
  TextEditingController? aastuEmailTextController;
  String? Function(BuildContext, String?)? aastuEmailTextControllerValidator;
  // Stores action output result for [Backend Call - API (Send Confirmation Code)] action in Button widget.
  ApiCallResponse? codeSentAPIRes;
  // State field(s) for activationCode widget.
  FocusNode? activationCodeFocusNode;
  TextEditingController? activationCodeTextController;
  String? Function(BuildContext, String?)?
      activationCodeTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? userLoaded;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    aastuEmailFocusNode?.dispose();
    aastuEmailTextController?.dispose();

    activationCodeFocusNode?.dispose();
    activationCodeTextController?.dispose();
  }
}
