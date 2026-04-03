import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GalleryRecord extends FirestoreRecord {
  GalleryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "uploaded_by" field.
  String? _uploadedBy;
  String get uploadedBy => _uploadedBy ?? '';
  bool hasUploadedBy() => _uploadedBy != null;

  // "uploaded_by_name" field.
  String? _uploadedByName;
  String get uploadedByName => _uploadedByName ?? '';
  bool hasUploadedByName() => _uploadedByName != null;

  // "approved" field.
  bool? _approved;
  bool get approved => _approved ?? false;
  bool hasApproved() => _approved != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "blur_hash" field.
  String? _blurHash;
  String get blurHash => _blurHash ?? '';
  bool hasBlurHash() => _blurHash != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
    _uploadedBy = snapshotData['uploaded_by'] as String?;
    _uploadedByName = snapshotData['uploaded_by_name'] as String?;
    _approved = snapshotData['approved'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _blurHash = snapshotData['blur_hash'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Gallery');

  static Stream<GalleryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GalleryRecord.fromSnapshot(s));

  static Future<GalleryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GalleryRecord.fromSnapshot(s));

  static GalleryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GalleryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GalleryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GalleryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GalleryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GalleryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGalleryRecordData({
  String? id,
  String? imageUrl,
  String? uploadedBy,
  String? uploadedByName,
  bool? approved,
  DateTime? createdAt,
  String? blurHash,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'uploaded_by': uploadedBy,
      'uploaded_by_name': uploadedByName,
      'approved': approved,
      'created_at': createdAt,
      'blur_hash': blurHash,
    }.withoutNulls,
  );

  return firestoreData;
}

class GalleryRecordDocumentEquality implements Equality<GalleryRecord> {
  const GalleryRecordDocumentEquality();

  @override
  bool equals(GalleryRecord? e1, GalleryRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.uploadedBy == e2?.uploadedBy &&
        e1?.uploadedByName == e2?.uploadedByName &&
        e1?.approved == e2?.approved &&
        e1?.createdAt == e2?.createdAt &&
        e1?.blurHash == e2?.blurHash;
  }

  @override
  int hash(GalleryRecord? e) => const ListEquality().hash([
        e?.id,
        e?.imageUrl,
        e?.uploadedBy,
        e?.uploadedByName,
        e?.approved,
        e?.createdAt,
        e?.blurHash
      ]);

  @override
  bool isValidKey(Object? o) => o is GalleryRecord;
}
