import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyGradeRecord extends FirestoreRecord {
  MyGradeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "gpa" field.
  String? _gpa;
  String get gpa => _gpa ?? '';
  bool hasGpa() => _gpa != null;

  // "totalCourses" field.
  int? _totalCourses;
  int get totalCourses => _totalCourses ?? 0;
  bool hasTotalCourses() => _totalCourses != null;

  // "totalCreditHour" field.
  int? _totalCreditHour;
  int get totalCreditHour => _totalCreditHour ?? 0;
  bool hasTotalCreditHour() => _totalCreditHour != null;

  // "detailList" field.
  List<MyGPAStruct>? _detailList;
  List<MyGPAStruct> get detailList => _detailList ?? const [];
  bool hasDetailList() => _detailList != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _gpa = snapshotData['gpa'] as String?;
    _totalCourses = castToType<int>(snapshotData['totalCourses']);
    _totalCreditHour = castToType<int>(snapshotData['totalCreditHour']);
    _detailList = getStructList(
      snapshotData['detailList'],
      MyGPAStruct.fromMap,
    );
    _uid = snapshotData['uid'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('myGrade')
          : FirebaseFirestore.instance.collectionGroup('myGrade');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('myGrade').doc(id);

  static Stream<MyGradeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyGradeRecord.fromSnapshot(s));

  static Future<MyGradeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyGradeRecord.fromSnapshot(s));

  static MyGradeRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MyGradeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyGradeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyGradeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyGradeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyGradeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyGradeRecordData({
  String? title,
  String? gpa,
  int? totalCourses,
  int? totalCreditHour,
  String? uid,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'gpa': gpa,
      'totalCourses': totalCourses,
      'totalCreditHour': totalCreditHour,
      'uid': uid,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyGradeRecordDocumentEquality implements Equality<MyGradeRecord> {
  const MyGradeRecordDocumentEquality();

  @override
  bool equals(MyGradeRecord? e1, MyGradeRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.gpa == e2?.gpa &&
        e1?.totalCourses == e2?.totalCourses &&
        e1?.totalCreditHour == e2?.totalCreditHour &&
        listEquality.equals(e1?.detailList, e2?.detailList) &&
        e1?.uid == e2?.uid &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(MyGradeRecord? e) => const ListEquality().hash([
        e?.title,
        e?.gpa,
        e?.totalCourses,
        e?.totalCreditHour,
        e?.detailList,
        e?.uid,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is MyGradeRecord;
}
