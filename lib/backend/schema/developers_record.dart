import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DevelopersRecord extends FirestoreRecord {
  DevelopersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "linkedin_url" field.
  String? _linkedinUrl;
  String get linkedinUrl => _linkedinUrl ?? '';
  bool hasLinkedinUrl() => _linkedinUrl != null;

  // "position" field.
  String? _position;
  String get position => _position ?? '';
  bool hasPosition() => _position != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  bool hasIndex() => _index != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _linkedinUrl = snapshotData['linkedin_url'] as String?;
    _position = snapshotData['position'] as String?;
    _index = castToType<int>(snapshotData['index']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Developers');

  static Stream<DevelopersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DevelopersRecord.fromSnapshot(s));

  static Future<DevelopersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DevelopersRecord.fromSnapshot(s));

  static DevelopersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DevelopersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DevelopersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DevelopersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DevelopersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DevelopersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDevelopersRecordData({
  String? name,
  String? photoUrl,
  String? linkedinUrl,
  String? position,
  int? index,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'photo_url': photoUrl,
      'linkedin_url': linkedinUrl,
      'position': position,
      'index': index,
    }.withoutNulls,
  );

  return firestoreData;
}

class DevelopersRecordDocumentEquality implements Equality<DevelopersRecord> {
  const DevelopersRecordDocumentEquality();

  @override
  bool equals(DevelopersRecord? e1, DevelopersRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.linkedinUrl == e2?.linkedinUrl &&
        e1?.position == e2?.position &&
        e1?.index == e2?.index;
  }

  @override
  int hash(DevelopersRecord? e) => const ListEquality()
      .hash([e?.name, e?.photoUrl, e?.linkedinUrl, e?.position, e?.index]);

  @override
  bool isValidKey(Object? o) => o is DevelopersRecord;
}
