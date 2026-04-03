import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyNegaritRecord extends FirestoreRecord {
  DailyNegaritRecord._(
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
      FirebaseFirestore.instance.collection('DailyNegarit');

  static Stream<DailyNegaritRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyNegaritRecord.fromSnapshot(s));

  static Future<DailyNegaritRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyNegaritRecord.fromSnapshot(s));

  static DailyNegaritRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyNegaritRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyNegaritRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyNegaritRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyNegaritRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyNegaritRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyNegaritRecordData({
  String? id,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyNegaritRecordDocumentEquality
    implements Equality<DailyNegaritRecord> {
  const DailyNegaritRecordDocumentEquality();

  @override
  bool equals(DailyNegaritRecord? e1, DailyNegaritRecord? e2) {
    return e1?.id == e2?.id;
  }

  @override
  int hash(DailyNegaritRecord? e) => const ListEquality().hash([e?.id]);

  @override
  bool isValidKey(Object? o) => o is DailyNegaritRecord;
}
