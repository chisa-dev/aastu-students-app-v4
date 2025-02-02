import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'credit_hour_input_field_model.dart';
export 'credit_hour_input_field_model.dart';

class CreditHourInputFieldWidget extends StatefulWidget {
  const CreditHourInputFieldWidget({
    super.key,
    this.value,
    required this.index,
  });

  final int? value;
  final int? index;

  @override
  State<CreditHourInputFieldWidget> createState() =>
      _CreditHourInputFieldWidgetState();
}

class _CreditHourInputFieldWidgetState
    extends State<CreditHourInputFieldWidget> {
  late CreditHourInputFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreditHourInputFieldModel());

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
      controller: _model.creditHourValueController ??=
          FormFieldController<String>(
        _model.creditHourValue ??= widget!.value?.toString(),
      ),
      options: ['4', '3', '2', '1', '5', '6', '7'],
      onChanged: (val) async {
        safeSetState(() => _model.creditHourValue = val);
        FFAppState().updateMyGPAListAtIndex(
          widget!.index!,
          (e) => e
            ..creditHour = functions.stringToInteger(_model.creditHourValue!),
        );
        safeSetState(() {});
      },
      width: 90.0,
      height: 40.0,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Figtree',
            letterSpacing: 0.0,
          ),
      hintText: 'Credit',
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
