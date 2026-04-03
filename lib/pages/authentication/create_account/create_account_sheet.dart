import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/anonymous_user_service.dart';

/// Shows the create account bottom sheet.
/// Returns true if the user successfully created an account.
Future<bool?> showCreateAccountSheet(
  BuildContext context, {
  String? featureName,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CreateAccountSheet(featureName: featureName),
  );
}

class CreateAccountSheet extends StatefulWidget {
  const CreateAccountSheet({super.key, this.featureName});

  final String? featureName;

  @override
  State<CreateAccountSheet> createState() => _CreateAccountSheetState();
}

class _CreateAccountSheetState extends State<CreateAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _errorMessage;

  // 0 = info prompt, 1 = email/password form, 2 = profile details, 3 = has existing account (login)
  int _step = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        padding: EdgeInsets.only(bottom: bottomInset),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Color(0x33000000),
              offset: Offset(0.0, -2.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40.0,
                  height: 4.0,
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                if (_step == 0) _buildInfoStep(),
                if (_step == 1) _buildEmailPasswordStep(),
                if (_step == 2) _buildProfileStep(),
                if (_step == 3) _buildLoginStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Step 0: Info prompt explaining why they need an account
  Widget _buildInfoStep() {
    final featureText = widget.featureName != null
        ? 'To ${widget.featureName}, you need to create a free account.'
        : 'Create a free account to unlock all features.';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).accent1,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_add_alt_1_rounded,
            color: FlutterFlowTheme.of(context).primary,
            size: 40.0,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Create Your Account',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Outfit',
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 8.0),
        Text(
          featureText,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Your data and progress will be preserved.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Figtree',
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 24.0),
        FFButtonWidget(
          onPressed: () => setState(() => _step = 1),
          text: 'Create Account',
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
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        SizedBox(height: 12.0),
        FFButtonWidget(
          onPressed: () => setState(() => _step = 3),
          text: 'I already have an account',
          options: FFButtonOptions(
            width: double.infinity,
            height: 50.0,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  color: FlutterFlowTheme.of(context).primary,
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
        SizedBox(height: 12.0),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Maybe Later',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }

  /// Step 1: Email and password form
  Widget _buildEmailPasswordStep() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, size: 20.0),
                onPressed: () => setState(() {
                  _step = 0;
                  _errorMessage = null;
                }),
              ),
              Text(
                'Create Account',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          if (_errorMessage != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _errorMessage!,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Figtree',
                      color: FlutterFlowTheme.of(context).error,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            SizedBox(height: 12.0),
          ],
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            autofillHints: [AutofillHints.newPassword],
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Create a password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return 'Password is required';
              if (val.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            validator: (val) {
              if (val != _passwordController.text) {
                return 'Passwords don\'t match';
              }
              return null;
            },
          ),
          SizedBox(height: 24.0),
          FFButtonWidget(
            onPressed: _isLoading ? null : _handleCreateAccount,
            text: _isLoading ? 'Creating Account...' : 'Continue',
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
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ],
      ),
    );
  }

  /// Step 2: Profile details (name)
  Widget _buildProfileStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, size: 20.0),
              onPressed: () => setState(() => _step = 1),
            ),
            Text(
              'Complete Your Profile',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Add your name so others can recognize you.',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _displayNameController,
          textCapitalization: TextCapitalization.words,
          autofillHints: [AutofillHints.name],
          decoration: InputDecoration(
            labelText: 'Display Name',
            hintText: 'Enter your name',
            prefixIcon: Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
          ),
        ),
        SizedBox(height: 24.0),
        FFButtonWidget(
          onPressed: _isLoading ? null : _handleCompleteProfile,
          text: _isLoading ? 'Finishing up...' : 'Complete Setup',
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
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: TextButton(
            onPressed: () {
              // Skip profile details, just finish
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Skip for now',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Figtree',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  /// Step 3: Login for existing account holders
  Widget _buildLoginStep() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, size: 20.0),
                onPressed: () => setState(() {
                  _step = 0;
                  _errorMessage = null;
                }),
              ),
              Text(
                'Welcome Back',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Sign in with your existing account. Your current data will be merged.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                ),
          ),
          SizedBox(height: 20.0),
          if (_errorMessage != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _errorMessage!,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Figtree',
                      color: FlutterFlowTheme.of(context).error,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            SizedBox(height: 12.0),
          ],
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return 'Email is required';
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            autofillHints: [AutofillHints.password],
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return 'Password is required';
              return null;
            },
          ),
          SizedBox(height: 24.0),
          FFButtonWidget(
            onPressed: _isLoading ? null : _handleLogin,
            text: _isLoading ? 'Signing in...' : 'Sign In',
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
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle account creation (link anonymous with email/password).
  Future<void> _handleCreateAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await AnonymousUserService().linkWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {
        // Prefill display name from existing data
        final currentName = currentUserDocument?.displayName ?? '';
        _displayNameController.text = currentName;
        setState(() {
          _isLoading = false;
          _step = 2;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = switch (e.code) {
          'email-already-in-use' =>
            'This email is already in use. Try signing in instead.',
          'weak-password' => 'Password is too weak. Use at least 6 characters.',
          'invalid-email' => 'Invalid email address.',
          _ => 'Error: ${e.message}',
        };
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Something went wrong. Please try again.';
      });
    }
  }

  /// Handle profile completion.
  Future<void> _handleCompleteProfile() async {
    final name = _displayNameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AnonymousUserService().updateProfile(displayName: name);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile. Please try again.')),
        );
      }
    }
  }

  /// Handle login for existing account users.
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Sign out anonymous user first, then sign in with email
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = switch (e.code) {
          'user-not-found' => 'No account found with this email.',
          'wrong-password' || 'INVALID_LOGIN_CREDENTIALS' =>
            'Invalid email or password.',
          'user-disabled' => 'This account has been disabled.',
          _ => 'Error: ${e.message}',
        };
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Something went wrong. Please try again.';
      });
    }
  }
}
