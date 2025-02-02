import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'save_gpa_component_model.dart';
export 'save_gpa_component_model.dart';

class SaveGpaComponentWidget extends StatefulWidget {
  const SaveGpaComponentWidget({
    super.key,
    this.result,
    this.gpa,
  });

  final StudentResultStruct? result;
  final List<MyGPAStruct>? gpa;

  @override
  State<SaveGpaComponentWidget> createState() => _SaveGpaComponentWidgetState();
}

class _SaveGpaComponentWidgetState extends State<SaveGpaComponentWidget> {
  late SaveGpaComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SaveGpaComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
              spreadRadius: 0.0,
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Give Title',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
              TextFormField(
                controller: _model.textController,
                focusNode: _model.textFieldFocusNode,
                autofocus: false,
                textInputAction: TextInputAction.done,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: '2nd Year Semester one ',
                  hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Figtree',
                        letterSpacing: 0.0,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      letterSpacing: 0.0,
                    ),
                minLines: 1,
                validator: _model.textControllerValidator.asValidator(context),
              ),
              FFButtonWidget(
                onPressed: () async {
                  var gradeRecordReference =
                      GradeRecord.collection.doc(currentUserUid);
                  await gradeRecordReference.set(createGradeRecordData(
                    id: currentUserUid,
                  ));
                  _model.gpaCreated = GradeRecord.getDocumentFromData(
                      createGradeRecordData(
                        id: currentUserUid,
                      ),
                      gradeRecordReference);

                  var myGradeRecordReference =
                      MyGradeRecord.createDoc(_model.gpaCreated!.reference);
                  await myGradeRecordReference.set({
                    ...createMyGradeRecordData(
                      title: valueOrDefault<String>(
                        _model.textController.text,
                        'Semester Grade',
                      ),
                      gpa: widget!.result?.gpa,
                      totalCourses: widget!.result?.totalCourses,
                      totalCreditHour: widget!.result?.totalCreditHour,
                      uid: currentUserUid,
                    ),
                    ...mapToFirestore(
                      {
                        'detailList': getMyGPAListFirestoreData(
                          widget!.gpa,
                        ),
                        'created_at': FieldValue.serverTimestamp(),
                      },
                    ),
                  });
                  _model.myGradeCreated = MyGradeRecord.getDocumentFromData({
                    ...createMyGradeRecordData(
                      title: valueOrDefault<String>(
                        _model.textController.text,
                        'Semester Grade',
                      ),
                      gpa: widget!.result?.gpa,
                      totalCourses: widget!.result?.totalCourses,
                      totalCreditHour: widget!.result?.totalCreditHour,
                      uid: currentUserUid,
                    ),
                    ...mapToFirestore(
                      {
                        'detailList': getMyGPAListFirestoreData(
                          widget!.gpa,
                        ),
                        'created_at': DateTime.now(),
                      },
                    ),
                  }, myGradeRecordReference);
                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: 'Submit',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Figtree',
                        color: FlutterFlowTheme.of(context).info,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
