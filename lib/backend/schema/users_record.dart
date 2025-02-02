import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "isFollowed" field.
  bool? _isFollowed;
  bool get isFollowed => _isFollowed ?? false;
  bool hasIsFollowed() => _isFollowed != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "id_number" field.
  String? _idNumber;
  String get idNumber => _idNumber ?? '';
  bool hasIdNumber() => _idNumber != null;

  // "collage" field.
  String? _collage;
  String get collage => _collage ?? '';
  bool hasCollage() => _collage != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  bool hasDepartment() => _department != null;

  // "has_virtual_id" field.
  bool? _hasVirtualId;
  bool get hasVirtualId => _hasVirtualId ?? false;
  bool hasHasVirtualId() => _hasVirtualId != null;

  // "isBlocked" field.
  bool? _isBlocked;
  bool get isBlocked => _isBlocked ?? false;
  bool hasIsBlocked() => _isBlocked != null;

  // "isAdmin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  // "appVersion" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  bool hasAppVersion() => _appVersion != null;

  // "batch" field.
  String? _batch;
  String get batch => _batch ?? '';
  bool hasBatch() => _batch != null;

  // "activation_code" field.
  String? _activationCode;
  String get activationCode => _activationCode ?? '';
  bool hasActivationCode() => _activationCode != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "photo_blur_hash" field.
  String? _photoBlurHash;
  String get photoBlurHash => _photoBlurHash ?? '';
  bool hasPhotoBlurHash() => _photoBlurHash != null;

  // "device_info" field.
  String? _deviceInfo;
  String get deviceInfo => _deviceInfo ?? '';
  bool hasDeviceInfo() => _deviceInfo != null;

  // "engagement_score" field.
  int? _engagementScore;
  int get engagementScore => _engagementScore ?? 0;
  bool hasEngagementScore() => _engagementScore != null;

  // "activity_log" field.
  List<String>? _activityLog;
  List<String> get activityLog => _activityLog ?? const [];
  bool hasActivityLog() => _activityLog != null;

  // "online_status" field.
  bool? _onlineStatus;
  bool get onlineStatus => _onlineStatus ?? false;
  bool hasOnlineStatus() => _onlineStatus != null;

  // "account_created_source" field.
  String? _accountCreatedSource;
  String get accountCreatedSource => _accountCreatedSource ?? '';
  bool hasAccountCreatedSource() => _accountCreatedSource != null;

  // "deviceModel" field.
  String? _deviceModel;
  String get deviceModel => _deviceModel ?? '';
  bool hasDeviceModel() => _deviceModel != null;

  // "osVersion" field.
  String? _osVersion;
  String get osVersion => _osVersion ?? '';
  bool hasOsVersion() => _osVersion != null;

  // "buildNumber" field.
  String? _buildNumber;
  String get buildNumber => _buildNumber ?? '';
  bool hasBuildNumber() => _buildNumber != null;

  // "profile_completion" field.
  int? _profileCompletion;
  int get profileCompletion => _profileCompletion ?? 0;
  bool hasProfileCompletion() => _profileCompletion != null;

  // "user_type" field.
  String? _userType;
  String get userType => _userType ?? '';
  bool hasUserType() => _userType != null;

  // "aastu_email" field.
  String? _aastuEmail;
  String get aastuEmail => _aastuEmail ?? '';
  bool hasAastuEmail() => _aastuEmail != null;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _email = snapshotData['email'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _userName = snapshotData['userName'] as String?;
    _bio = snapshotData['bio'] as String?;
    _isFollowed = snapshotData['isFollowed'] as bool?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _title = snapshotData['title'] as String?;
    _idNumber = snapshotData['id_number'] as String?;
    _collage = snapshotData['collage'] as String?;
    _department = snapshotData['department'] as String?;
    _hasVirtualId = snapshotData['has_virtual_id'] as bool?;
    _isBlocked = snapshotData['isBlocked'] as bool?;
    _isAdmin = snapshotData['isAdmin'] as bool?;
    _appVersion = snapshotData['appVersion'] as String?;
    _batch = snapshotData['batch'] as String?;
    _activationCode = snapshotData['activation_code'] as String?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _photoBlurHash = snapshotData['photo_blur_hash'] as String?;
    _deviceInfo = snapshotData['device_info'] as String?;
    _engagementScore = castToType<int>(snapshotData['engagement_score']);
    _activityLog = getDataList(snapshotData['activity_log']);
    _onlineStatus = snapshotData['online_status'] as bool?;
    _accountCreatedSource = snapshotData['account_created_source'] as String?;
    _deviceModel = snapshotData['deviceModel'] as String?;
    _osVersion = snapshotData['osVersion'] as String?;
    _buildNumber = snapshotData['buildNumber'] as String?;
    _profileCompletion = castToType<int>(snapshotData['profile_completion']);
    _userType = snapshotData['user_type'] as String?;
    _aastuEmail = snapshotData['aastu_email'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? displayName,
  String? email,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? userName,
  String? bio,
  bool? isFollowed,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? role,
  String? title,
  String? idNumber,
  String? collage,
  String? department,
  bool? hasVirtualId,
  bool? isBlocked,
  bool? isAdmin,
  String? appVersion,
  String? batch,
  String? activationCode,
  bool? isVerified,
  String? photoBlurHash,
  String? deviceInfo,
  int? engagementScore,
  bool? onlineStatus,
  String? accountCreatedSource,
  String? deviceModel,
  String? osVersion,
  String? buildNumber,
  int? profileCompletion,
  String? userType,
  String? aastuEmail,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'email': email,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'userName': userName,
      'bio': bio,
      'isFollowed': isFollowed,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'role': role,
      'title': title,
      'id_number': idNumber,
      'collage': collage,
      'department': department,
      'has_virtual_id': hasVirtualId,
      'isBlocked': isBlocked,
      'isAdmin': isAdmin,
      'appVersion': appVersion,
      'batch': batch,
      'activation_code': activationCode,
      'isVerified': isVerified,
      'photo_blur_hash': photoBlurHash,
      'device_info': deviceInfo,
      'engagement_score': engagementScore,
      'online_status': onlineStatus,
      'account_created_source': accountCreatedSource,
      'deviceModel': deviceModel,
      'osVersion': osVersion,
      'buildNumber': buildNumber,
      'profile_completion': profileCompletion,
      'user_type': userType,
      'aastu_email': aastuEmail,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.displayName == e2?.displayName &&
        e1?.email == e2?.email &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.userName == e2?.userName &&
        e1?.bio == e2?.bio &&
        e1?.isFollowed == e2?.isFollowed &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.role == e2?.role &&
        e1?.title == e2?.title &&
        e1?.idNumber == e2?.idNumber &&
        e1?.collage == e2?.collage &&
        e1?.department == e2?.department &&
        e1?.hasVirtualId == e2?.hasVirtualId &&
        e1?.isBlocked == e2?.isBlocked &&
        e1?.isAdmin == e2?.isAdmin &&
        e1?.appVersion == e2?.appVersion &&
        e1?.batch == e2?.batch &&
        e1?.activationCode == e2?.activationCode &&
        e1?.isVerified == e2?.isVerified &&
        e1?.photoBlurHash == e2?.photoBlurHash &&
        e1?.deviceInfo == e2?.deviceInfo &&
        e1?.engagementScore == e2?.engagementScore &&
        listEquality.equals(e1?.activityLog, e2?.activityLog) &&
        e1?.onlineStatus == e2?.onlineStatus &&
        e1?.accountCreatedSource == e2?.accountCreatedSource &&
        e1?.deviceModel == e2?.deviceModel &&
        e1?.osVersion == e2?.osVersion &&
        e1?.buildNumber == e2?.buildNumber &&
        e1?.profileCompletion == e2?.profileCompletion &&
        e1?.userType == e2?.userType &&
        e1?.aastuEmail == e2?.aastuEmail;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.displayName,
        e?.email,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.userName,
        e?.bio,
        e?.isFollowed,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.role,
        e?.title,
        e?.idNumber,
        e?.collage,
        e?.department,
        e?.hasVirtualId,
        e?.isBlocked,
        e?.isAdmin,
        e?.appVersion,
        e?.batch,
        e?.activationCode,
        e?.isVerified,
        e?.photoBlurHash,
        e?.deviceInfo,
        e?.engagementScore,
        e?.activityLog,
        e?.onlineStatus,
        e?.accountCreatedSource,
        e?.deviceModel,
        e?.osVersion,
        e?.buildNumber,
        e?.profileCompletion,
        e?.userType,
        e?.aastuEmail
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
