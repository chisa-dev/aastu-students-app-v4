import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GradeRecord extends FirestoreRecord {
  GradeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Grade');

  static Stream<GradeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GradeRecord.fromSnapshot(s));

  static Future<GradeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GradeRecord.fromSnapshot(s));

  static GradeRecord fromSnapshot(DocumentSnapshot snapshot) => GradeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GradeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GradeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GradeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GradeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGradeRecordData({
  String? id,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
    }.withoutNulls,
  );

  return firestoreData;
}

class GradeRecordDocumentEquality implements Equality<GradeRecord> {
  const GradeRecordDocumentEquality();

  @override
  bool equals(GradeRecord? e1, GradeRecord? e2) {
    return e1?.id == e2?.id;
  }

  @override
  int hash(GradeRecord? e) => const ListEquality().hash([e?.id]);

  @override
  bool isValidKey(Object? o) => o is GradeRecord;
}
