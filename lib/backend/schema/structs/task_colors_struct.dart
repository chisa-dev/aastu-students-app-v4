// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TaskColorsStruct extends FFFirebaseStruct {
  TaskColorsStruct({
    Color? assignement,
    Color? test,
    Color? other,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _assignement = assignement,
        _test = test,
        _other = other,
        super(firestoreUtilData);

  // "assignement" field.
  Color? _assignement;
  Color get assignement => _assignement ?? const Color(0xFF735BF1);
  set assignement(Color? val) => _assignement = val;

  bool hasAssignement() => _assignement != null;

  // "test" field.
  Color? _test;
  Color get test => _test ?? const Color(0xFF00E5FF);
  set test(Color? val) => _test = val;

  bool hasTest() => _test != null;

  // "other" field.
  Color? _other;
  Color get other => _other ?? const Color(0xFFFF4181);
  set other(Color? val) => _other = val;

  bool hasOther() => _other != null;

  static TaskColorsStruct fromMap(Map<String, dynamic> data) =>
      TaskColorsStruct(
        assignement: getSchemaColor(data['assignement']),
        test: getSchemaColor(data['test']),
        other: getSchemaColor(data['other']),
      );

  static TaskColorsStruct? maybeFromMap(dynamic data) => data is Map
      ? TaskColorsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'assignement': _assignement,
        'test': _test,
        'other': _other,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'assignement': serializeParam(
          _assignement,
          ParamType.Color,
        ),
        'test': serializeParam(
          _test,
          ParamType.Color,
        ),
        'other': serializeParam(
          _other,
          ParamType.Color,
        ),
      }.withoutNulls;

  static TaskColorsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TaskColorsStruct(
        assignement: deserializeParam(
          data['assignement'],
          ParamType.Color,
          false,
        ),
        test: deserializeParam(
          data['test'],
          ParamType.Color,
          false,
        ),
        other: deserializeParam(
          data['other'],
          ParamType.Color,
          false,
        ),
      );

  @override
  String toString() => 'TaskColorsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TaskColorsStruct &&
        assignement == other.assignement &&
        test == other.test &&
        other == other.other;
  }

  @override
  int get hashCode => const ListEquality().hash([assignement, test, other]);
}

TaskColorsStruct createTaskColorsStruct({
  Color? assignement,
  Color? test,
  Color? other,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TaskColorsStruct(
      assignement: assignement,
      test: test,
      other: other,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TaskColorsStruct? updateTaskColorsStruct(
  TaskColorsStruct? taskColors, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    taskColors
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTaskColorsStructData(
  Map<String, dynamic> firestoreData,
  TaskColorsStruct? taskColors,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (taskColors == null) {
    return;
  }
  if (taskColors.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && taskColors.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final taskColorsData = getTaskColorsFirestoreData(taskColors, forFieldValue);
  final nestedData = taskColorsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = taskColors.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTaskColorsFirestoreData(
  TaskColorsStruct? taskColors, [
  bool forFieldValue = false,
]) {
  if (taskColors == null) {
    return {};
  }
  final firestoreData = mapToFirestore(taskColors.toMap());

  // Add any Firestore field values
  taskColors.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTaskColorsListFirestoreData(
  List<TaskColorsStruct>? taskColorss,
) =>
    taskColorss?.map((e) => getTaskColorsFirestoreData(e, true)).toList() ?? [];
