import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/blurhash_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'search_model.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, this.initialQuery});

  final String? initialQuery;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with TickerProviderStateMixin {
  late SearchModel _model;
  late TabController _tabController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _query = '';
  List<UsersRecord> _userResults = [];
  List<UserPostsRecord> _postResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  // Cache all users and posts for client-side search
  List<UsersRecord>? _allUsers;
  List<UserPostsRecord>? _allPosts;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());
    _tabController = TabController(length: 2, vsync: this);

    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _model.searchTextController.text = widget.initialQuery!;
      _query = widget.initialQuery!;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _performSearch(_query);
      });
    }

    _model.searchTextController.addListener(() {
      final text = _model.searchTextController.text.trim();
      if (text != _query) {
        _query = text;
        if (text.isEmpty) {
          setState(() {
            _userResults = [];
            _postResults = [];
            _hasSearched = false;
          });
        } else {
          _performSearch(text);
        }
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() => _isSearching = true);

    final lowerQuery = query.toLowerCase();
    final isHashtag =
        lowerQuery.startsWith('#') ? lowerQuery.substring(1) : lowerQuery;

    try {
      // Load all users once and cache
      _allUsers ??= await queryUsersRecordOnce();

      // Load all approved posts once and cache
      _allPosts ??= await queryUserPostsRecordOnce(
        queryBuilder: (q) => q.orderBy('timePosted', descending: true),
      );

      // Filter users client-side
      final filteredUsers = _allUsers!.where((user) {
        final name = user.displayName.toLowerCase();
        final username = user.userName.toLowerCase();
        final email = user.email.toLowerCase();
        return name.contains(lowerQuery) ||
            username.contains(lowerQuery) ||
            email.contains(lowerQuery);
      }).toList();

      // Filter posts client-side
      final filteredPosts = _allPosts!.where((post) {
        if (post.status == 'pending' && post.postUser != currentUserReference) {
          return false;
        }
        final desc = post.postDescription.toLowerCase();
        final tag = post.tag.toLowerCase();
        return desc.contains(isHashtag) || tag.contains(isHashtag);
      }).toList();

      if (mounted) {
        setState(() {
          _userResults = filteredUsers;
          _postResults = filteredPosts;
          _isSearching = false;
          _hasSearched = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 12.0, 16.0, 0.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: theme.primaryText,
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: theme.alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  14.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.search_rounded,
                                color: theme.secondaryText,
                                size: 22.0,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _model.searchTextController,
                                focusNode: _model.searchFocusNode,
                                autofocus: widget.initialQuery == null,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: 'Search users, posts, hashtags...',
                                  hintStyle: theme.bodyMedium.override(
                                    fontFamily: 'Figtree',
                                    color: theme.secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                ),
                                style: theme.bodyMedium.override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                            if (_model.searchTextController.text.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  _model.searchTextController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 12.0, 0.0),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: theme.secondaryText,
                                    size: 20.0,
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

              // Tabs
              if (_hasSearched) ...[
                const SizedBox(height: 12.0),
                TabBar(
                  controller: _tabController,
                  labelColor: theme.primary,
                  unselectedLabelColor: theme.secondaryText,
                  labelStyle: theme.titleSmall.override(
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.0,
                  ),
                  unselectedLabelStyle: theme.titleSmall.override(
                    fontFamily: 'Figtree',
                    letterSpacing: 0.0,
                  ),
                  indicatorColor: theme.primary,
                  indicatorWeight: 2.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'Users (${_userResults.length})'),
                    Tab(text: 'Posts (${_postResults.length})'),
                  ],
                ),
              ],

              // Results
              Expanded(
                child: _isSearching
                    ? Center(
                        child: CircularProgressIndicator(
                          color: theme.primary,
                        ),
                      )
                    : !_hasSearched
                        ? _buildEmptyState(theme)
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              _buildUserResults(theme),
                              _buildPostResults(theme),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(FlutterFlowTheme theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64.0,
            color: theme.secondaryText.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Search for users or posts',
            style: theme.bodyLarge.override(
              fontFamily: 'Figtree',
              color: theme.secondaryText,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserResults(FlutterFlowTheme theme) {
    if (_userResults.isEmpty) {
      return Center(
        child: Text(
          'No users found',
          style: theme.bodyMedium.override(
            fontFamily: 'Figtree',
            color: theme.secondaryText,
            letterSpacing: 0.0,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: _userResults.length,
      itemBuilder: (context, index) {
        final user = _userResults[index];
        return InkWell(
          onTap: () {
            context.pushNamed(
              'viewProfilePageOther',
              queryParameters: {
                'userDetails': serializeParam(user, ParamType.Document),
                'showPage': serializeParam(false, ParamType.bool),
                'pageTitle': serializeParam('Search', ParamType.String),
              }.withoutNulls,
              extra: <String, dynamic>{'userDetails': user},
            );
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16.0, 6.0, 16.0, 6.0),
            child: Row(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: theme.accent1,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      user.photoUrl,
                      width: 48.0,
                      height: 48.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 28,
                        color: theme.secondaryText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.displayName,
                              overflow: TextOverflow.ellipsis,
                              style: theme.bodyLarge.override(
                                fontFamily: 'Figtree',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                          if (user.isVerified)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: Icon(
                                Icons.verified_sharp,
                                color: theme.primary,
                                size: 16.0,
                              ),
                            ),
                        ],
                      ),
                      if (user.userName.isNotEmpty)
                        Text(
                          user.userName,
                          style: theme.labelMedium.override(
                            fontFamily: 'Figtree',
                            color: theme.secondaryText,
                            letterSpacing: 0.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostResults(FlutterFlowTheme theme) {
    if (_postResults.isEmpty) {
      return Center(
        child: Text(
          'No posts found',
          style: theme.bodyMedium.override(
            fontFamily: 'Figtree',
            color: theme.secondaryText,
            letterSpacing: 0.0,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: _postResults.length,
      itemBuilder: (context, index) {
        final post = _postResults[index];
        return FutureBuilder<UsersRecord>(
          future: UsersRecord.getDocumentOnce(post.postUser!),
          builder: (context, userSnapshot) {
            final user = userSnapshot.data;
            return InkWell(
              onTap: () {
                if (user != null) {
                  context.pushNamed(
                    'postDetails_Page',
                    queryParameters: {
                      'userRecord':
                          serializeParam(user, ParamType.Document),
                      'postReference':
                          serializeParam(post, ParamType.Document),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      'userRecord': user,
                      'postReference': post,
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 6.0, 16.0, 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post thumbnail
                    if (post.postPhoto.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: BlurHashNetworkImage(
                          imageUrl: post.postPhoto,
                          blurHash: post.photoBlurHash,
                          width: 64.0,
                          height: 64.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        width: 64.0,
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: theme.alternate,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          Icons.article_outlined,
                          color: theme.secondaryText,
                          size: 28.0,
                        ),
                      ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user != null)
                            Row(
                              children: [
                                Text(
                                  user.displayName,
                                  style: theme.bodyMedium.override(
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                if (user.isVerified)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.verified_sharp,
                                      color: theme.primary,
                                      size: 14.0,
                                    ),
                                  ),
                              ],
                            )
                          else
                            Container(
                              width: 100,
                              height: 14,
                              decoration: BoxDecoration(
                                color: theme.alternate,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          const SizedBox(height: 4.0),
                          Text(
                            post.postDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.bodySmall.override(
                              fontFamily: 'Figtree',
                              color: theme.secondaryText,
                              letterSpacing: 0.0,
                            ),
                          ),
                          if (post.tag.isNotEmpty) ...[
                            const SizedBox(height: 4.0),
                            Container(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 2.0, 8.0, 2.0),
                              decoration: BoxDecoration(
                                color: theme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius:
                                    BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                '#${post.tag}',
                                style: theme.labelSmall.override(
                                  fontFamily: 'Figtree',
                                  color: theme.primary,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
