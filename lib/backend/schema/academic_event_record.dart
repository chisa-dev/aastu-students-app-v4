import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AcademicEventRecord extends FirestoreRecord {
  AcademicEventRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "year" field.
  String? _year;
  String get year => _year ?? '';
  bool hasYear() => _year != null;

  // "events" field.
  List<AcademicEventStruct>? _events;
  List<AcademicEventStruct> get events => _events ?? const [];
  bool hasEvents() => _events != null;

  void _initializeFields() {
    _year = snapshotData['year'] as String?;
    _events = getStructList(
      snapshotData['events'],
      AcademicEventStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('academic_events');

  static Stream<AcademicEventRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AcademicEventRecord.fromSnapshot(s));

  static Future<AcademicEventRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AcademicEventRecord.fromSnapshot(s));

  static AcademicEventRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AcademicEventRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AcademicEventRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AcademicEventRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AcademicEventRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AcademicEventRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAcademicEventRecordData({
  String? year,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'year': year,
    }.withoutNulls,
  );

  return firestoreData;
}

class AcademicEventRecordDocumentEquality
    implements Equality<AcademicEventRecord> {
  const AcademicEventRecordDocumentEquality();

  @override
  bool equals(AcademicEventRecord? e1, AcademicEventRecord? e2) {
    const listEquality = ListEquality();
    return e1?.year == e2?.year &&
        listEquality.equals(e1?.events, e2?.events);
  }

  @override
  int hash(AcademicEventRecord? e) =>
      const ListEquality().hash([e?.year, e?.events]);

  @override
  bool isValidKey(Object? o) => o is AcademicEventRecord;
}
