import 'dart:async';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/services/in_app_notification_service.dart';
import '/components/create_modal/create_modal_widget.dart';
import '/components/empty_list_1/empty_list1_widget.dart';
import '/components/post_loading_effect/post_loading_effect_widget.dart';
import '/components/web_components/post_modal_view/post_modal_view_widget.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/components/web_components/story_modal_view/story_modal_view_widget.dart';
import 'package:shimmer/shimmer.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '/flutter_flow/blurhash_image.dart';
import 'main_feed_model.dart';
export 'main_feed_model.dart';

class MainFeedWidget extends StatefulWidget {
  const MainFeedWidget({super.key});

  @override
  State<MainFeedWidget> createState() => _MainFeedWidgetState();
}

class _MainFeedWidgetState extends State<MainFeedWidget>
    with TickerProviderStateMixin {
  late MainFeedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasIconTriggered = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainFeedModel());

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.2, 0.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'main_Feed',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          floatingActionButton: Visibility(
            visible: MediaQuery.sizeOf(context).width <= 990.0,
            child: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Color(0x00000000),
                    barrierColor: FlutterFlowTheme.of(context).accent4,
                    context: context,
                    builder: (context) {
                      return WebViewAware(
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: CreateModalWidget(),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                backgroundColor: FlutterFlowTheme.of(context).primary,
                elevation: 8.0,
                child: Icon(
                  Icons.create_rounded,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
          ),
          appBar: responsiveVisibility(
            context: context,
            tabletLandscape: false,
            desktop: false,
          )
              ? AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (false)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/my_logo.png',
                            width: 37.0,
                            height: 37.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Text(
                        'Feed',
                        style:
                            FlutterFlowTheme.of(context).headlineLarge.override(
                                  fontFamily: 'Outfit',
                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('Search');
                              },
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 18.0, 0.0),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  size: 27.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('main_Chat');
                                },
                                child: StreamBuilder<List<ChatsRecord>>(
                                  stream: queryChatsRecord(
                                    queryBuilder: (chatsRecord) => chatsRecord
                                        .where('users',
                                            arrayContains:
                                                currentUserReference)
                                        .orderBy('last_message_time',
                                            descending: true),
                                  ),
                                  builder: (context, snapshot) {
                                    int unreadCount = 0;
                                    if (snapshot.hasData) {
                                      unreadCount = snapshot.data!
                                          .where((chat) => !chat
                                              .lastMessageSeenBy
                                              .contains(currentUserReference))
                                          .length;
                                    }
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.facebookMessenger,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 27.0,
                                        ),
                                        if (unreadCount > 0)
                                          Positioned(
                                            right: -6,
                                            top: -4,
                                            child: Container(
                                              padding: EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 18.0,
                                                minHeight: 18.0,
                                              ),
                                              child: Text(
                                                unreadCount > 9
                                                    ? '9+'
                                                    : '$unreadCount',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color: Colors.white,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 0.0,
                )
              : null,
          body: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.sideNavModel,
                updateCallback: () => safeSetState(() {}),
                child: SideNavWidget(
                  selectedNav: 1,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 1070.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: RefreshIndicator(
                      color: FlutterFlowTheme.of(context).primary,
                      onRefresh: () async {
                        safeSetState(() {});
                        // Small delay to show the refresh indicator
                        await Future.delayed(Duration(milliseconds: 500));
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 0.0),
                                    child: Icon(
                                      Icons.alternate_email_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 44.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 12.0, 0.0),
                                      child: Text(
                                        'AASTU STUDENTS',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Color(0x00000000),
                                          barrierColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent4,
                                          context: context,
                                          builder: (context) {
                                            return WebViewAware(
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: CreateModalWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: 'New Post',
                                      icon: Icon(
                                        Icons.mode_edit,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        height: 44.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Figtree',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 2.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      showLoadingIndicator: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          FutureBuilder<List<UserStoriesRecord>>(
                            future: queryUserStoriesRecordOnce(
                              queryBuilder: (userStoriesRecord) =>
                                  userStoriesRecord
                                      .where(
                                        'expiredDate',
                                        isGreaterThan: getCurrentTimestamp,
                                      )
                                      .orderBy('expiredDate',
                                          descending: true),
                              limit: 20,
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return SizedBox.shrink();
                              }
                              // Filter: show approved stories to all, pending only to owner
                              List<UserStoriesRecord>
                                  listViewUserStoriesRecordList =
                                  snapshot.data!.where((story) {
                                if (story.status == 'pending') {
                                  return story.user == currentUserReference;
                                }
                                return true; // approved or no status (legacy)
                              }).toList();
                              if (listViewUserStoriesRecordList.isEmpty) {
                                return SizedBox.shrink();
                              }

                              return Container(
                                height: 110.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.0,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      offset: Offset(0.0, 1.0),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 2.0, 0.0, 8.0),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        listViewUserStoriesRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewUserStoriesRecord =
                                          listViewUserStoriesRecordList[
                                              listViewIndex];
                                      return Builder(
                                        builder: (context) => Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 0.0),
                                          child: StreamBuilder<UsersRecord>(
                                            stream: UsersRecord.getDocument(
                                                listViewUserStoriesRecord
                                                    .user!),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor: Colors.grey[100]!,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Container(width: 73, height: 73, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                                                      SizedBox(height: 4),
                                                      Container(width: 48, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4))),
                                                    ],
                                                  ),
                                                );
                                              }

                                              final singleStoryUsersRecord =
                                                  snapshot.data!;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width >=
                                                      1270.0) {
                                                    await showDialog(
                                                      barrierColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child: WebViewAware(
                                                            child:
                                                                StoryModalViewWidget(
                                                              initialIndex:
                                                                  listViewIndex,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    context.pushNamed(
                                                      'storyDetails',
                                                      queryParameters: {
                                                        'initialStoryIndex':
                                                            serializeParam(
                                                          listViewIndex,
                                                          ParamType.int,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        kTransitionInfoKey:
                                                            TransitionInfo(
                                                          hasTransition: true,
                                                          transitionType:
                                                              PageTransitionType
                                                                  .bottomToTop,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  200),
                                                        ),
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 73.0,
                                                        height: 73.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent1,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: listViewUserStoriesRecord.status == 'pending'
                                                                ? Colors.orange
                                                                : FlutterFlowTheme.of(context).primary,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            child:
                                                                BlurHashNetworkImage(
                                                              imageUrl: singleStoryUsersRecord.photoUrl.isNotEmpty
                                                                  ? singleStoryUsersRecord.photoUrl
                                                                  : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-social-app-tx2kqp/assets/ecyxfirnulof/karsten-winegeart-BJaqPaH6AGQ-unsplash.jpg',
                                                              blurHash: singleStoryUsersRecord.photoBlurHash,
                                                              fit: BoxFit.cover,
                                                              shape: BoxShape.circle,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: AutoSizeText(
                                                        listViewUserStoriesRecord.status == 'pending'
                                                            ? 'Under review'
                                                            : valueOrDefault<String>(
                                                                singleStoryUsersRecord
                                                                    .userName,
                                                                'user_12',
                                                              ).maybeHandleOverflow(
                                                                maxChars: 8,
                                                                replacement: '…',
                                                              ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Figtree',
                                                                  color: listViewUserStoriesRecord.status == 'pending'
                                                                      ? Colors.orange
                                                                      : null,
                                                                  fontSize: listViewUserStoriesRecord.status == 'pending'
                                                                      ? 9.0
                                                                      : null,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 32.0),
                            child: StreamBuilder<List<UserPostsRecord>>(
                              stream: queryUserPostsRecord(
                                queryBuilder: (userPostsRecord) =>
                                    userPostsRecord.orderBy('timePosted',
                                        descending: true),
                                limit: 500,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 1.0,
                                      height: 1.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                // Filter: show approved posts to all, pending only to owner
                                List<UserPostsRecord>
                                    socialFeedUserPostsRecordList =
                                    snapshot.data!.where((post) {
                                  if (post.status == 'pending') {
                                    return post.postUser == currentUserReference;
                                  }
                                  return true; // approved or no status (legacy)
                                }).toList();
                                if (socialFeedUserPostsRecordList.isEmpty) {
                                  return Center(
                                    child: Container(
                                      width: 330.0,
                                      height: 330.0,
                                      child: EmptyList1Widget(),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: socialFeedUserPostsRecordList.length,
                                  addAutomaticKeepAlives: false,
                                  addRepaintBoundaries: true,
                                  itemBuilder: (context, socialFeedIndex) {
                                    final socialFeedUserPostsRecord =
                                        socialFeedUserPostsRecordList[
                                            socialFeedIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 0.0, 0.0),
                                      child: FutureBuilder<UsersRecord>(
                                        future: UsersRecord.getDocumentOnce(
                                            socialFeedUserPostsRecord
                                                .postUser!),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Container(
                                              width: double.infinity,
                                              child: PostLoadingEffectWidget(),
                                            );
                                          }

                                          final userPostUsersRecord =
                                              snapshot.data!;

                                          return Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              maxWidth: 670.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 0.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  offset: Offset(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: Builder(
                                              builder: (context) => InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width >=
                                                      1271.0) {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                          child: WebViewAware(
                                                            child:
                                                                PostModalViewWidget(
                                                              postRef:
                                                                  socialFeedUserPostsRecord,
                                                              userRef:
                                                                  userPostUsersRecord,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    context.pushNamed(
                                                      'postDetails_Page',
                                                      queryParameters: {
                                                        'userRecord':
                                                            serializeParam(
                                                          userPostUsersRecord,
                                                          ParamType.Document,
                                                        ),
                                                        'postReference':
                                                            serializeParam(
                                                          socialFeedUserPostsRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'userRecord':
                                                            userPostUsersRecord,
                                                        'postReference':
                                                            socialFeedUserPostsRecord,
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  1.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 60.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                'viewProfilePageOther',
                                                                queryParameters:
                                                                    {
                                                                  'userDetails':
                                                                      serializeParam(
                                                                    userPostUsersRecord,
                                                                    ParamType
                                                                        .Document,
                                                                  ),
                                                                  'showPage':
                                                                      serializeParam(
                                                                    false,
                                                                    ParamType
                                                                        .bool,
                                                                  ),
                                                                  'pageTitle':
                                                                      serializeParam(
                                                                    'Home',
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  'userDetails':
                                                                      userPostUsersRecord,
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 44.0,
                                                                  height: 44.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent1,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            2.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0),
                                                                      child: Image
                                                                          .network(
                                                                        userPostUsersRecord
                                                                            .photoUrl,
                                                                        width:
                                                                            40.0,
                                                                        height:
                                                                            40.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 40, color: Colors.grey),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              valueOrDefault<String>(
                                                                                userPostUsersRecord.displayName,
                                                                                'My Name',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'Figtree',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                            if (userPostUsersRecord.isVerified ==
                                                                                true)
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(3.0, 1.0, 0.0, 0.0),
                                                                                child: Icon(
                                                                                  Icons.verified_sharp,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              1.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              userPostUsersRecord.userName,
                                                                              '@noone',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'Figtree',
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (socialFeedUserPostsRecord.status == 'pending')
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
                                                        color: Colors.orange.withValues(alpha: 0.1),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.schedule, size: 14.0, color: Colors.orange),
                                                            SizedBox(width: 6.0),
                                                            Text(
                                                              'Under review',
                                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                fontFamily: 'Figtree',
                                                                color: Colors.orange,
                                                                fontWeight: FontWeight.w600,
                                                                letterSpacing: 0.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    FlutterFlowMediaDisplay(
                                                      path:
                                                          socialFeedUserPostsRecord
                                                              .postPhoto,
                                                      imageBuilder: (path) =>
                                                          BlurHashNetworkImage(
                                                        imageUrl: path,
                                                        blurHash: socialFeedUserPostsRecord.photoBlurHash,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        height: 270.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      videoPlayerBuilder: (path) =>
                                                          FlutterFlowVideoPlayer(
                                                        path: path,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        autoPlay: true,
                                                        looping: true,
                                                        showControls: false,
                                                        allowFullScreen: true,
                                                        allowPlaybackSpeedMenu:
                                                            false,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  4.0,
                                                                  8.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          41.0,
                                                                      height:
                                                                          41.0,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          if (!socialFeedUserPostsRecord
                                                                              .likes
                                                                              .contains(currentUserReference))
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.25),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await socialFeedUserPostsRecord.reference.update({
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'likes': FieldValue.arrayUnion([
                                                                                          currentUserReference
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                  if (socialFeedUserPostsRecord.postUser != null) {
                                                                                    unawaited(InAppNotificationService.sendLikeNotification(
                                                                                      postOwnerRef: socialFeedUserPostsRecord.postUser!,
                                                                                      postRef: socialFeedUserPostsRecord.reference,
                                                                                    ));
                                                                                  }
                                                                                  if (animationsMap['iconOnActionTriggerAnimation'] != null) {
                                                                                    safeSetState(() => hasIconTriggered = true);
                                                                                    SchedulerBinding.instance.addPostFrameCallback((_) async => await animationsMap['iconOnActionTriggerAnimation']!.controller.forward(from: 0.0));
                                                                                  }
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.favorite_border,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 25.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          if (socialFeedUserPostsRecord
                                                                              .likes
                                                                              .contains(currentUserReference))
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.25),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await socialFeedUserPostsRecord.reference.update({
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'likes': FieldValue.arrayRemove([
                                                                                          currentUserReference
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.favorite_rounded,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 25.0,
                                                                                ),
                                                                              ).animateOnActionTrigger(animationsMap['iconOnActionTriggerAnimation']!, hasBeenTriggered: hasIconTriggered),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .likes(socialFeedUserPostsRecord)
                                                                              .toString(),
                                                                          '0',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .override(
                                                                              fontFamily: 'Figtree',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .mode_comment_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 24.0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      socialFeedUserPostsRecord
                                                                          .numComments
                                                                          .toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Figtree',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                dateTimeFormat(
                                                                    "relative",
                                                                    socialFeedUserPostsRecord
                                                                        .timePosted!),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Figtree',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          12.0),
                                                              child: _buildHashtagText(
                                                                context,
                                                                socialFeedUserPostsRecord
                                                                    .postDescription
                                                                    .maybeHandleOverflow(
                                                                  maxChars: 200,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHashtagText(BuildContext context, String text) {
    final theme = FlutterFlowTheme.of(context);
    final baseStyle = theme.bodyMedium.override(
      fontFamily: 'Figtree',
      fontSize: 14.5,
      letterSpacing: 0.0,
    );
    final hashtagStyle = baseStyle.copyWith(
      color: theme.primary,
      fontWeight: FontWeight.w600,
    );

    final regex = RegExp(r'#\w+');
    final spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }
      final hashtag = match.group(0)!;
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: GestureDetector(
          onTap: () {
            context.pushNamed(
              'Search',
              queryParameters: {
                'initialQuery': hashtag,
              }.withoutNulls,
            );
          },
          child: Text(hashtag, style: hashtagStyle),
        ),
      ));
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    if (spans.isEmpty) {
      return Text(text, maxLines: 4, style: baseStyle);
    }

    return RichText(
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: spans),
    );
  }
}
