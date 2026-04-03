// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuizCollectionStruct extends FFFirebaseStruct {
  QuizCollectionStruct({
    int? id,
    String? title,
    List<QuestionModelStruct>? questionsList,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _title = title,
        _questionsList = questionsList,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "QuestionsList" field.
  List<QuestionModelStruct>? _questionsList;
  List<QuestionModelStruct> get questionsList => _questionsList ?? const [];
  set questionsList(List<QuestionModelStruct>? val) => _questionsList = val;

  void updateQuestionsList(Function(List<QuestionModelStruct>) updateFn) {
    updateFn(_questionsList ??= []);
  }

  bool hasQuestionsList() => _questionsList != null;

  static QuizCollectionStruct fromMap(Map<String, dynamic> data) =>
      QuizCollectionStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        questionsList: getStructList(
          data['QuestionsList'],
          QuestionModelStruct.fromMap,
        ),
      );

  static QuizCollectionStruct? maybeFromMap(dynamic data) => data is Map
      ? QuizCollectionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'QuestionsList': _questionsList?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'QuestionsList': serializeParam(
          _questionsList,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static QuizCollectionStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuizCollectionStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        questionsList: deserializeStructParam<QuestionModelStruct>(
          data['QuestionsList'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionModelStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'QuizCollectionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is QuizCollectionStruct &&
        id == other.id &&
        title == other.title &&
        listEquality.equals(questionsList, other.questionsList);
  }

  @override
  int get hashCode => const ListEquality().hash([id, title, questionsList]);
}

QuizCollectionStruct createQuizCollectionStruct({
  int? id,
  String? title,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    QuizCollectionStruct(
      id: id,
      title: title,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

QuizCollectionStruct? updateQuizCollectionStruct(
  QuizCollectionStruct? quizCollection, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    quizCollection
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addQuizCollectionStructData(
  Map<String, dynamic> firestoreData,
  QuizCollectionStruct? quizCollection,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (quizCollection == null) {
    return;
  }
  if (quizCollection.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && quizCollection.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final quizCollectionData =
      getQuizCollectionFirestoreData(quizCollection, forFieldValue);
  final nestedData =
      quizCollectionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = quizCollection.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getQuizCollectionFirestoreData(
  QuizCollectionStruct? quizCollection, [
  bool forFieldValue = false,
]) {
  if (quizCollection == null) {
    return {};
  }
  final firestoreData = mapToFirestore(quizCollection.toMap());

  // Add any Firestore field values
  quizCollection.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getQuizCollectionListFirestoreData(
  List<QuizCollectionStruct>? quizCollections,
) =>
    quizCollections
        ?.map((e) => getQuizCollectionFirestoreData(e, true))
        .toList() ??
    [];
