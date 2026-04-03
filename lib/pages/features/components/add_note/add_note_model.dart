import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_note_widget.dart' show AddNoteWidget;
import 'package:flutter/material.dart';

class AddNoteModel extends FlutterFlowModel<AddNoteWidget> {
  ///  Local state fields for this component.

  String selectedTask = 'assignment';

  String? selectedDate;

  String? selectedStartTime;

  String? selectedEndTime;

  /// Remind me X minutes before (default 15)
  int remindBefore = 15;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NoteName widget.
  FocusNode? noteNameFocusNode;
  TextEditingController? noteNameTextController;
  String? Function(BuildContext, String?)? noteNameTextControllerValidator;
  String? _noteNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  DailyNegaritRecord? dailyNegaritCreated;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MyNotesRecord? myNoteCreated;

  @override
  void initState(BuildContext context) {
    noteNameTextControllerValidator = _noteNameTextControllerValidator;
  }

  @override
  void dispose() {
    noteNameFocusNode?.dispose();
    noteNameTextController?.dispose();
  }
}
