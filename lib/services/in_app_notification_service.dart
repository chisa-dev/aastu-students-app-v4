import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Writes notification documents to Firestore.
/// A Cloud Function (`onNotificationCreated`) picks these up and sends
/// the actual FCM push notification to the target user's device.
class InAppNotificationService {
  static final _notifications =
      FirebaseFirestore.instance.collection('notifications');

  /// Send a notification when someone follows a user.
  static Future<void> sendFollowNotification({
    required DocumentReference targetUserRef,
  }) async {
    try {
      final senderName = currentUserDisplayName.isNotEmpty
          ? currentUserDisplayName
          : 'Someone';
      await _notifications.add({
        'type': 'follow',
        'title': 'New Follower',
        'body': '$senderName started following you',
        'sender': currentUserReference,
        'receiver': targetUserRef,
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (e) {
      debugPrint('[Notification] Error sending follow notification: $e');
    }
  }

  /// Send a notification when someone likes a post.
  static Future<void> sendLikeNotification({
    required DocumentReference postOwnerRef,
    required DocumentReference postRef,
  }) async {
    // Don't notify yourself
    if (postOwnerRef == currentUserReference) return;
    try {
      final senderName = currentUserDisplayName.isNotEmpty
          ? currentUserDisplayName
          : 'Someone';
      await _notifications.add({
        'type': 'like',
        'title': 'Post Liked',
        'body': '$senderName liked your post',
        'sender': currentUserReference,
        'receiver': postOwnerRef,
        'post': postRef,
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (e) {
      debugPrint('[Notification] Error sending like notification: $e');
    }
  }
}
