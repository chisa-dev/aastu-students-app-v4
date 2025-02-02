import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyVirtualIDRecord extends FirestoreRecord {
  MyVirtualIDRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "fullName" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  // "id_number" field.
  String? _idNumber;
  String get idNumber => _idNumber ?? '';
  bool hasIdNumber() => _idNumber != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  bool hasDepartment() => _department != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "barcode" field.
  String? _barcode;
  String get barcode => _barcode ?? '';
  bool hasBarcode() => _barcode != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  bool hasCreatedBy() => _createdBy != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "photo_blur" field.
  String? _photoBlur;
  String get photoBlur => _photoBlur ?? '';
  bool hasPhotoBlur() => _photoBlur != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _fullName = snapshotData['fullName'] as String?;
    _idNumber = snapshotData['id_number'] as String?;
    _department = snapshotData['department'] as String?;
    _gender = snapshotData['gender'] as String?;
    _barcode = snapshotData['barcode'] as String?;
    _createdAt = snapshotData['created_at'] as String?;
    _createdBy = snapshotData['created_by'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _photoBlur = snapshotData['photo_blur'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('MyVirtualID');

  static Stream<MyVirtualIDRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyVirtualIDRecord.fromSnapshot(s));

  static Future<MyVirtualIDRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyVirtualIDRecord.fromSnapshot(s));

  static MyVirtualIDRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MyVirtualIDRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyVirtualIDRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyVirtualIDRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyVirtualIDRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyVirtualIDRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyVirtualIDRecordData({
  String? uid,
  String? fullName,
  String? idNumber,
  String? department,
  String? gender,
  String? barcode,
  String? createdAt,
  String? createdBy,
  String? photoUrl,
  String? photoBlur,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'id_number': idNumber,
      'department': department,
      'gender': gender,
      'barcode': barcode,
      'created_at': createdAt,
      'created_by': createdBy,
      'photo_url': photoUrl,
      'photo_blur': photoBlur,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyVirtualIDRecordDocumentEquality implements Equality<MyVirtualIDRecord> {
  const MyVirtualIDRecordDocumentEquality();

  @override
  bool equals(MyVirtualIDRecord? e1, MyVirtualIDRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.fullName == e2?.fullName &&
        e1?.idNumber == e2?.idNumber &&
        e1?.department == e2?.department &&
        e1?.gender == e2?.gender &&
        e1?.barcode == e2?.barcode &&
        e1?.createdAt == e2?.createdAt &&
        e1?.createdBy == e2?.createdBy &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.photoBlur == e2?.photoBlur;
  }

  @override
  int hash(MyVirtualIDRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.fullName,
        e?.idNumber,
        e?.department,
        e?.gender,
        e?.barcode,
        e?.createdAt,
        e?.createdBy,
        e?.photoUrl,
        e?.photoBlur
      ]);

  @override
  bool isValidKey(Object? o) => o is MyVirtualIDRecord;
}
