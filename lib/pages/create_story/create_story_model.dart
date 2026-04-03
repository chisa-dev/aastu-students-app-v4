import '/flutter_flow/flutter_flow_util.dart';
import 'create_story_widget.dart' show CreateStoryWidget;
import 'package:flutter/material.dart';

class CreateStoryModel extends FlutterFlowModel<CreateStoryWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  // State field(s) for storyDescription widget.
  FocusNode? storyDescriptionFocusNode;
  TextEditingController? storyDescriptionTextController;
  String? Function(BuildContext, String?)?
      storyDescriptionTextControllerValidator;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    storyDescriptionFocusNode?.dispose();
    storyDescriptionTextController?.dispose();
  }
}
