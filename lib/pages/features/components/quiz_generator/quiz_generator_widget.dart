import '/backend/schema/structs/index.dart';
import '/backend/gemini/gemini_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'quiz_generator_model.dart';
export 'quiz_generator_model.dart';

/// List of common AASTU courses for searchable dropdown.
const List<String> _aastuCourses = [
  'Data Structures and Algorithms',
  'Object Oriented Programming',
  'Programming I: Fundamentals (C++)',
  'Programming II: Advanced (C++)',
  'Introduction to Computing',
  'Computer Organization and Architecture',
  'Operating Systems',
  'Database Systems',
  'Software Engineering',
  'Web Development',
  'Mobile Application Development',
  'Computer Networks',
  'Artificial Intelligence',
  'Machine Learning',
  'Digital Logic Design',
  'Discrete Mathematics',
  'Calculus I',
  'Calculus II',
  'Linear Algebra',
  'Probability and Statistics',
  'Numerical Analysis',
  'Engineering Mechanics',
  'Engineering Drawing',
  'Physics I',
  'Physics II',
  'Chemistry',
  'Logic and Critical Thinking',
  'Anthropology',
  'Civics and Ethics',
  'Communicative English',
  'Entrepreneurship',
  'Technical Writing',
  'Signals and Systems',
  'Control Systems',
  'Compiler Design',
  'Theory of Computation',
  'Information Security',
  'Cloud Computing',
  'Internet of Things (IoT)',
  'Embedded Systems',
  'Software Project Management',
  'Human Computer Interaction',
  'Image Processing',
  'Natural Language Processing',
];

class QuizGeneratorWidget extends StatefulWidget {
  const QuizGeneratorWidget({
    super.key,
    this.courseName,
    this.content,
  });

  final String? courseName;
  final String? content;

  @override
  State<QuizGeneratorWidget> createState() => _QuizGeneratorWidgetState();
}

class _QuizGeneratorWidgetState extends State<QuizGeneratorWidget> {
  late QuizGeneratorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizGeneratorModel());

    _model.courseSearchTextController ??=
        TextEditingController(text: widget.courseName ?? '');
    _model.courseSearchFocusNode ??= FocusNode();

    _model.courseContentTextController ??=
        TextEditingController(text: widget.content ?? '');
    _model.courseContentFocusNode ??= FocusNode();

    _model.numberofQuestionsTextController ??=
        TextEditingController(text: '10');
    _model.numberofQuestionsFocusNode ??= FocusNode();

    if (widget.courseName != null && widget.courseName!.isNotEmpty) {
      _model.selectedCourse = widget.courseName;
      _loadSubtopics(widget.courseName!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _loadSubtopics(String courseName) async {
    safeSetState(() {
      _model.isLoadingSubtopics = true;
      _model.subtopics = [];
      _model.selectedSubtopics = [];
    });

    final subtopics = await GeminiService.instance.suggestSubtopics(courseName);

    safeSetState(() {
      _model.subtopics = subtopics;
      _model.isLoadingSubtopics = false;
    });
  }

  Future<void> _generateQuiz() async {
    final courseName = _model.selectedCourse ??
        _model.courseSearchTextController!.text.trim();
    final content = _model.courseContentTextController!.text.trim();
    final numQuestions =
        int.tryParse(_model.numberofQuestionsTextController!.text.trim()) ?? 10;

    if (courseName.isEmpty) {
      safeSetState(() {
        _model.errorMessage = 'Please select or enter a course name.';
      });
      return;
    }

    safeSetState(() {
      _model.isGenerating = true;
      _model.errorMessage = null;
    });

    try {
      final questions = await GeminiService.instance.generateQuiz(
        courseName: courseName,
        content: content,
        numberOfQuestions: numQuestions,
        selectedSubtopics: _model.selectedSubtopics.isNotEmpty
            ? _model.selectedSubtopics
            : null,
      );

      if (questions.isEmpty) {
        safeSetState(() {
          _model.isGenerating = false;
          _model.errorMessage =
              'No questions were generated. Please try again.';
        });
        return;
      }

      _model.generatedID = functions.generateIDforQuizCollection();
      FFAppState().addToQuizCollectionData(QuizCollectionStruct(
        id: _model.generatedID,
        title: courseName,
        questionsList: questions,
      ));

      if (mounted) {
        context.pushNamed(
          'QuizPracticeRoom',
          queryParameters: {
            'id': serializeParam(_model.generatedID, ParamType.int),
            'questionName': serializeParam(courseName, ParamType.String),
          }.withoutNulls,
        );
      }
    } catch (e) {
      safeSetState(() {
        _model.errorMessage = 'Generation failed: ${e.toString()}';
      });
    } finally {
      safeSetState(() {
        _model.isGenerating = false;
      });
    }
  }

  List<String> _getFilteredCourses(String query) {
    if (query.isEmpty) return _aastuCourses;
    return _aastuCourses
        .where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 18, 16, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.safePop(),
                    child: Icon(
                      Icons.chevron_left,
                      color: theme.primaryText,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Generate Quiz',
                    style: theme.bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      fontSize: 22,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: false,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome,
                            size: 14, color: theme.primary),
                        const SizedBox(width: 4),
                        Text(
                          'Gemini AI',
                          style: theme.bodySmall.override(
                            fontFamily: 'Figtree',
                            color: theme.primary,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step 1: Course Selection
                    _buildSectionHeader(
                        theme, '1', 'Select Course', Icons.school_outlined),
                    const SizedBox(height: 12),
                    _buildCourseSearchField(theme),
                    const SizedBox(height: 24),

                    // Step 2: Subtopics
                    _buildSectionHeader(theme, '2', 'Choose Subtopics',
                        Icons.topic_outlined),
                    const SizedBox(height: 4),
                    Text(
                      'AI will suggest subtopics based on your course selection',
                      style: theme.bodySmall.override(
                        fontFamily: 'Figtree',
                        color: theme.secondaryText,
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSubtopicsSection(theme),
                    const SizedBox(height: 24),

                    // Step 3: Content
                    _buildSectionHeader(theme, '3', 'Add Content (Optional)',
                        Icons.description_outlined),
                    const SizedBox(height: 4),
                    Text(
                      'Paste your notes or lecture content for more targeted questions',
                      style: theme.bodySmall.override(
                        fontFamily: 'Figtree',
                        color: theme.secondaryText,
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildContentField(theme),
                    const SizedBox(height: 24),

                    // Step 4: Number of Questions
                    _buildSectionHeader(theme, '4', 'Number of Questions',
                        Icons.format_list_numbered),
                    const SizedBox(height: 12),
                    _buildNumberOfQuestionsField(theme),
                    const SizedBox(height: 32),

                    // Error message
                    if (_model.errorMessage != null)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: theme.error.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: theme.error, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _model.errorMessage!,
                                style: theme.bodySmall.override(
                                  fontFamily: 'Figtree',
                                  color: theme.error,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Generate Button
                    FFButtonWidget(
                      onPressed: _model.isGenerating ? null : _generateQuiz,
                      text: _model.isGenerating
                          ? 'Generating...'
                          : 'Generate Quiz',
                      icon: _model.isGenerating
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Icon(Icons.auto_awesome, size: 20),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 52,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 0, 16, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0, 0, 8, 0),
                        color: theme.primary,
                        textStyle: theme.titleSmall.override(
                          fontFamily: 'Figtree',
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 0,
                        borderRadius: BorderRadius.circular(14),
                        disabledColor: theme.primary.withOpacity(0.5),
                        disabledTextColor: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      FlutterFlowTheme theme, String step, String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              step,
              style: theme.bodySmall.override(
                fontFamily: 'Figtree',
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: theme.primaryText, size: 20),
        const SizedBox(width: 6),
        Text(
          title,
          style: theme.titleSmall.override(
            fontFamily: 'Figtree',
            fontSize: 16,
            letterSpacing: 0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseSearchField(FlutterFlowTheme theme) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _getFilteredCourses(textEditingValue.text);
      },
      onSelected: (String selection) {
        safeSetState(() {
          _model.selectedCourse = selection;
          _model.courseSearchTextController?.text = selection;
        });
        _loadSubtopics(selection);
      },
      fieldViewBuilder:
          (context, textController, focusNode, onFieldSubmitted) {
        // Sync the autocomplete's controller with our model
        _model.courseSearchTextController = textController;
        _model.courseSearchFocusNode = focusNode;

        if (widget.courseName != null &&
            widget.courseName!.isNotEmpty &&
            textController.text.isEmpty) {
          textController.text = widget.courseName!;
        }

        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          onFieldSubmitted: (_) => onFieldSubmitted(),
          onChanged: (value) {
            if (_model.selectedCourse != value) {
              safeSetState(() {
                _model.selectedCourse = null;
                _model.subtopics = [];
                _model.selectedSubtopics = [];
              });
            }
          },
          decoration: InputDecoration(
            labelText: 'Search Course',
            labelStyle: theme.labelMedium.override(
              fontFamily: 'Figtree',
              fontSize: 15,
              letterSpacing: 0,
            ),
            hintText: 'Type to search (e.g. Data Structures)',
            hintStyle: theme.bodySmall.override(
              fontFamily: 'Figtree',
              fontSize: 14,
              letterSpacing: 0,
            ),
            prefixIcon:
                Icon(Icons.search, color: theme.secondaryText, size: 22),
            suffixIcon: textController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      textController.clear();
                      safeSetState(() {
                        _model.selectedCourse = null;
                        _model.subtopics = [];
                        _model.selectedSubtopics = [];
                      });
                    },
                    child: Icon(Icons.clear,
                        color: theme.secondaryText, size: 20),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.alternate, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.error, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.error, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.secondaryBackground,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'Figtree',
            fontSize: 15,
            letterSpacing: 0,
          ),
          cursorColor: theme.primary,
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 250),
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.alternate),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(Icons.school_outlined,
                              color: theme.primary, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              option,
                              style: theme.bodyMedium.override(
                                fontFamily: 'Figtree',
                                fontSize: 14,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtopicsSection(FlutterFlowTheme theme) {
    if (_model.selectedCourse == null && _model.subtopics.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.alternate),
        ),
        child: Column(
          children: [
            Icon(Icons.lightbulb_outline,
                color: theme.secondaryText, size: 32),
            const SizedBox(height: 8),
            Text(
              'Select a course first to get AI-suggested subtopics',
              textAlign: TextAlign.center,
              style: theme.bodySmall.override(
                fontFamily: 'Figtree',
                color: theme.secondaryText,
                fontSize: 13,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      );
    }

    if (_model.isLoadingSubtopics) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.alternate),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'AI is suggesting subtopics...',
              style: theme.bodySmall.override(
                fontFamily: 'Figtree',
                color: theme.secondaryText,
                fontSize: 13,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      );
    }

    if (_model.subtopics.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.alternate),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: theme.secondaryText, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'No subtopics found. You can still generate a quiz with the content below.',
                style: theme.bodySmall.override(
                  fontFamily: 'Figtree',
                  color: theme.secondaryText,
                  fontSize: 13,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select all / Deselect all
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_model.selectedSubtopics.length} of ${_model.subtopics.length} selected',
              style: theme.bodySmall.override(
                fontFamily: 'Figtree',
                color: theme.secondaryText,
                fontSize: 12,
                letterSpacing: 0,
              ),
            ),
            InkWell(
              onTap: () {
                safeSetState(() {
                  if (_model.selectedSubtopics.length ==
                      _model.subtopics.length) {
                    _model.selectedSubtopics = [];
                  } else {
                    _model.selectedSubtopics = List.from(_model.subtopics);
                  }
                });
              },
              child: Text(
                _model.selectedSubtopics.length == _model.subtopics.length
                    ? 'Deselect All'
                    : 'Select All',
                style: theme.bodySmall.override(
                  fontFamily: 'Figtree',
                  color: theme.primary,
                  fontSize: 13,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _model.subtopics.map((subtopic) {
            final isSelected = _model.selectedSubtopics.contains(subtopic);
            return InkWell(
              onTap: () {
                safeSetState(() {
                  if (isSelected) {
                    _model.selectedSubtopics.remove(subtopic);
                  } else {
                    _model.selectedSubtopics.add(subtopic);
                  }
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primary.withOpacity(0.15)
                      : theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? theme.primary
                        : theme.alternate,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(Icons.check_circle,
                            size: 16, color: theme.primary),
                      ),
                    Flexible(
                      child: Text(
                        subtopic,
                        style: theme.bodySmall.override(
                          fontFamily: 'Figtree',
                          color: isSelected
                              ? theme.primary
                              : theme.primaryText,
                          fontSize: 13,
                          letterSpacing: 0,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContentField(FlutterFlowTheme theme) {
    return Stack(
      children: [
        TextFormField(
          controller: _model.courseContentTextController,
          focusNode: _model.courseContentFocusNode,
          decoration: InputDecoration(
            labelText: 'Content',
            labelStyle: theme.labelMedium.override(
              fontFamily: 'Figtree',
              fontSize: 15,
              letterSpacing: 0,
            ),
            alignLabelWithHint: true,
            hintText: 'Paste your lecture notes, textbook content, etc.',
            hintStyle: theme.bodySmall.override(
              fontFamily: 'Figtree',
              fontSize: 14,
              letterSpacing: 0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.alternate, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primary, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.error, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.error, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.secondaryBackground,
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(20, 16, 48, 16),
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'Figtree',
            fontSize: 15,
            letterSpacing: 0,
          ),
          maxLines: 8,
          minLines: 4,
          maxLength: 3000,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          keyboardType: TextInputType.multiline,
          cursorColor: theme.primary,
          validator:
              _model.courseContentTextControllerValidator?.asValidator(context),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () async {
              final pasted = await actions.pasteFromClipboard();
              if (pasted != null && pasted.isNotEmpty) {
                safeSetState(() {
                  _model.courseContentTextController?.text = pasted;
                });
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.content_paste_rounded,
                color: theme.secondaryText,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberOfQuestionsField(FlutterFlowTheme theme) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _model.numberofQuestionsTextController,
            focusNode: _model.numberofQuestionsFocusNode,
            decoration: InputDecoration(
              labelText: 'Questions',
              labelStyle: theme.labelMedium.override(
                fontFamily: 'Figtree',
                fontSize: 15,
                letterSpacing: 0,
              ),
              hintText: 'e.g. 10',
              hintStyle: theme.bodySmall.override(
                fontFamily: 'Figtree',
                fontSize: 14,
                letterSpacing: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.alternate, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primary, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.error, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.error, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: theme.secondaryBackground,
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'Figtree',
              fontSize: 15,
              letterSpacing: 0,
            ),
            keyboardType: TextInputType.number,
            cursorColor: theme.primary,
            validator: _model.numberofQuestionsTextControllerValidator
                ?.asValidator(context),
          ),
        ),
        const SizedBox(width: 12),
        // Quick select chips
        ...[5, 10, 20].map((n) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  safeSetState(() {
                    _model.numberofQuestionsTextController?.text = '$n';
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: _model.numberofQuestionsTextController?.text == '$n'
                        ? theme.primary.withOpacity(0.15)
                        : theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          _model.numberofQuestionsTextController?.text == '$n'
                              ? theme.primary
                              : theme.alternate,
                    ),
                  ),
                  child: Text(
                    '$n',
                    style: theme.bodySmall.override(
                      fontFamily: 'Figtree',
                      color:
                          _model.numberofQuestionsTextController?.text == '$n'
                              ? theme.primary
                              : theme.primaryText,
                      fontSize: 13,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
