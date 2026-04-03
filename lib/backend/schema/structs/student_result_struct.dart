// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StudentResultStruct extends FFFirebaseStruct {
  StudentResultStruct({
    String? gpa,
    int? totalCourses,
    int? totalCreditHour,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _gpa = gpa,
        _totalCourses = totalCourses,
        _totalCreditHour = totalCreditHour,
        super(firestoreUtilData);

  // "gpa" field.
  String? _gpa;
  String get gpa => _gpa ?? '';
  set gpa(String? val) => _gpa = val;

  bool hasGpa() => _gpa != null;

  // "totalCourses" field.
  int? _totalCourses;
  int get totalCourses => _totalCourses ?? 0;
  set totalCourses(int? val) => _totalCourses = val;

  void incrementTotalCourses(int amount) =>
      totalCourses = totalCourses + amount;

  bool hasTotalCourses() => _totalCourses != null;

  // "totalCreditHour" field.
  int? _totalCreditHour;
  int get totalCreditHour => _totalCreditHour ?? 0;
  set totalCreditHour(int? val) => _totalCreditHour = val;

  void incrementTotalCreditHour(int amount) =>
      totalCreditHour = totalCreditHour + amount;

  bool hasTotalCreditHour() => _totalCreditHour != null;

  static StudentResultStruct fromMap(Map<String, dynamic> data) =>
      StudentResultStruct(
        gpa: data['gpa'] as String?,
        totalCourses: castToType<int>(data['totalCourses']),
        totalCreditHour: castToType<int>(data['totalCreditHour']),
      );

  static StudentResultStruct? maybeFromMap(dynamic data) => data is Map
      ? StudentResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'gpa': _gpa,
        'totalCourses': _totalCourses,
        'totalCreditHour': _totalCreditHour,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'gpa': serializeParam(
          _gpa,
          ParamType.String,
        ),
        'totalCourses': serializeParam(
          _totalCourses,
          ParamType.int,
        ),
        'totalCreditHour': serializeParam(
          _totalCreditHour,
          ParamType.int,
        ),
      }.withoutNulls;

  static StudentResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      StudentResultStruct(
        gpa: deserializeParam(
          data['gpa'],
          ParamType.String,
          false,
        ),
        totalCourses: deserializeParam(
          data['totalCourses'],
          ParamType.int,
          false,
        ),
        totalCreditHour: deserializeParam(
          data['totalCreditHour'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'StudentResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is StudentResultStruct &&
        gpa == other.gpa &&
        totalCourses == other.totalCourses &&
        totalCreditHour == other.totalCreditHour;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([gpa, totalCourses, totalCreditHour]);
}

StudentResultStruct createStudentResultStruct({
  String? gpa,
  int? totalCourses,
  int? totalCreditHour,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    StudentResultStruct(
      gpa: gpa,
      totalCourses: totalCourses,
      totalCreditHour: totalCreditHour,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

StudentResultStruct? updateStudentResultStruct(
  StudentResultStruct? studentResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    studentResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addStudentResultStructData(
  Map<String, dynamic> firestoreData,
  StudentResultStruct? studentResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (studentResult == null) {
    return;
  }
  if (studentResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && studentResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final studentResultData =
      getStudentResultFirestoreData(studentResult, forFieldValue);
  final nestedData =
      studentResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = studentResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getStudentResultFirestoreData(
  StudentResultStruct? studentResult, [
  bool forFieldValue = false,
]) {
  if (studentResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(studentResult.toMap());

  // Add any Firestore field values
  studentResult.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getStudentResultListFirestoreData(
  List<StudentResultStruct>? studentResults,
) =>
    studentResults
        ?.map((e) => getStudentResultFirestoreData(e, true))
        .toList() ??
    [];
