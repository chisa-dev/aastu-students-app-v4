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

Future<List<int>> countNotesItems(List<DocumentReference> myNotes) async {
  // Add your function code here!
  // Initialize counts for each category: [assignment, test, other]
  int assignmentCount = 0;
  int testCount = 0;
  int otherCount = 0;

  for (var noteRef in myNotes) {
    // Fetch the note document data
    final noteSnapshot = await noteRef.get();

    if (noteSnapshot.exists) {
      final noteData = noteSnapshot.data() as Map<String, dynamic>;

      // Increment the appropriate counter based on the category
      switch (noteData['category']) {
        case 'assignment':
          assignmentCount++;
          break;
        case 'test':
          testCount++;
          break;
        case 'other':
          otherCount++;
          break;
      }
    }
  }

  // Return the counts in the specified order [assignment, test, other]
  return [assignmentCount, testCount, otherCount];
}
