import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConstantsRecord extends FirestoreRecord {
  ConstantsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "build_no" field.
  int? _buildNo;
  int get buildNo => _buildNo ?? 0;
  bool hasBuildNo() => _buildNo != null;

  // "academic_calendar_link" field.
  String? _academicCalendarLink;
  String get academicCalendarLink => _academicCalendarLink ?? '';
  bool hasAcademicCalendarLink() => _academicCalendarLink != null;

  // "students_hand_book_link" field.
  String? _studentsHandBookLink;
  String get studentsHandBookLink => _studentsHandBookLink ?? '';
  bool hasStudentsHandBookLink() => _studentsHandBookLink != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _buildNo = castToType<int>(snapshotData['build_no']);
    _academicCalendarLink = snapshotData['academic_calendar_link'] as String?;
    _studentsHandBookLink = snapshotData['students_hand_book_link'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Constants');

  static Stream<ConstantsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConstantsRecord.fromSnapshot(s));

  static Future<ConstantsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ConstantsRecord.fromSnapshot(s));

  static ConstantsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConstantsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConstantsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConstantsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConstantsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConstantsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createConstantsRecordData({
  String? id,
  int? buildNo,
  String? academicCalendarLink,
  String? studentsHandBookLink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'build_no': buildNo,
      'academic_calendar_link': academicCalendarLink,
      'students_hand_book_link': studentsHandBookLink,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConstantsRecordDocumentEquality implements Equality<ConstantsRecord> {
  const ConstantsRecordDocumentEquality();

  @override
  bool equals(ConstantsRecord? e1, ConstantsRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.buildNo == e2?.buildNo &&
        e1?.academicCalendarLink == e2?.academicCalendarLink &&
        e1?.studentsHandBookLink == e2?.studentsHandBookLink;
  }

  @override
  int hash(ConstantsRecord? e) => const ListEquality().hash(
      [e?.id, e?.buildNo, e?.academicCalendarLink, e?.studentsHandBookLink]);

  @override
  bool isValidKey(Object? o) => o is ConstantsRecord;
}
