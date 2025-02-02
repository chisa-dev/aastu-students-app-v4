import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'grade_drop_down_model.dart';
export 'grade_drop_down_model.dart';

class GradeDropDownWidget extends StatefulWidget {
  const GradeDropDownWidget({
    super.key,
    this.value,
    required this.index,
  });

  final String? value;
  final int? index;

  @override
  State<GradeDropDownWidget> createState() => _GradeDropDownWidgetState();
}

class _GradeDropDownWidgetState extends State<GradeDropDownWidget> {
  late GradeDropDownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GradeDropDownModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowDropDown<String>(
      controller: _model.gradeValueController ??= FormFieldController<String>(
        _model.gradeValue ??= widget!.value,
      ),
      options: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F'],
      onChanged: (val) async {
        safeSetState(() => _model.gradeValue = val);
        FFAppState().updateMyGPAListAtIndex(
          widget!.index!,
          (e) => e..grade = _model.gradeValue,
        );
        safeSetState(() {});
      },
      width: 100.0,
      height: 40.0,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Figtree',
            letterSpacing: 0.0,
          ),
      hintText: 'Grade',
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: FlutterFlowTheme.of(context).secondaryText,
        size: 24.0,
      ),
      fillColor: FlutterFlowTheme.of(context).primaryBackground,
      elevation: 2.0,
      borderColor: Color(0x467B99FB),
      borderWidth: 0.0,
      borderRadius: 8.0,
      margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
      hidesUnderline: true,
      isOverButton: false,
      isSearchable: false,
      isMultiSelect: false,
    );
  }
}
