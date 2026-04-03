import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '/backend/schema/structs/index.dart';

class GeminiService {
  static GeminiService? _instance;
  static GeminiService get instance => _instance ??= GeminiService._();
  GeminiService._();

  String? _cachedApiKey;
  GenerativeModel? _model;

  /// Fetches the Gemini API key from Firestore app_config collection.
  /// Only admins can write to this collection, but authenticated users can read.
  Future<String> _getApiKey() async {
    if (_cachedApiKey != null && _cachedApiKey!.isNotEmpty) {
      return _cachedApiKey!;
    }

    final doc = await FirebaseFirestore.instance
        .collection('app_config')
        .doc('gemini')
        .get();

    if (doc.exists && doc.data() != null) {
      _cachedApiKey = doc.data()!['api_key'] as String?;
    }

    if (_cachedApiKey == null || _cachedApiKey!.isEmpty) {
      throw Exception('Gemini API key not found in Firestore. Please configure it in admin panel.');
    }

    return _cachedApiKey!;
  }

  /// Clears cached API key so it will be re-fetched on next call.
  void clearCache() {
    _cachedApiKey = null;
    _model = null;
  }

  Future<GenerativeModel> _getModel() async {
    if (_model != null) return _model!;
    final apiKey = await _getApiKey();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.8,
        responseMimeType: 'application/json',
      ),
    );
    return _model!;
  }

  /// Suggests course subtopics based on the course name.
  Future<List<String>> suggestSubtopics(String courseName) async {
    try {
      final model = await _getModel();
      final prompt = '''
You are an academic course expert. Given the course name "$courseName", suggest 10-15 specific subtopics or chapters that are commonly taught in this course at a university level.

Return the output as a JSON object with the following structure:
{
  "subtopics": ["Subtopic 1", "Subtopic 2", "Subtopic 3", ...]
}

Provide only the JSON object, no additional text.
''';

      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text == null || text.isEmpty) return [];

      final json = jsonDecode(text);
      if (json is Map<String, dynamic> && json['subtopics'] is List) {
        return List<String>.from(json['subtopics']);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Generates GPA insights and improvement tips for a student.
  Future<String> generateGpaInsights({
    required String gpa,
    required int totalCourses,
    required int totalCreditHour,
    required List<Map<String, String>> courses,
  }) async {
    try {
      final model = await _getModel();
      final courseList = courses.map((c) => '${c['course']} (${c['creditHour']} CrHr) → ${c['grade']}').join('\n');
      final prompt = '''
You are an academic advisor for AASTU (Addis Ababa Science and Technology University) students. Analyze this student's semester GPA results and provide brief, actionable insights.

GPA: $gpa
Total Courses: $totalCourses
Total Credit Hours: $totalCreditHour
Courses:
$courseList

Return a JSON object:
{
  "summary": "One sentence summary of their performance",
  "status": "Excellent|Good|Average|Needs Improvement|Critical",
  "tips": ["Tip 1", "Tip 2", "Tip 3"],
  "target": "What GPA they should aim for next semester and one specific action"
}

Keep each tip short (max 15 words). Be encouraging but honest. Provide only the JSON object.
''';

      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text;
      if (text == null || text.isEmpty) return '';

      final json = jsonDecode(text);
      if (json is! Map<String, dynamic>) return '';

      final summary = json['summary'] as String? ?? '';
      final tips = (json['tips'] as List?)?.cast<String>() ?? [];
      final target = json['target'] as String? ?? '';

      final buffer = StringBuffer();
      buffer.writeln(summary);
      if (tips.isNotEmpty) {
        buffer.writeln('\nTips to improve:');
        for (final tip in tips) {
          buffer.writeln('• $tip');
        }
      }
      if (target.isNotEmpty) {
        buffer.writeln('\n$target');
      }
      return buffer.toString().trim();
    } catch (e) {
      return 'Unable to load insights. Please try again.';
    }
  }

  /// Generates quiz questions using Gemini AI.
  Future<List<QuestionModelStruct>> generateQuiz({
    required String courseName,
    required String content,
    required int numberOfQuestions,
    List<String>? selectedSubtopics,
  }) async {
    final model = await _getModel();

    final subtopicsPart = selectedSubtopics != null && selectedSubtopics.isNotEmpty
        ? 'Focus on these specific subtopics: ${selectedSubtopics.join(", ")}.'
        : '';

    final prompt = '''
Create $numberOfQuestions multiple-choice questions based on the course topic '$courseName'. $subtopicsPart

${content.isNotEmpty ? 'Use the following content as reference material: /start $content /end' : 'Generate questions based on standard university-level curriculum for this course.'}

Return the output as a JSON object with the following structure:
{
  "questions": [
    {
      "query": "The question text here",
      "choices": ["Option1", "Option2", "Option3", "Option4"],
      "answer": 0,
      "explanation": "Brief explanation for the correct answer here."
    }
  ]
}

Rules:
- The "choices" array must contain exactly 4 options as plain strings with no prefixes (no A, B, C, D or 1, 2, 3, 4).
- The "answer" field must be the 0-indexed position of the correct answer.
- Each question must have a clear, unambiguous correct answer.
- Provide only the JSON object, no additional text.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final text = response.text;

    if (text == null || text.isEmpty) {
      throw Exception('Empty response from Gemini');
    }

    final json = jsonDecode(text);
    if (json is! Map<String, dynamic> || json['questions'] is! List) {
      throw Exception('Invalid response format from Gemini');
    }

    final questions = <QuestionModelStruct>[];
    for (var q in json['questions']) {
      if (q is Map<String, dynamic>) {
        questions.add(QuestionModelStruct(
          query: q['query'] ?? '',
          choices: List<String>.from(q['choices'] ?? []),
          answer: q['answer'] ?? 0,
          explanation: q['explanation'] ?? '',
        ));
      }
    }
    return questions;
  }
}
