// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OfficialStruct extends FFFirebaseStruct {
  OfficialStruct({
    String? name,
    String? title,
    String? photoUrl,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _title = title,
        _photoUrl = photoUrl,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  set photoUrl(String? val) => _photoUrl = val;

  bool hasPhotoUrl() => _photoUrl != null;

  static OfficialStruct fromMap(Map<String, dynamic> data) => OfficialStruct(
        name: data['name'] as String?,
        title: data['title'] as String?,
        photoUrl: data['photo_url'] as String?,
      );

  static OfficialStruct? maybeFromMap(dynamic data) =>
      data is Map ? OfficialStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'title': _title,
        'photo_url': _photoUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'photo_url': serializeParam(
          _photoUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static OfficialStruct fromSerializableMap(Map<String, dynamic> data) =>
      OfficialStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        photoUrl: deserializeParam(
          data['photo_url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OfficialStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OfficialStruct &&
        name == other.name &&
        title == other.title &&
        photoUrl == other.photoUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([name, title, photoUrl]);
}

OfficialStruct createOfficialStruct({
  String? name,
  String? title,
  String? photoUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OfficialStruct(
      name: name,
      title: title,
      photoUrl: photoUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OfficialStruct? updateOfficialStruct(
  OfficialStruct? official, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    official
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOfficialStructData(
  Map<String, dynamic> firestoreData,
  OfficialStruct? official,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (official == null) {
    return;
  }
  if (official.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && official.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final officialData = getOfficialFirestoreData(official, forFieldValue);
  final nestedData = officialData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = official.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOfficialFirestoreData(
  OfficialStruct? official, [
  bool forFieldValue = false,
]) {
  if (official == null) {
    return {};
  }
  final firestoreData = mapToFirestore(official.toMap());

  // Add any Firestore field values
  official.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOfficialListFirestoreData(
  List<OfficialStruct>? officials,
) =>
    officials?.map((e) => getOfficialFirestoreData(e, true)).toList() ?? [];
