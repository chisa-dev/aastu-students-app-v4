import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BooksRecord extends FirestoreRecord {
  BooksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "image_link" field.
  String? _imageLink;
  String get imageLink => _imageLink ?? '';
  bool hasImageLink() => _imageLink != null;

  // "short_description" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "long_description" field.
  String? _longDescription;
  String get longDescription => _longDescription ?? '';
  bool hasLongDescription() => _longDescription != null;

  // "download_url" field.
  String? _downloadUrl;
  String get downloadUrl => _downloadUrl ?? '';
  bool hasDownloadUrl() => _downloadUrl != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "is_featured" field.
  bool? _isFeatured;
  bool get isFeatured => _isFeatured ?? false;
  bool hasIsFeatured() => _isFeatured != null;

  // "is_recently_added" field.
  bool? _isRecentlyAdded;
  bool get isRecentlyAdded => _isRecentlyAdded ?? false;
  bool hasIsRecentlyAdded() => _isRecentlyAdded != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "photo_blur_hash" field.
  String? _photoBlurHash;
  String get photoBlurHash => _photoBlurHash ?? '';
  bool hasPhotoBlurHash() => _photoBlurHash != null;

  // "author" field.
  String? _author;
  String get author => _author ?? '';
  bool hasAuthor() => _author != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _title = snapshotData['title'] as String?;
    _imageLink = snapshotData['image_link'] as String?;
    _shortDescription = snapshotData['short_description'] as String?;
    _longDescription = snapshotData['long_description'] as String?;
    _downloadUrl = snapshotData['download_url'] as String?;
    _category = snapshotData['category'] as String?;
    _isFeatured = snapshotData['is_featured'] as bool?;
    _isRecentlyAdded = snapshotData['is_recently_added'] as bool?;
    _rating = castToType<double>(snapshotData['rating']);
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _photoBlurHash = snapshotData['photo_blur_hash'] as String?;
    _author = snapshotData['author'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('books');

  static Stream<BooksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BooksRecord.fromSnapshot(s));

  static Future<BooksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BooksRecord.fromSnapshot(s));

  static BooksRecord fromSnapshot(DocumentSnapshot snapshot) => BooksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BooksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BooksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BooksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BooksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBooksRecordData({
  String? id,
  String? title,
  String? imageLink,
  String? shortDescription,
  String? longDescription,
  String? downloadUrl,
  String? category,
  bool? isFeatured,
  bool? isRecentlyAdded,
  double? rating,
  DateTime? createdAt,
  String? photoBlurHash,
  String? author,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'title': title,
      'image_link': imageLink,
      'short_description': shortDescription,
      'long_description': longDescription,
      'download_url': downloadUrl,
      'category': category,
      'is_featured': isFeatured,
      'is_recently_added': isRecentlyAdded,
      'rating': rating,
      'createdAt': createdAt,
      'photo_blur_hash': photoBlurHash,
      'author': author,
    }.withoutNulls,
  );

  return firestoreData;
}

class BooksRecordDocumentEquality implements Equality<BooksRecord> {
  const BooksRecordDocumentEquality();

  @override
  bool equals(BooksRecord? e1, BooksRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.title == e2?.title &&
        e1?.imageLink == e2?.imageLink &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.longDescription == e2?.longDescription &&
        e1?.downloadUrl == e2?.downloadUrl &&
        e1?.category == e2?.category &&
        e1?.isFeatured == e2?.isFeatured &&
        e1?.isRecentlyAdded == e2?.isRecentlyAdded &&
        e1?.rating == e2?.rating &&
        e1?.createdAt == e2?.createdAt &&
        e1?.photoBlurHash == e2?.photoBlurHash &&
        e1?.author == e2?.author;
  }

  @override
  int hash(BooksRecord? e) => const ListEquality().hash([
        e?.id,
        e?.title,
        e?.imageLink,
        e?.shortDescription,
        e?.longDescription,
        e?.downloadUrl,
        e?.category,
        e?.isFeatured,
        e?.isRecentlyAdded,
        e?.rating,
        e?.createdAt,
        e?.photoBlurHash,
        e?.author
      ]);

  @override
  bool isValidKey(Object? o) => o is BooksRecord;
}
