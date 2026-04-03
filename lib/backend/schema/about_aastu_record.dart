import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AboutAastuRecord extends FirestoreRecord {
  AboutAastuRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "established" field.
  String? _established;
  String get established => _established ?? '';
  bool hasEstablished() => _established != null;

  // "history" field.
  String? _history;
  String get history => _history ?? '';
  bool hasHistory() => _history != null;

  // "vision" field.
  String? _vision;
  String get vision => _vision ?? '';
  bool hasVision() => _vision != null;

  // "banner_image" field.
  String? _bannerImage;
  String get bannerImage => _bannerImage ?? '';
  bool hasBannerImage() => _bannerImage != null;

  // "logo_image" field.
  String? _logoImage;
  String get logoImage => _logoImage ?? '';
  bool hasLogoImage() => _logoImage != null;

  // "location_title" field.
  String? _locationTitle;
  String get locationTitle => _locationTitle ?? '';
  bool hasLocationTitle() => _locationTitle != null;

  // "location_subtitle" field.
  String? _locationSubtitle;
  String get locationSubtitle => _locationSubtitle ?? '';
  bool hasLocationSubtitle() => _locationSubtitle != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  bool hasLongitude() => _longitude != null;

  // "website_url" field.
  String? _websiteUrl;
  String get websiteUrl => _websiteUrl ?? '';
  bool hasWebsiteUrl() => _websiteUrl != null;

  // "officials_year" field.
  String? _officialsYear;
  String get officialsYear => _officialsYear ?? '';
  bool hasOfficialsYear() => _officialsYear != null;

  // "officials" field.
  List<OfficialStruct>? _officials;
  List<OfficialStruct> get officials => _officials ?? const [];
  bool hasOfficials() => _officials != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _established = snapshotData['established'] as String?;
    _history = snapshotData['history'] as String?;
    _vision = snapshotData['vision'] as String?;
    _bannerImage = snapshotData['banner_image'] as String?;
    _logoImage = snapshotData['logo_image'] as String?;
    _locationTitle = snapshotData['location_title'] as String?;
    _locationSubtitle = snapshotData['location_subtitle'] as String?;
    _latitude = castToType<double>(snapshotData['latitude']);
    _longitude = castToType<double>(snapshotData['longitude']);
    _websiteUrl = snapshotData['website_url'] as String?;
    _officialsYear = snapshotData['officials_year'] as String?;
    _officials = getStructList(
      snapshotData['officials'],
      OfficialStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('about_aastu');

  static Stream<AboutAastuRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AboutAastuRecord.fromSnapshot(s));

  static Future<AboutAastuRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AboutAastuRecord.fromSnapshot(s));

  static AboutAastuRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AboutAastuRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AboutAastuRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AboutAastuRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AboutAastuRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AboutAastuRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAboutAastuRecordData({
  String? title,
  String? established,
  String? history,
  String? vision,
  String? bannerImage,
  String? logoImage,
  String? locationTitle,
  String? locationSubtitle,
  double? latitude,
  double? longitude,
  String? websiteUrl,
  String? officialsYear,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'established': established,
      'history': history,
      'vision': vision,
      'banner_image': bannerImage,
      'logo_image': logoImage,
      'location_title': locationTitle,
      'location_subtitle': locationSubtitle,
      'latitude': latitude,
      'longitude': longitude,
      'website_url': websiteUrl,
      'officials_year': officialsYear,
    }.withoutNulls,
  );

  return firestoreData;
}

class AboutAastuRecordDocumentEquality implements Equality<AboutAastuRecord> {
  const AboutAastuRecordDocumentEquality();

  @override
  bool equals(AboutAastuRecord? e1, AboutAastuRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.established == e2?.established &&
        e1?.history == e2?.history &&
        e1?.vision == e2?.vision &&
        e1?.bannerImage == e2?.bannerImage &&
        e1?.logoImage == e2?.logoImage &&
        e1?.locationTitle == e2?.locationTitle &&
        e1?.locationSubtitle == e2?.locationSubtitle &&
        e1?.latitude == e2?.latitude &&
        e1?.longitude == e2?.longitude &&
        e1?.websiteUrl == e2?.websiteUrl &&
        e1?.officialsYear == e2?.officialsYear &&
        listEquality.equals(e1?.officials, e2?.officials);
  }

  @override
  int hash(AboutAastuRecord? e) => const ListEquality().hash([
        e?.title,
        e?.established,
        e?.history,
        e?.vision,
        e?.bannerImage,
        e?.logoImage,
        e?.locationTitle,
        e?.locationSubtitle,
        e?.latitude,
        e?.longitude,
        e?.websiteUrl,
        e?.officialsYear,
        e?.officials,
      ]);

  @override
  bool isValidKey(Object? o) => o is AboutAastuRecord;
}
