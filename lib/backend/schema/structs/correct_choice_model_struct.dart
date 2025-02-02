// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CorrectChoiceModelStruct extends FFFirebaseStruct {
  CorrectChoiceModelStruct({
    int? questionIndex,
    int? answerIndex,
    Color? color,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _questionIndex = questionIndex,
        _answerIndex = answerIndex,
        _color = color,
        super(firestoreUtilData);

  // "questionIndex" field.
  int? _questionIndex;
  int get questionIndex => _questionIndex ?? 0;
  set questionIndex(int? val) => _questionIndex = val;

  void incrementQuestionIndex(int amount) =>
      questionIndex = questionIndex + amount;

  bool hasQuestionIndex() => _questionIndex != null;

  // "answerIndex" field.
  int? _answerIndex;
  int get answerIndex => _answerIndex ?? 0;
  set answerIndex(int? val) => _answerIndex = val;

  void incrementAnswerIndex(int amount) => answerIndex = answerIndex + amount;

  bool hasAnswerIndex() => _answerIndex != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  static CorrectChoiceModelStruct fromMap(Map<String, dynamic> data) =>
      CorrectChoiceModelStruct(
        questionIndex: castToType<int>(data['questionIndex']),
        answerIndex: castToType<int>(data['answerIndex']),
        color: getSchemaColor(data['color']),
      );

  static CorrectChoiceModelStruct? maybeFromMap(dynamic data) => data is Map
      ? CorrectChoiceModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'questionIndex': _questionIndex,
        'answerIndex': _answerIndex,
        'color': _color,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'questionIndex': serializeParam(
          _questionIndex,
          ParamType.int,
        ),
        'answerIndex': serializeParam(
          _answerIndex,
          ParamType.int,
        ),
        'color': serializeParam(
          _color,
          ParamType.Color,
        ),
      }.withoutNulls;

  static CorrectChoiceModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CorrectChoiceModelStruct(
        questionIndex: deserializeParam(
          data['questionIndex'],
          ParamType.int,
          false,
        ),
        answerIndex: deserializeParam(
          data['answerIndex'],
          ParamType.int,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.Color,
          false,
        ),
      );

  @override
  String toString() => 'CorrectChoiceModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CorrectChoiceModelStruct &&
        questionIndex == other.questionIndex &&
        answerIndex == other.answerIndex &&
        color == other.color;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([questionIndex, answerIndex, color]);
}

CorrectChoiceModelStruct createCorrectChoiceModelStruct({
  int? questionIndex,
  int? answerIndex,
  Color? color,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CorrectChoiceModelStruct(
      questionIndex: questionIndex,
      answerIndex: answerIndex,
      color: color,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CorrectChoiceModelStruct? updateCorrectChoiceModelStruct(
  CorrectChoiceModelStruct? correctChoiceModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    correctChoiceModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCorrectChoiceModelStructData(
  Map<String, dynamic> firestoreData,
  CorrectChoiceModelStruct? correctChoiceModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (correctChoiceModel == null) {
    return;
  }
  if (correctChoiceModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && correctChoiceModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final correctChoiceModelData =
      getCorrectChoiceModelFirestoreData(correctChoiceModel, forFieldValue);
  final nestedData =
      correctChoiceModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      correctChoiceModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCorrectChoiceModelFirestoreData(
  CorrectChoiceModelStruct? correctChoiceModel, [
  bool forFieldValue = false,
]) {
  if (correctChoiceModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(correctChoiceModel.toMap());

  // Add any Firestore field values
  correctChoiceModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCorrectChoiceModelListFirestoreData(
  List<CorrectChoiceModelStruct>? correctChoiceModels,
) =>
    correctChoiceModels
        ?.map((e) => getCorrectChoiceModelFirestoreData(e, true))
        .toList() ??
    [];
