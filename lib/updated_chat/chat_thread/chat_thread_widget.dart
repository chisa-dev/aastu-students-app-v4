import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/blurhash_image.dart';
import 'package:flutter/material.dart';
import 'chat_thread_model.dart';
export 'chat_thread_model.dart';

class ChatThreadWidget extends StatefulWidget {
  const ChatThreadWidget({
    super.key,
    required this.chatMessagesRef,
  });

  final ChatMessagesRecord? chatMessagesRef;

  @override
  State<ChatThreadWidget> createState() => _ChatThreadWidgetState();
}

class _ChatThreadWidgetState extends State<ChatThreadWidget> {
  late ChatThreadModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  bool get _isMe => widget.chatMessagesRef?.user == currentUserReference;

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Delete Message'),
        content: Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await widget.chatMessagesRef?.reference.delete();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: FlutterFlowTheme.of(context).error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isMe) {
      return _buildMyMessage();
    } else {
      return _buildOtherMessage();
    }
  }

  Widget _buildOtherMessage() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 48.0, 4.0),
      child: FutureBuilder<UsersRecord>(
        future: _model.chatUser(
          uniqueQueryKey: widget.chatMessagesRef?.reference.id,
          requestFn: () => UsersRecord.getDocumentOnce(
              widget.chatMessagesRef!.user!),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 40.0,
              child: Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ),
            );
          }

          final otherUser = snapshot.data!;

          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent1,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                ),
                child: BlurHashNetworkImage(
                  imageUrl: otherUser.photoUrl,
                  blurHash: otherUser.photoBlurHash,
                  width: 32.0,
                  height: 32.0,
                  fit: BoxFit.cover,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            otherUser.displayName,
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Figtree',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            valueOrDefault<String>(
                              dateTimeFormat("relative",
                                  widget.chatMessagesRef?.timestamp),
                              '--',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Figtree',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 10.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.0,
                            color: Color(0x0D000000),
                            offset: Offset(0.0, 1.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.chatMessagesRef?.text != null &&
                                widget.chatMessagesRef!.text.isNotEmpty)
                              SelectionArea(
                                child: Text(
                                  widget.chatMessagesRef!.text,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Figtree',
                                        letterSpacing: 0.0,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                            if (widget.chatMessagesRef?.image != null &&
                                widget.chatMessagesRef!.image.isNotEmpty)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    widget.chatMessagesRef!.text.isNotEmpty
                                        ? 8.0
                                        : 0.0,
                                    0.0,
                                    0.0),
                                child: _buildMedia(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMyMessage() {
    return GestureDetector(
      onLongPress: _showDeleteDialog,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(48.0, 4.0, 12.0, 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 4.0),
                    child: Text(
                      valueOrDefault<String>(
                        dateTimeFormat("relative",
                            widget.chatMessagesRef?.timestamp),
                        '--',
                      ),
                      style: FlutterFlowTheme.of(context)
                          .labelSmall
                          .override(
                            fontFamily: 'Figtree',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(4.0),
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color(0x0D000000),
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (widget.chatMessagesRef?.text != null &&
                              widget.chatMessagesRef!.text.isNotEmpty)
                            SelectionArea(
                              child: Text(
                                widget.chatMessagesRef!.text,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Figtree',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                          if (widget.chatMessagesRef?.image != null &&
                              widget.chatMessagesRef!.image.isNotEmpty)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  widget.chatMessagesRef!.text.isNotEmpty
                                      ? 8.0
                                      : 0.0,
                                  0.0,
                                  0.0),
                              child: _buildMedia(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia() {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          'image_Details',
          queryParameters: {
            'chatMessage': serializeParam(
              widget.chatMessagesRef,
              ParamType.Document,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'chatMessage': widget.chatMessagesRef,
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FlutterFlowMediaDisplay(
          path: widget.chatMessagesRef!.image,
          imageBuilder: (path) => BlurHashNetworkImage(
            imageUrl: path,
            width: 220.0,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.0),
          ),
          videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
            path: path,
            width: 220.0,
            autoPlay: false,
            looping: false,
            showControls: true,
            allowFullScreen: true,
            allowPlaybackSpeedMenu: false,
          ),
        ),
      ),
    );
  }
}
