import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeletedUsersRecord extends FirestoreRecord {
  DeletedUsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('deletedUsers');

  static Stream<DeletedUsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DeletedUsersRecord.fromSnapshot(s));

  static Future<DeletedUsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DeletedUsersRecord.fromSnapshot(s));

  static DeletedUsersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DeletedUsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DeletedUsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DeletedUsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DeletedUsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DeletedUsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDeletedUsersRecordData({
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class DeletedUsersRecordDocumentEquality
    implements Equality<DeletedUsersRecord> {
  const DeletedUsersRecordDocumentEquality();

  @override
  bool equals(DeletedUsersRecord? e1, DeletedUsersRecord? e2) {
    return e1?.userRef == e2?.userRef;
  }

  @override
  int hash(DeletedUsersRecord? e) => const ListEquality().hash([e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is DeletedUsersRecord;
}
