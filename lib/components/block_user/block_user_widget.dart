import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

/// Shows a confirmation dialog to block a user.
/// Returns true if the user was blocked successfully.
Future<bool?> showBlockUserDialog(
  BuildContext context, {
  required DocumentReference userRef,
  required String userName,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => BlockUserWidget(
      userRef: userRef,
      userName: userName,
    ),
  );
}

class BlockUserWidget extends StatefulWidget {
  const BlockUserWidget({
    super.key,
    required this.userRef,
    required this.userName,
  });

  final DocumentReference userRef;
  final String userName;

  @override
  State<BlockUserWidget> createState() => _BlockUserWidgetState();
}

class _BlockUserWidgetState extends State<BlockUserWidget> {
  bool _isBlocking = false;

  Future<void> _blockUser() async {
    if (currentUserReference == null) return;

    setState(() => _isBlocking = true);

    try {
      // Add to current user's blocked list
      await currentUserReference!.update({
        'blockedUsers': FieldValue.arrayUnion([widget.userRef]),
      });

      // Create a report/notification for admin about the block
      await FirebaseFirestore.instance.collection('userReports').add({
        'reporterId': currentUserReference,
        'reportedUserId': widget.userRef,
        'type': 'block',
        'reason': 'User blocked by another user',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${widget.userName} has been blocked. Their content will be hidden from your feed.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      setState(() => _isBlocking = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to block user. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.0,
              height: 4.0,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Icon(
              Icons.block_rounded,
              color: FlutterFlowTheme.of(context).error,
              size: 48.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Block ${widget.userName}?',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'They won\'t be able to see your content or interact with you. Their posts will be hidden from your feed. You can unblock them later from settings.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Figtree',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            const SizedBox(height: 24.0),
            FFButtonWidget(
              onPressed: _isBlocking ? null : _blockUser,
              text: _isBlocking ? 'Blocking...' : 'Block User',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50.0,
                color: FlutterFlowTheme.of(context).error,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Figtree',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 12.0),
            FFButtonWidget(
              onPressed: () => Navigator.of(context).pop(false),
              text: 'Cancel',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50.0,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      letterSpacing: 0.0,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
