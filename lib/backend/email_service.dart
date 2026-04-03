import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';

class EmailService {
  static Future<void> notifyAdmin({
    required String subject,
    required String body,
  }) async {
    try {
      final env = FFDevEnvironmentValues();
      final smtpServer = SmtpServer(
        env.emailHost,
        port: 465,
        ssl: true,
        username: env.emailUser,
        password: env.emailPass,
      );

      final message = Message()
        ..from = Address(env.emailUser, 'AASTU Students App')
        ..recipients.add(env.adminEmail)
        ..subject = subject
        ..text = body;

      await send(message, smtpServer);
      debugPrint('Admin email notification sent: $subject');
    } catch (e) {
      debugPrint('Failed to send admin email: $e');
    }
  }

  static Future<void> notifyNewPost({
    required String userName,
    required String postDescription,
  }) async {
    await notifyAdmin(
      subject: 'New Post Submitted - Pending Review',
      body: 'A new post has been submitted and is awaiting moderation.\n\n'
          'Posted by: $userName\n'
          'Description: $postDescription\n\n'
          'Please review it in the admin panel.',
    );
  }

  static Future<void> notifyNewStory({
    required String userName,
    required String storyDescription,
  }) async {
    await notifyAdmin(
      subject: 'New Story Submitted - Pending Review',
      body: 'A new story has been submitted and is awaiting moderation.\n\n'
          'Posted by: $userName\n'
          'Description: $storyDescription\n\n'
          'Please review it in the admin panel.',
    );
  }

  static Future<void> notifyNewStoreItem({
    required String userName,
    required String itemTitle,
  }) async {
    await notifyAdmin(
      subject: 'New Store Item Posted - Pending Review',
      body: 'A new store item has been posted and is awaiting approval.\n\n'
          'Seller: $userName\n'
          'Item: $itemTitle\n\n'
          'Please review it in the admin panel.',
    );
  }
}
