import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PremiumAccountsRecord extends FirestoreRecord {
  PremiumAccountsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "account" field.
  DocumentReference? _account;
  DocumentReference? get account => _account;
  bool hasAccount() => _account != null;

  void _initializeFields() {
    _account = snapshotData['account'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PremiumAccounts');

  static Stream<PremiumAccountsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PremiumAccountsRecord.fromSnapshot(s));

  static Future<PremiumAccountsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PremiumAccountsRecord.fromSnapshot(s));

  static PremiumAccountsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PremiumAccountsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PremiumAccountsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PremiumAccountsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PremiumAccountsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PremiumAccountsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPremiumAccountsRecordData({
  DocumentReference? account,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'account': account,
    }.withoutNulls,
  );

  return firestoreData;
}

class PremiumAccountsRecordDocumentEquality
    implements Equality<PremiumAccountsRecord> {
  const PremiumAccountsRecordDocumentEquality();

  @override
  bool equals(PremiumAccountsRecord? e1, PremiumAccountsRecord? e2) {
    return e1?.account == e2?.account;
  }

  @override
  int hash(PremiumAccountsRecord? e) => const ListEquality().hash([e?.account]);

  @override
  bool isValidKey(Object? o) => o is PremiumAccountsRecord;
}
