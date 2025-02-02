import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _NoteAdded = prefs.getBool('ff_NoteAdded') ?? _NoteAdded;
    });
    _safeInit(() {
      _questionsListIndex =
          prefs.getInt('ff_questionsListIndex') ?? _questionsListIndex;
    });
    _safeInit(() {
      _QuizCollectionData = prefs
              .getStringList('ff_QuizCollectionData')
              ?.map((x) {
                try {
                  return QuizCollectionStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _QuizCollectionData;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<MyGPAStruct> _MyGPAList = [
    MyGPAStruct.fromSerializableMap(jsonDecode(
        '{\"course\":\"Course 1\",\"creditHour\":\"4\",\"grade\":\"A\"}')),
    MyGPAStruct.fromSerializableMap(jsonDecode(
        '{\"course\":\"Course 2\",\"creditHour\":\"4\",\"grade\":\"A\"}')),
    MyGPAStruct.fromSerializableMap(jsonDecode(
        '{\"course\":\"Course 3\",\"creditHour\":\"4\",\"grade\":\"A\"}'))
  ];
  List<MyGPAStruct> get MyGPAList => _MyGPAList;
  set MyGPAList(List<MyGPAStruct> value) {
    _MyGPAList = value;
  }

  void addToMyGPAList(MyGPAStruct value) {
    MyGPAList.add(value);
  }

  void removeFromMyGPAList(MyGPAStruct value) {
    MyGPAList.remove(value);
  }

  void removeAtIndexFromMyGPAList(int index) {
    MyGPAList.removeAt(index);
  }

  void updateMyGPAListAtIndex(
    int index,
    MyGPAStruct Function(MyGPAStruct) updateFn,
  ) {
    MyGPAList[index] = updateFn(_MyGPAList[index]);
  }

  void insertAtIndexInMyGPAList(int index, MyGPAStruct value) {
    MyGPAList.insert(index, value);
  }

  int _gradeIndex = 4;
  int get gradeIndex => _gradeIndex;
  set gradeIndex(int value) {
    _gradeIndex = value;
  }

  TaskColorsStruct _taskColors = TaskColorsStruct.fromSerializableMap(jsonDecode(
      '{\"assignement\":\"#735bf1\",\"test\":\"#00e5ff\",\"other\":\"#ff4181\"}'));
  TaskColorsStruct get taskColors => _taskColors;
  set taskColors(TaskColorsStruct value) {
    _taskColors = value;
  }

  void updateTaskColorsStruct(Function(TaskColorsStruct) updateFn) {
    updateFn(_taskColors);
  }

  bool _NoteAdded = false;
  bool get NoteAdded => _NoteAdded;
  set NoteAdded(bool value) {
    _NoteAdded = value;
    prefs.setBool('ff_NoteAdded', value);
  }

  int _questionsListIndex = 1;
  int get questionsListIndex => _questionsListIndex;
  set questionsListIndex(int value) {
    _questionsListIndex = value;
    prefs.setInt('ff_questionsListIndex', value);
  }

  List<QuizCollectionStruct> _QuizCollectionData = [];
  List<QuizCollectionStruct> get QuizCollectionData => _QuizCollectionData;
  set QuizCollectionData(List<QuizCollectionStruct> value) {
    _QuizCollectionData = value;
    prefs.setStringList(
        'ff_QuizCollectionData', value.map((x) => x.serialize()).toList());
  }

  void addToQuizCollectionData(QuizCollectionStruct value) {
    QuizCollectionData.add(value);
    prefs.setStringList('ff_QuizCollectionData',
        _QuizCollectionData.map((x) => x.serialize()).toList());
  }

  void removeFromQuizCollectionData(QuizCollectionStruct value) {
    QuizCollectionData.remove(value);
    prefs.setStringList('ff_QuizCollectionData',
        _QuizCollectionData.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromQuizCollectionData(int index) {
    QuizCollectionData.removeAt(index);
    prefs.setStringList('ff_QuizCollectionData',
        _QuizCollectionData.map((x) => x.serialize()).toList());
  }

  void updateQuizCollectionDataAtIndex(
    int index,
    QuizCollectionStruct Function(QuizCollectionStruct) updateFn,
  ) {
    QuizCollectionData[index] = updateFn(_QuizCollectionData[index]);
    prefs.setStringList('ff_QuizCollectionData',
        _QuizCollectionData.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInQuizCollectionData(
      int index, QuizCollectionStruct value) {
    QuizCollectionData.insert(index, value);
    prefs.setStringList('ff_QuizCollectionData',
        _QuizCollectionData.map((x) => x.serialize()).toList());
  }

  final _userDocQueryManager = FutureRequestManager<UsersRecord>();
  Future<UsersRecord> userDocQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UsersRecord> Function() requestFn,
  }) =>
      _userDocQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserDocQueryCache() => _userDocQueryManager.clear();
  void clearUserDocQueryCacheKey(String? uniqueKey) =>
      _userDocQueryManager.clearRequest(uniqueKey);

  final _academicCalendarCacheManager =
      FutureRequestManager<List<ConstantsRecord>>();
  Future<List<ConstantsRecord>> academicCalendarCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<ConstantsRecord>> Function() requestFn,
  }) =>
      _academicCalendarCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAcademicCalendarCacheCache() =>
      _academicCalendarCacheManager.clear();
  void clearAcademicCalendarCacheCacheKey(String? uniqueKey) =>
      _academicCalendarCacheManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
