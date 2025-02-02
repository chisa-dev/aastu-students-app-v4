import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReligiousCommunitiesRecord extends FirestoreRecord {
  ReligiousCommunitiesRecord._(
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

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "logo_url" field.
  String? _logoUrl;
  String get logoUrl => _logoUrl ?? '';
  bool hasLogoUrl() => _logoUrl != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "uploaded_by" field.
  String? _uploadedBy;
  String get uploadedBy => _uploadedBy ?? '';
  bool hasUploadedBy() => _uploadedBy != null;

  // "uploaded_by_name" field.
  String? _uploadedByName;
  String get uploadedByName => _uploadedByName ?? '';
  bool hasUploadedByName() => _uploadedByName != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _id = snapshotData['id'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _logoUrl = snapshotData['logo_url'] as String?;
    _url = snapshotData['url'] as String?;
    _uploadedBy = snapshotData['uploaded_by'] as String?;
    _uploadedByName = snapshotData['uploaded_by_name'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ReligiousCommunities');

  static Stream<ReligiousCommunitiesRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => ReligiousCommunitiesRecord.fromSnapshot(s));

  static Future<ReligiousCommunitiesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ReligiousCommunitiesRecord.fromSnapshot(s));

  static ReligiousCommunitiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReligiousCommunitiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReligiousCommunitiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReligiousCommunitiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReligiousCommunitiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReligiousCommunitiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReligiousCommunitiesRecordData({
  String? id,
  String? title,
  String? description,
  String? logoUrl,
  String? url,
  String? uploadedBy,
  String? uploadedByName,
  DateTime? createdAt,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'logo_url': logoUrl,
      'url': url,
      'uploaded_by': uploadedBy,
      'uploaded_by_name': uploadedByName,
      'created_at': createdAt,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReligiousCommunitiesRecordDocumentEquality
    implements Equality<ReligiousCommunitiesRecord> {
  const ReligiousCommunitiesRecordDocumentEquality();

  @override
  bool equals(ReligiousCommunitiesRecord? e1, ReligiousCommunitiesRecord? e2) {
    return e1?.id == e2?.id &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.logoUrl == e2?.logoUrl &&
        e1?.url == e2?.url &&
        e1?.uploadedBy == e2?.uploadedBy &&
        e1?.uploadedByName == e2?.uploadedByName &&
        e1?.createdAt == e2?.createdAt &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(ReligiousCommunitiesRecord? e) => const ListEquality().hash([
        e?.id,
        e?.title,
        e?.description,
        e?.logoUrl,
        e?.url,
        e?.uploadedBy,
        e?.uploadedByName,
        e?.createdAt,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is ReligiousCommunitiesRecord;
}
