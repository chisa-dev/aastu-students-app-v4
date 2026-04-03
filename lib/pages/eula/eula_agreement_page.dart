import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

const String _eulaAcceptedKey = 'eula_accepted_v1';

/// Check if the user has already accepted the EULA.
Future<bool> hasAcceptedEula() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_eulaAcceptedKey) ?? false;
}

/// Show EULA page if not yet accepted. Returns true if accepted.
Future<bool> ensureEulaAccepted(BuildContext context) async {
  if (await hasAcceptedEula()) return true;

  final result = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (_) => const EulaAgreementPage(),
      fullscreenDialog: true,
    ),
  );
  return result == true;
}

class EulaAgreementPage extends StatefulWidget {
  const EulaAgreementPage({super.key});

  @override
  State<EulaAgreementPage> createState() => _EulaAgreementPageState();
}

class _EulaAgreementPageState extends State<EulaAgreementPage> {
  bool _agreed = false;

  Future<void> _acceptEula() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_eulaAcceptedKey, true);
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Center(
                child: Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent1,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 32.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Terms of Use',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Please review and accept our terms before continuing.',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Figtree',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _eulaText,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Figtree',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Checkbox(
                      value: _agreed,
                      onChanged: (val) =>
                          setState(() => _agreed = val ?? false),
                      activeColor: FlutterFlowTheme.of(context).primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _agreed = !_agreed),
                      child: Text(
                        'I agree to the Terms of Use and Community Guidelines',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Figtree',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              FFButtonWidget(
                onPressed: _agreed ? _acceptEula : null,
                text: 'Continue',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Figtree',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  disabledColor: FlutterFlowTheme.of(context).alternate,
                  disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

const String _eulaText = '''
AASTU Student Community - Terms of Use & Community Guidelines

Last Updated: April 2026

Welcome to AASTU Student Community. By using this application, you agree to the following terms and conditions.

1. ACCEPTANCE OF TERMS
By downloading, installing, or using this application, you agree to be bound by these Terms of Use. If you do not agree, please do not use the application.

2. USER ACCOUNTS
- You may use the app as a guest with limited features.
- Creating an account requires a valid email address and password.
- You are responsible for maintaining the confidentiality of your account credentials.
- You must provide accurate information when creating your account.

3. COMMUNITY GUIDELINES & CONTENT POLICY
This application is a community platform for AASTU students. To maintain a safe and respectful environment:

a) NO TOLERANCE FOR OBJECTIONABLE CONTENT
- You must not post, share, or distribute content that is offensive, abusive, harassing, threatening, hateful, or discriminatory.
- Content that promotes violence, illegal activities, or self-harm is strictly prohibited.
- Sexually explicit or pornographic content is not allowed.
- Spam, misleading, or fraudulent content is prohibited.

b) RESPECTFUL BEHAVIOR
- Treat all community members with respect and dignity.
- Bullying, harassment, or intimidation of any kind will not be tolerated.
- Do not impersonate other users or misrepresent your identity.

c) INTELLECTUAL PROPERTY
- Only share content you own or have the right to share.
- Do not violate copyright, trademark, or other intellectual property rights.

4. CONTENT MODERATION
- All user-generated content may be reviewed by our moderation team.
- Content that violates these guidelines will be removed within 24 hours of being reported.
- Users who repeatedly violate these terms will have their accounts suspended or permanently banned.

5. REPORTING & BLOCKING
- You can report objectionable content or abusive users using the report feature.
- You can block users who engage in abusive behavior.
- Blocked users will be unable to interact with you or see your content.
- All reports are reviewed by our team and acted upon within 24 hours.

6. USER-GENERATED CONTENT
- You retain ownership of content you create.
- By posting content, you grant us a non-exclusive license to display it within the application.
- We reserve the right to remove any content that violates these terms.

7. PRIVACY
- We collect only the information necessary to provide our services.
- Your personal information will not be shared with third parties without your consent.
- Device information may be collected for analytics and app improvement purposes.

8. MARKETPLACE (STORE)
- Items listed in the store must be legal and appropriate.
- We do not guarantee transactions between users.
- Misleading or fraudulent listings will be removed.

9. TERMINATION
- We reserve the right to suspend or terminate accounts that violate these terms.
- Users who are ejected for objectionable content will be notified of the reason.

10. DISCLAIMER
- This application is provided "as is" without warranties of any kind.
- We are not liable for any damages arising from your use of the application.

11. CHANGES TO TERMS
- We may update these terms from time to time.
- Continued use of the application after changes constitutes acceptance of the new terms.

By using AASTU Student Community, you acknowledge that you have read, understood, and agree to these Terms of Use and Community Guidelines.

For questions or concerns, contact us at: gemeelijah@gmail.com
''';
