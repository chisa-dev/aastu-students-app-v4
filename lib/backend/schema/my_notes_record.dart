import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyNotesRecord extends FirestoreRecord {
  MyNotesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "start_time" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "end_time" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "remind_me" field.
  bool? _remindMe;
  bool get remindMe => _remindMe ?? false;
  bool hasRemindMe() => _remindMe != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _note = snapshotData['note'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['start_time'] as DateTime?;
    _endTime = snapshotData['end_time'] as DateTime?;
    _remindMe = snapshotData['remind_me'] as bool?;
    _category = snapshotData['category'] as String?;
    _completed = snapshotData['completed'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('MyNotes')
          : FirebaseFirestore.instance.collectionGroup('MyNotes');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('MyNotes').doc(id);

  static Stream<MyNotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MyNotesRecord.fromSnapshot(s));

  static Future<MyNotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MyNotesRecord.fromSnapshot(s));

  static MyNotesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MyNotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MyNotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MyNotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MyNotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MyNotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMyNotesRecordData({
  String? uid,
  String? note,
  DateTime? date,
  DateTime? startTime,
  DateTime? endTime,
  bool? remindMe,
  String? category,
  bool? completed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'note': note,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'remind_me': remindMe,
      'category': category,
      'completed': completed,
    }.withoutNulls,
  );

  return firestoreData;
}

class MyNotesRecordDocumentEquality implements Equality<MyNotesRecord> {
  const MyNotesRecordDocumentEquality();

  @override
  bool equals(MyNotesRecord? e1, MyNotesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.note == e2?.note &&
        e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.remindMe == e2?.remindMe &&
        e1?.category == e2?.category &&
        e1?.completed == e2?.completed;
  }

  @override
  int hash(MyNotesRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.note,
        e?.date,
        e?.startTime,
        e?.endTime,
        e?.remindMe,
        e?.category,
        e?.completed
      ]);

  @override
  bool isValidKey(Object? o) => o is MyNotesRecord;
}
