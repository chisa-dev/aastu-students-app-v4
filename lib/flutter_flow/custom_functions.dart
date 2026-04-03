import 'dart:math' as math;

import 'lat_lng.dart';
import '/backend/backend.dart';

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

// OpenAI prompt/parsing functions removed - now using GeminiService directly

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
