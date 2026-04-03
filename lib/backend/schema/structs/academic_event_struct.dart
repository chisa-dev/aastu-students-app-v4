// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AcademicEventStruct extends FFFirebaseStruct {
  AcademicEventStruct({
    String? title,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? category,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _dateStart = dateStart,
        _dateEnd = dateEnd,
        _category = category,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "date_start" field.
  DateTime? _dateStart;
  DateTime? get dateStart => _dateStart;
  set dateStart(DateTime? val) => _dateStart = val;

  bool hasDateStart() => _dateStart != null;

  // "date_end" field.
  DateTime? _dateEnd;
  DateTime? get dateEnd => _dateEnd;
  set dateEnd(DateTime? val) => _dateEnd = val;

  bool hasDateEnd() => _dateEnd != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  static AcademicEventStruct fromMap(Map<String, dynamic> data) =>
      AcademicEventStruct(
        title: data['title'] as String?,
        dateStart: data['date_start'] as DateTime?,
        dateEnd: data['date_end'] as DateTime?,
        category: data['category'] as String?,
      );

  static AcademicEventStruct? maybeFromMap(dynamic data) => data is Map
      ? AcademicEventStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'date_start': _dateStart,
        'date_end': _dateEnd,
        'category': _category,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'date_start': serializeParam(
          _dateStart,
          ParamType.DateTime,
        ),
        'date_end': serializeParam(
          _dateEnd,
          ParamType.DateTime,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
      }.withoutNulls;

  static AcademicEventStruct fromSerializableMap(Map<String, dynamic> data) =>
      AcademicEventStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        dateStart: deserializeParam(
          data['date_start'],
          ParamType.DateTime,
          false,
        ),
        dateEnd: deserializeParam(
          data['date_end'],
          ParamType.DateTime,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AcademicEventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AcademicEventStruct &&
        title == other.title &&
        dateStart == other.dateStart &&
        dateEnd == other.dateEnd &&
        category == other.category;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, dateStart, dateEnd, category]);
}

AcademicEventStruct createAcademicEventStruct({
  String? title,
  DateTime? dateStart,
  DateTime? dateEnd,
  String? category,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AcademicEventStruct(
      title: title,
      dateStart: dateStart,
      dateEnd: dateEnd,
      category: category,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AcademicEventStruct? updateAcademicEventStruct(
  AcademicEventStruct? academicEvent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    academicEvent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAcademicEventStructData(
  Map<String, dynamic> firestoreData,
  AcademicEventStruct? academicEvent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (academicEvent == null) {
    return;
  }
  if (academicEvent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && academicEvent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final academicEventData =
      getAcademicEventFirestoreData(academicEvent, forFieldValue);
  final nestedData =
      academicEventData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      academicEvent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAcademicEventFirestoreData(
  AcademicEventStruct? academicEvent, [
  bool forFieldValue = false,
]) {
  if (academicEvent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(academicEvent.toMap());

  // Add any Firestore field values
  academicEvent.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAcademicEventListFirestoreData(
  List<AcademicEventStruct>? academicEvents,
) =>
    academicEvents
        ?.map((e) => getAcademicEventFirestoreData(e, true))
        .toList() ??
    [];
