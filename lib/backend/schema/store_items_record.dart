import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoreItemsRecord extends FirestoreRecord {
  StoreItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "telegram_link" field.
  String? _telegramLink;
  String get telegramLink => _telegramLink ?? '';
  bool hasTelegramLink() => _telegramLink != null;

  // "seller" field.
  DocumentReference? _seller;
  DocumentReference? get seller => _seller;
  bool hasSeller() => _seller != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "photo_blur_hash" field.
  String? _photoBlurHash;
  String get photoBlurHash => _photoBlurHash ?? '';
  bool hasPhotoBlurHash() => _photoBlurHash != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _images = getDataList(snapshotData['images']);
    _category = snapshotData['category'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _telegramLink = snapshotData['telegram_link'] as String?;
    _seller = snapshotData['seller'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _photoBlurHash = snapshotData['photo_blur_hash'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('store_items');

  static Stream<StoreItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StoreItemsRecord.fromSnapshot(s));

  static Future<StoreItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StoreItemsRecord.fromSnapshot(s));

  static StoreItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StoreItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StoreItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StoreItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StoreItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoreItemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoreItemsRecordData({
  String? title,
  String? description,
  double? price,
  String? category,
  String? phoneNumber,
  String? telegramLink,
  DocumentReference? seller,
  String? status,
  DateTime? createdAt,
  String? photoBlurHash,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'phone_number': phoneNumber,
      'telegram_link': telegramLink,
      'seller': seller,
      'status': status,
      'created_at': createdAt,
      'photo_blur_hash': photoBlurHash,
    }.withoutNulls,
  );

  return firestoreData;
}

class StoreItemsRecordDocumentEquality implements Equality<StoreItemsRecord> {
  const StoreItemsRecordDocumentEquality();

  @override
  bool equals(StoreItemsRecord? e1, StoreItemsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.price == e2?.price &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.category == e2?.category &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.telegramLink == e2?.telegramLink &&
        e1?.seller == e2?.seller &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt &&
        e1?.photoBlurHash == e2?.photoBlurHash;
  }

  @override
  int hash(StoreItemsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.price,
        e?.images,
        e?.category,
        e?.phoneNumber,
        e?.telegramLink,
        e?.seller,
        e?.status,
        e?.createdAt,
        e?.photoBlurHash,
      ]);

  @override
  bool isValidKey(Object? o) => o is StoreItemsRecord;
}
