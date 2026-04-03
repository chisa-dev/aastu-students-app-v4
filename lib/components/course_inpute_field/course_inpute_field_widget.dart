import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/data/aastu_courses.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'course_inpute_field_model.dart';
export 'course_inpute_field_model.dart';

class CourseInputeFieldWidget extends StatefulWidget {
  const CourseInputeFieldWidget({
    super.key,
    this.value,
    required this.index,
  });

  final String? value;
  final int? index;

  @override
  State<CourseInputeFieldWidget> createState() =>
      _CourseInputeFieldWidgetState();
}

class _CourseInputeFieldWidgetState extends State<CourseInputeFieldWidget> {
  late CourseInputeFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CourseInputeFieldModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _updateCourse(String value) {
    EasyDebounce.debounce(
      '_model.textController_${widget.index}',
      Duration(milliseconds: 500),
      () {
        FFAppState().updateMyGPAListAtIndex(
          widget.index!,
          (e) => e..course = value,
        );
        safeSetState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: Color(0x357B99FB),
      width: 1.0,
    );
    final borderRadius = BorderRadius.circular(8.0);
    final textStyle = FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'Figtree',
          letterSpacing: 0.0,
        );

    return Autocomplete<String>(
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          final query = textEditingValue.text.toLowerCase();
          return aastuCourses.where(
            (course) => course.toLowerCase().contains(query),
          );
        },
        onSelected: (selection) {
          _model.textController?.text = selection;
          _updateCourse(selection);
        },
        optionsMaxHeight: 200.0,
        optionsViewOpenDirection: OptionsViewOpenDirection.down,
        fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
          // Sync the autocomplete controller with our model controller
          _model.textController = controller;
          _model.textFieldFocusNode = focusNode;
          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (val) => _updateCourse(val),
            autofocus: false,
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.value,
              hintStyle:
                  FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Figtree',
                        letterSpacing: 0.0,
                      ),
              enabledBorder: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: borderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 1.0,
                ),
                borderRadius: borderRadius,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: borderRadius,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: borderRadius,
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            style: textStyle,
            cursorColor: FlutterFlowTheme.of(context).primaryText,
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8.0),
              color: FlutterFlowTheme.of(context).secondaryBackground,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200.0,
                  maxWidth: 280.0,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Text(
                          option,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Figtree',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
  }
}
