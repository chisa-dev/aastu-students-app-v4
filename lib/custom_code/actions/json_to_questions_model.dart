// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<QuestionModelStruct>> jsonToQuestionsModel(dynamic jsonData) async {
  // Add your function code here!
  List<QuestionModelStruct> questions = [];

  if (jsonData is Map<String, dynamic> && jsonData['questions'] is List) {
    // add title on questions

    for (var questionData in jsonData['questions']) {
      if (questionData is Map<String, dynamic>) {
        questions.add(QuestionModelStruct(
          query: questionData['query'] ?? '',
          choices: List<String>.from(questionData['choices'] ?? []),
          answer: questionData['answer'] ?? 0,
          explanation: questionData['explanation'] ?? '',
        ));
      }
    }
  }

  return questions;
}
