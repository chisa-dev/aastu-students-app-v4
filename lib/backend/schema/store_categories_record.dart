import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoreCategoriesRecord extends FirestoreRecord {
  StoreCategoriesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  bool hasIcon() => _icon != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _icon = snapshotData['icon'] as String?;
    _order = castToType<int>(snapshotData['order']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('store_categories');

  static Stream<StoreCategoriesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StoreCategoriesRecord.fromSnapshot(s));

  static Future<StoreCategoriesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => StoreCategoriesRecord.fromSnapshot(s));

  static StoreCategoriesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StoreCategoriesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StoreCategoriesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StoreCategoriesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StoreCategoriesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoreCategoriesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoreCategoriesRecordData({
  String? name,
  String? icon,
  int? order,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'icon': icon,
      'order': order,
    }.withoutNulls,
  );

  return firestoreData;
}

class StoreCategoriesRecordDocumentEquality
    implements Equality<StoreCategoriesRecord> {
  const StoreCategoriesRecordDocumentEquality();

  @override
  bool equals(StoreCategoriesRecord? e1, StoreCategoriesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.icon == e2?.icon &&
        e1?.order == e2?.order;
  }

  @override
  int hash(StoreCategoriesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.icon,
        e?.order,
      ]);

  @override
  bool isValidKey(Object? o) => o is StoreCategoriesRecord;
}
