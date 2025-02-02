import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

int likes(UserPostsRecord? post) {
  return post!.likes!.length;
}

bool hasUploadedMedia(String? mediaPath) {
  return mediaPath != null && mediaPath.isNotEmpty;
}

int stringToInteger(String str) {
  return int.parse(str);
}

double stringToDouble(String str) {
  return double.parse(str);
}

double calculateCGPAFunction(List<MyGradeRecord> semesterGrades) {
  double totalGradePoints = 0.0;
  int totalCreditHour = 0;

  for (var semester in semesterGrades) {
    double semesterGPA = double.parse(semester.gpa);
    int semesterCreditHour = semester.totalCreditHour;

    totalGradePoints += semesterGPA * semesterCreditHour;
    totalCreditHour += semesterCreditHour;
  }

  // Calculate CGPA
  double cgpa = totalCreditHour > 0 ? totalGradePoints / totalCreditHour : 0.0;
  return double.parse(
      cgpa.toStringAsFixed(2)); // Format CGPA to 2 decimal place
}

String firstNameCropper(String name) {
  String firstName = name.split(' ')[0];
  return '$firstName,';
}

String promptGenerator(
  String numberOfQuestions,
  String courseName,
  String content,
) {
  return """
  Create $numberOfQuestions multiple-choice questions based on the course topic '$courseName', focusing specifically on the details provided between /start and /end: /start $content /end. 

  Please return the output as a JSON object with the following structure:
  {
    "questions": [
      {
        "query": "The question text here",
        "choices": ["Option1", "Option2", "Option3", "Option4"],
        "answer": 0, // the 0-indexed position of the correct answer from the choices array
        "explanation": "Brief explanation for the correct answer here."
      },
      ...
    ]
  }

  The "choices" array should contain only the answer options as strings, with no prefixes such as A, B, C, or numbers (1, 2, 3). Exclude any introductory or concluding text; provide only the JSON object.
  """;
}

dynamic stringToJson(dynamic response) {
  try {
    // Ensure the input is converted to a string if not already
    final String responseString =
        response is String ? response : jsonEncode(response);

    // Parse the input response as a JSON object
    final Map<String, dynamic> jsonResponse = jsonDecode(responseString);

    // Navigate to the "content" field inside the response
    final String content = jsonResponse['choices'][0]['message']['content'];

    // Remove escape characters and clean up the string
    final String cleanedContent = content
        .replaceAll('\\n', '\n') // Replace escaped newlines
        .replaceAll('\\"', '"') // Replace escaped double quotes
        .replaceAll('\\\\', '\\') // Replace escaped backslashes
        .trim();

    // Parse the cleaned string into a proper JSON object
    final dynamic parsedJson = jsonDecode(cleanedContent);

    // Return the parsed JSON object
    return parsedJson;
  } catch (e) {
    // Return an error message if parsing fails
    return {'error': 'Failed to parse JSON', 'details': e.toString()};
  }
}

bool isJsonString(String response) {
  return true;
}

String capitalizeFirstLetter(String str) {
  if (str.isEmpty) return str;
  return str[0].toUpperCase() + str.substring(1);
}

String dateToHumanReadable(DateTime date) {
  final dayOfWeek =
      ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  final month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ][date.month - 1];
  return '$dayOfWeek, $month ${date.day}';
}

String timeToHumanReadableTime(DateTime time) {
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}

LatLng combineLatAndLng() {
  return LatLng(8.88553639408486, 38.80966756395657);
}

String generateActivationCode(String uid) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  math.Random random = math.Random();

  // Generate a 6 character  activation code
  String activationCode =
      List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();

  return activationCode;
}

String mergeTwoIDs(
  String uid1,
  String uid2,
) {
  String firstPart =
      uid1.length >= 9 ? uid1.substring(0, 9) : uid1.padRight(9, '0');
  String secondPart =
      uid2.length >= 9 ? uid2.substring(0, 9) : uid2.padRight(9, '0');

  return firstPart + secondPart;
}

int stringToInt(String str) {
  return int.parse(str);
}

bool checkAAASTUEmail(String str) {
  final emailRegex = RegExp(r"^[\w\.-]+@aastustudent\.edu\.et$");
  return emailRegex.hasMatch(str);
}

String trimBookTitle(String title) {
  if (title.length <= 13) {
    return title; // No need to trim if the title is already within the limit
  }
  return title.substring(0, 13) + "...";
}

DateTime expiredDateMaker(DateTime postedDate) {
  return postedDate.add(Duration(hours: 24));
}

int generateIDforQuizCollection() {
  int min = 100;
  int max = 1000;

  // Seed random with current milliseconds
  math.Random random = math.Random(DateTime.now().millisecondsSinceEpoch);

  int randomId = min + random.nextInt(max - min);

  return randomId;
}
