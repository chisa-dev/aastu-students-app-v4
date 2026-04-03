import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoreReviewsRecord extends FirestoreRecord {
  StoreReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "item" field.
  DocumentReference? _item;
  DocumentReference? get item => _item;
  bool hasItem() => _item != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _item = snapshotData['item'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _rating = castToType<double>(snapshotData['rating']);
    _comment = snapshotData['comment'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('store_reviews');

  static Stream<StoreReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StoreReviewsRecord.fromSnapshot(s));

  static Future<StoreReviewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StoreReviewsRecord.fromSnapshot(s));

  static StoreReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StoreReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StoreReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StoreReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StoreReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoreReviewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoreReviewsRecordData({
  DocumentReference? item,
  DocumentReference? user,
  double? rating,
  String? comment,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'item': item,
      'user': user,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class StoreReviewsRecordDocumentEquality
    implements Equality<StoreReviewsRecord> {
  const StoreReviewsRecordDocumentEquality();

  @override
  bool equals(StoreReviewsRecord? e1, StoreReviewsRecord? e2) {
    return e1?.item == e2?.item &&
        e1?.user == e2?.user &&
        e1?.rating == e2?.rating &&
        e1?.comment == e2?.comment &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(StoreReviewsRecord? e) => const ListEquality().hash([
        e?.item,
        e?.user,
        e?.rating,
        e?.comment,
        e?.createdAt,
      ]);

  @override
  bool isValidKey(Object? o) => o is StoreReviewsRecord;
}
