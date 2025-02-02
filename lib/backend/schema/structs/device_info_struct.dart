// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeviceInfoStruct extends FFFirebaseStruct {
  DeviceInfoStruct({
    String? model,
    String? osVersion,
    String? appVersion,
    String? buildNumber,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _model = model,
        _osVersion = osVersion,
        _appVersion = appVersion,
        _buildNumber = buildNumber,
        super(firestoreUtilData);

  // "model" field.
  String? _model;
  String get model => _model ?? '';
  set model(String? val) => _model = val;

  bool hasModel() => _model != null;

  // "osVersion" field.
  String? _osVersion;
  String get osVersion => _osVersion ?? '';
  set osVersion(String? val) => _osVersion = val;

  bool hasOsVersion() => _osVersion != null;

  // "appVersion" field.
  String? _appVersion;
  String get appVersion => _appVersion ?? '';
  set appVersion(String? val) => _appVersion = val;

  bool hasAppVersion() => _appVersion != null;

  // "buildNumber" field.
  String? _buildNumber;
  String get buildNumber => _buildNumber ?? '';
  set buildNumber(String? val) => _buildNumber = val;

  bool hasBuildNumber() => _buildNumber != null;

  static DeviceInfoStruct fromMap(Map<String, dynamic> data) =>
      DeviceInfoStruct(
        model: data['model'] as String?,
        osVersion: data['osVersion'] as String?,
        appVersion: data['appVersion'] as String?,
        buildNumber: data['buildNumber'] as String?,
      );

  static DeviceInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? DeviceInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'model': _model,
        'osVersion': _osVersion,
        'appVersion': _appVersion,
        'buildNumber': _buildNumber,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'model': serializeParam(
          _model,
          ParamType.String,
        ),
        'osVersion': serializeParam(
          _osVersion,
          ParamType.String,
        ),
        'appVersion': serializeParam(
          _appVersion,
          ParamType.String,
        ),
        'buildNumber': serializeParam(
          _buildNumber,
          ParamType.String,
        ),
      }.withoutNulls;

  static DeviceInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      DeviceInfoStruct(
        model: deserializeParam(
          data['model'],
          ParamType.String,
          false,
        ),
        osVersion: deserializeParam(
          data['osVersion'],
          ParamType.String,
          false,
        ),
        appVersion: deserializeParam(
          data['appVersion'],
          ParamType.String,
          false,
        ),
        buildNumber: deserializeParam(
          data['buildNumber'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DeviceInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DeviceInfoStruct &&
        model == other.model &&
        osVersion == other.osVersion &&
        appVersion == other.appVersion &&
        buildNumber == other.buildNumber;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([model, osVersion, appVersion, buildNumber]);
}

DeviceInfoStruct createDeviceInfoStruct({
  String? model,
  String? osVersion,
  String? appVersion,
  String? buildNumber,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DeviceInfoStruct(
      model: model,
      osVersion: osVersion,
      appVersion: appVersion,
      buildNumber: buildNumber,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DeviceInfoStruct? updateDeviceInfoStruct(
  DeviceInfoStruct? deviceInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    deviceInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDeviceInfoStructData(
  Map<String, dynamic> firestoreData,
  DeviceInfoStruct? deviceInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (deviceInfo == null) {
    return;
  }
  if (deviceInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && deviceInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final deviceInfoData = getDeviceInfoFirestoreData(deviceInfo, forFieldValue);
  final nestedData = deviceInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = deviceInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDeviceInfoFirestoreData(
  DeviceInfoStruct? deviceInfo, [
  bool forFieldValue = false,
]) {
  if (deviceInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(deviceInfo.toMap());

  // Add any Firestore field values
  deviceInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDeviceInfoListFirestoreData(
  List<DeviceInfoStruct>? deviceInfos,
) =>
    deviceInfos?.map((e) => getDeviceInfoFirestoreData(e, true)).toList() ?? [];
