import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/features/components/choice_list_item/choice_list_item_widget.dart';
import '/pages/features/components/quiz_generator/quiz_generator_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'quiz_practice_room_model.dart';
export 'quiz_practice_room_model.dart';

class QuizPracticeRoomWidget extends StatefulWidget {
  const QuizPracticeRoomWidget({
    super.key,
    required this.id,
    required this.questionName,
  });

  final int? id;
  final String? questionName;

  @override
  State<QuizPracticeRoomWidget> createState() => _QuizPracticeRoomWidgetState();
}

class _QuizPracticeRoomWidgetState extends State<QuizPracticeRoomWidget>
    with TickerProviderStateMixin {
  late QuizPracticeRoomModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizPracticeRoomModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.blockScreenRecordingAndScreenshots();
      _model.questionsListData = FFAppState()
          .QuizCollectionData
          .where((e) => e.id == widget!.id)
          .toList()
          .firstOrNull!
          .questionsList
          .toList()
          .cast<QuestionModelStruct>();
      safeSetState(() {});
    });

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: Visibility(
          visible: MediaQuery.sizeOf(context).width <= 990.0,
          child: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Color(0x00000000),
                barrierColor: FlutterFlowTheme.of(context).accent4,
                context: context,
                builder: (context) {
                  return WebViewAware(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: QuizGeneratorWidget(),
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: Icon(
              Icons.generating_tokens_outlined,
              color: Colors.white,
              size: 24.0,
            ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 18.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.safePop();
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 34.0,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Practice Room ',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  14.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.questionName,
                                  'Last Generated Question',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Figtree',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().removeFromQuizCollectionData(
                                    FFAppState()
                                        .QuizCollectionData
                                        .where((e) => e.id == widget!.id)
                                        .toList()
                                        .firstOrNull!);
                                safeSetState(() {});

                                context.pushNamed('QuizPage');
                              },
                              child: Icon(
                                Icons.delete,
                                color: FlutterFlowTheme.of(context).error,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final allQuestions =
                                _model.questionsListData.toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(allQuestions.length,
                                  (allQuestionsIndex) {
                                final allQuestionsItem =
                                    allQuestions[allQuestionsIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 2.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  allQuestionsItem.query,
                                                  'NA',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Figtree',
                                                          fontSize: 17.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final currentQuestionChoice =
                                                allQuestionsItem.choices
                                                    .toList()
                                                    .take(4)
                                                    .toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  currentQuestionChoice.length,
                                                  (currentQuestionChoiceIndex) {
                                                final currentQuestionChoiceItem =
                                                    currentQuestionChoice[
                                                        currentQuestionChoiceIndex];
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (currentQuestionChoiceIndex ==
                                                        allQuestionsItem
                                                            .answer) {
                                                      _model.addToCorrectChoice(
                                                          CorrectChoiceModelStruct(
                                                        questionIndex:
                                                            allQuestionsIndex,
                                                        answerIndex:
                                                            currentQuestionChoiceIndex,
                                                      ));
                                                      _model.clickedQIndex =
                                                          allQuestionsIndex;
                                                      _model.clieckedAIndex =
                                                          currentQuestionChoiceIndex;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.removeFromCorrectChoice(
                                                          CorrectChoiceModelStruct(
                                                        questionIndex:
                                                            allQuestionsIndex,
                                                        answerIndex:
                                                            currentQuestionChoiceIndex,
                                                      ));
                                                      _model.clickedQIndex =
                                                          allQuestionsIndex;
                                                      _model.clieckedAIndex =
                                                          currentQuestionChoiceIndex;
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: ChoiceListItemWidget(
                                                    key: Key(
                                                        'Key43a_${currentQuestionChoiceIndex}_of_${currentQuestionChoice.length}'),
                                                    bgColor:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if (_model.correctChoice
                                                                .contains(
                                                                    CorrectChoiceModelStruct(
                                                              questionIndex:
                                                                  allQuestionsIndex,
                                                              answerIndex:
                                                                  currentQuestionChoiceIndex,
                                                            )) &&
                                                            (_model.clickedQIndex ==
                                                                allQuestionsIndex) &&
                                                            (_model.clieckedAIndex ==
                                                                allQuestionsItem
                                                                    .answer)) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .success;
                                                        } else if (!_model
                                                                .correctChoice
                                                                .contains(
                                                                    CorrectChoiceModelStruct(
                                                              questionIndex:
                                                                  allQuestionsIndex,
                                                              answerIndex:
                                                                  currentQuestionChoiceIndex,
                                                            )) &&
                                                            (_model.clickedQIndex ==
                                                                allQuestionsIndex) &&
                                                            (_model.clieckedAIndex ==
                                                                currentQuestionChoiceIndex)) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .error;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    choice: allQuestionsItem
                                                        .choices
                                                        .elementAtOrNull(
                                                            currentQuestionChoiceIndex)!,
                                                  ),
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                        if (_model.correctChoice.contains(
                                                CorrectChoiceModelStruct(
                                              questionIndex: allQuestionsIndex,
                                              answerIndex:
                                                  allQuestionsItem.answer,
                                            )) &&
                                            (_model.clickedQIndex ==
                                                allQuestionsIndex) &&
                                            (_model.clieckedAIndex ==
                                                allQuestionsItem.answer))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 8.0, 0.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                color: Color(0x2B269689),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    allQuestionsItem
                                                        .explanation,
                                                    'NA',
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
