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

Future<StudentResultStruct> calculateGrade(
    List<MyGPAStruct> studentGrade) async {
  // Add your function code here!
  // Grade to GPA points mapping
  // Grade to GPA points mapping
  Map<String, double> gradePoints = {
    'A': 4.0,
    'A+': 4.0,
    'A-': 3.75,
    'B': 3.0,
    'B+': 3.5,
    'B-': 2.75,
    'C': 2.0,
    'C+': 2.5,
    'C-': 1.75,
    'D': 1.0,
    'F': 0.0,
  };

  double totalGradePoints = 0.0;
  int totalCreditHour = 0;
  int totalCourses = studentGrade.length;

  for (var course in studentGrade) {
    if (gradePoints.containsKey(course.grade)) {
      double gradePoint = gradePoints[course.grade]!;
      totalGradePoints += gradePoint * course.creditHour;
      totalCreditHour += course.creditHour;
    }
  }

  // Calculate GPA
  double gpa = totalCreditHour > 0 ? totalGradePoints / totalCreditHour : 0.0;

  return StudentResultStruct(
    gpa: gpa.toStringAsFixed(2), // Format GPA to 2 decimal places
    totalCreditHour: totalCreditHour,
    totalCourses: totalCourses,
  );
}
