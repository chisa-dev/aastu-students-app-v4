// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyGPAStruct extends FFFirebaseStruct {
  MyGPAStruct({
    String? course,
    int? creditHour,
    String? grade,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _course = course,
        _creditHour = creditHour,
        _grade = grade,
        super(firestoreUtilData);

  // "course" field.
  String? _course;
  String get course => _course ?? '';
  set course(String? val) => _course = val;

  bool hasCourse() => _course != null;

  // "creditHour" field.
  int? _creditHour;
  int get creditHour => _creditHour ?? 0;
  set creditHour(int? val) => _creditHour = val;

  void incrementCreditHour(int amount) => creditHour = creditHour + amount;

  bool hasCreditHour() => _creditHour != null;

  // "grade" field.
  String? _grade;
  String get grade => _grade ?? '';
  set grade(String? val) => _grade = val;

  bool hasGrade() => _grade != null;

  static MyGPAStruct fromMap(Map<String, dynamic> data) => MyGPAStruct(
        course: data['course'] as String?,
        creditHour: castToType<int>(data['creditHour']),
        grade: data['grade'] as String?,
      );

  static MyGPAStruct? maybeFromMap(dynamic data) =>
      data is Map ? MyGPAStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'course': _course,
        'creditHour': _creditHour,
        'grade': _grade,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'course': serializeParam(
          _course,
          ParamType.String,
        ),
        'creditHour': serializeParam(
          _creditHour,
          ParamType.int,
        ),
        'grade': serializeParam(
          _grade,
          ParamType.String,
        ),
      }.withoutNulls;

  static MyGPAStruct fromSerializableMap(Map<String, dynamic> data) =>
      MyGPAStruct(
        course: deserializeParam(
          data['course'],
          ParamType.String,
          false,
        ),
        creditHour: deserializeParam(
          data['creditHour'],
          ParamType.int,
          false,
        ),
        grade: deserializeParam(
          data['grade'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MyGPAStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MyGPAStruct &&
        course == other.course &&
        creditHour == other.creditHour &&
        grade == other.grade;
  }

  @override
  int get hashCode => const ListEquality().hash([course, creditHour, grade]);
}

MyGPAStruct createMyGPAStruct({
  String? course,
  int? creditHour,
  String? grade,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MyGPAStruct(
      course: course,
      creditHour: creditHour,
      grade: grade,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MyGPAStruct? updateMyGPAStruct(
  MyGPAStruct? myGPA, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    myGPA
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMyGPAStructData(
  Map<String, dynamic> firestoreData,
  MyGPAStruct? myGPA,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (myGPA == null) {
    return;
  }
  if (myGPA.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && myGPA.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final myGPAData = getMyGPAFirestoreData(myGPA, forFieldValue);
  final nestedData = myGPAData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = myGPA.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMyGPAFirestoreData(
  MyGPAStruct? myGPA, [
  bool forFieldValue = false,
]) {
  if (myGPA == null) {
    return {};
  }
  final firestoreData = mapToFirestore(myGPA.toMap());

  // Add any Firestore field values
  myGPA.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMyGPAListFirestoreData(
  List<MyGPAStruct>? myGPAs,
) =>
    myGPAs?.map((e) => getMyGPAFirestoreData(e, true)).toList() ?? [];
