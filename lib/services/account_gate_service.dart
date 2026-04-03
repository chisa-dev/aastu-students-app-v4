import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/pages/authentication/create_account/create_account_sheet.dart';

/// Utility service to gate features behind full account creation.
/// Anonymous users can browse but must create an account to:
/// - Create posts, stories, store items
/// - Create virtual ID
/// - Access chat
class AccountGateService {
  static final AccountGateService _instance = AccountGateService._();
  factory AccountGateService() => _instance;
  AccountGateService._();

  /// Returns true if the user has a full (non-anonymous) account.
  bool get hasFullAccount {
    final user = FirebaseAuth.instance.currentUser;
    return user != null && !user.isAnonymous;
  }

  /// Returns true if the user is anonymous.
  bool get isAnonymous {
    final user = FirebaseAuth.instance.currentUser;
    return user == null || user.isAnonymous;
  }

  /// Check if user can perform a gated action.
  /// If anonymous, shows the create account bottom sheet.
  /// Returns true if the user has a full account (can proceed).
  Future<bool> checkAccountOrPrompt(BuildContext context, {String? featureName}) async {
    if (hasFullAccount) return true;

    final result = await showCreateAccountSheet(
      context,
      featureName: featureName,
    );
    return result == true;
  }
}

/// Convenience function for quick account checks.
bool isAnonymousUser() => AccountGateService().isAnonymous;

/// Convenience function to gate a feature.
Future<bool> requireAccount(BuildContext context, {String? featureName}) =>
    AccountGateService().checkAccountOrPrompt(context, featureName: featureName);
