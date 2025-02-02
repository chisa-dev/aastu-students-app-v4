import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserPreferencesRecord extends FirestoreRecord {
  UserPreferencesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  bool hasLanguage() => _language != null;

  // "dark_mode" field.
  bool? _darkMode;
  bool get darkMode => _darkMode ?? false;
  bool hasDarkMode() => _darkMode != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _language = snapshotData['language'] as String?;
    _darkMode = snapshotData['dark_mode'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userPreferences');

  static Stream<UserPreferencesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserPreferencesRecord.fromSnapshot(s));

  static Future<UserPreferencesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserPreferencesRecord.fromSnapshot(s));

  static UserPreferencesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserPreferencesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserPreferencesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserPreferencesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserPreferencesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserPreferencesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserPreferencesRecordData({
  String? uid,
  String? language,
  bool? darkMode,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'language': language,
      'dark_mode': darkMode,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserPreferencesRecordDocumentEquality
    implements Equality<UserPreferencesRecord> {
  const UserPreferencesRecordDocumentEquality();

  @override
  bool equals(UserPreferencesRecord? e1, UserPreferencesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.language == e2?.language &&
        e1?.darkMode == e2?.darkMode;
  }

  @override
  int hash(UserPreferencesRecord? e) =>
      const ListEquality().hash([e?.uid, e?.language, e?.darkMode]);

  @override
  bool isValidKey(Object? o) => o is UserPreferencesRecord;
}
