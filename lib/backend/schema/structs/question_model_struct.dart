// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionModelStruct extends FFFirebaseStruct {
  QuestionModelStruct({
    String? query,
    List<String>? choices,
    int? answer,
    String? explanation,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _query = query,
        _choices = choices,
        _answer = answer,
        _explanation = explanation,
        super(firestoreUtilData);

  // "query" field.
  String? _query;
  String get query => _query ?? '';
  set query(String? val) => _query = val;

  bool hasQuery() => _query != null;

  // "choices" field.
  List<String>? _choices;
  List<String> get choices => _choices ?? const [];
  set choices(List<String>? val) => _choices = val;

  void updateChoices(Function(List<String>) updateFn) {
    updateFn(_choices ??= []);
  }

  bool hasChoices() => _choices != null;

  // "answer" field.
  int? _answer;
  int get answer => _answer ?? 0;
  set answer(int? val) => _answer = val;

  void incrementAnswer(int amount) => answer = answer + amount;

  bool hasAnswer() => _answer != null;

  // "explanation" field.
  String? _explanation;
  String get explanation => _explanation ?? '';
  set explanation(String? val) => _explanation = val;

  bool hasExplanation() => _explanation != null;

  static QuestionModelStruct fromMap(Map<String, dynamic> data) =>
      QuestionModelStruct(
        query: data['query'] as String?,
        choices: getDataList(data['choices']),
        answer: castToType<int>(data['answer']),
        explanation: data['explanation'] as String?,
      );

  static QuestionModelStruct? maybeFromMap(dynamic data) => data is Map
      ? QuestionModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'query': _query,
        'choices': _choices,
        'answer': _answer,
        'explanation': _explanation,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'query': serializeParam(
          _query,
          ParamType.String,
        ),
        'choices': serializeParam(
          _choices,
          ParamType.String,
          isList: true,
        ),
        'answer': serializeParam(
          _answer,
          ParamType.int,
        ),
        'explanation': serializeParam(
          _explanation,
          ParamType.String,
        ),
      }.withoutNulls;

  static QuestionModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuestionModelStruct(
        query: deserializeParam(
          data['query'],
          ParamType.String,
          false,
        ),
        choices: deserializeParam<String>(
          data['choices'],
          ParamType.String,
          true,
        ),
        answer: deserializeParam(
          data['answer'],
          ParamType.int,
          false,
        ),
        explanation: deserializeParam(
          data['explanation'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'QuestionModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is QuestionModelStruct &&
        query == other.query &&
        listEquality.equals(choices, other.choices) &&
        answer == other.answer &&
        explanation == other.explanation;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([query, choices, answer, explanation]);
}

QuestionModelStruct createQuestionModelStruct({
  String? query,
  int? answer,
  String? explanation,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuestionModelStruct(
      query: query,
      answer: answer,
      explanation: explanation,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuestionModelStruct? updateQuestionModelStruct(
  QuestionModelStruct? questionModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    questionModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuestionModelStructData(
  Map<String, dynamic> firestoreData,
  QuestionModelStruct? questionModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (questionModel == null) {
    return;
  }
  if (questionModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && questionModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final questionModelData =
      getQuestionModelFirestoreData(questionModel, forFieldValue);
  final nestedData =
      questionModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = questionModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuestionModelFirestoreData(
  QuestionModelStruct? questionModel, [
  bool forFieldValue = false,
]) {
  if (questionModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(questionModel.toMap());

  // Add any Firestore field values
  questionModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuestionModelListFirestoreData(
  List<QuestionModelStruct>? questionModels,
) =>
    questionModels
        ?.map((e) => getQuestionModelFirestoreData(e, true))
        .toList() ??
    [];
