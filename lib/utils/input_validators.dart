/// Input validation utilities for signup and profile creation.

/// Blocked disposable/temporary email domains.
const _blockedEmailDomains = {
  'tempmail.com', 'throwaway.email', 'guerrillamail.com', 'mailinator.com',
  'yopmail.com', 'sharklasers.com', 'guerrillamailblock.com', 'grr.la',
  'dispostable.com', 'trashmail.com', 'fakeinbox.com', 'tempail.com',
  'temp-mail.org', 'emailondeck.com', 'getnada.com', 'maildrop.cc',
  'mohmal.com', '10minutemail.com', 'minuteinbox.com', 'tempr.email',
  'discard.email', 'tmpmail.net', 'tmpmail.org', 'bupmail.com',
};

/// Profanity patterns — short fragments that catch variations like
/// "f u c k", "fck", "sh1t", etc. without spelling them out.
final _profanityPatterns = [
  RegExp(r'f\s*[uv*@]\s*[c*]\s*[k*]', caseSensitive: false),
  RegExp(r'sh\s*[i1!*]\s*t', caseSensitive: false),
  RegExp(r'a\s*[s$]\s*[s$]h', caseSensitive: false),
  RegExp(r'b\s*[i1!]\s*t\s*c\s*h', caseSensitive: false),
  RegExp(r'd\s*[i1!]\s*c\s*k', caseSensitive: false),
  RegExp(r'n\s*[i1!]\s*g\s*g', caseSensitive: false),
  RegExp(r'p\s*[uv]\s*s\s*s\s*y', caseSensitive: false),
  RegExp(r'w\s*h\s*[o0]\s*r\s*e', caseSensitive: false),
  RegExp(r'c\s*[uv]\s*n\s*t', caseSensitive: false),
  RegExp(r'damn', caseSensitive: false),
  RegExp(r'stup\s*[i1!]d', caseSensitive: false),
];

/// Validates email on signup.
String? validateSignupEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }
  final email = value.trim().toLowerCase();

  // Basic format check
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address';
  }

  // Local part checks (before @)
  final localPart = email.split('@').first;
  if (localPart.length < 3) {
    return 'Email address is too short';
  }

  // Check for random character spam (e.g. "asdfg@", "xyzzy@")
  final vowelCount = RegExp(r'[aeiou]', caseSensitive: false).allMatches(localPart).length;
  if (localPart.length > 5 && vowelCount == 0) {
    return 'Please use a valid email address';
  }

  // Blocked disposable email domains
  final domain = email.split('@').last;
  if (_blockedEmailDomains.contains(domain)) {
    return 'Temporary email addresses are not allowed';
  }

  return null;
}

/// Validates display name / username.
String? validateDisplayName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Name is required';
  }
  final name = value.trim();

  if (name.length < 2) {
    return 'Name must be at least 2 characters';
  }

  if (name.length > 50) {
    return 'Name is too long';
  }

  // Must contain at least one letter
  if (!RegExp(r'[a-zA-Z]').hasMatch(name)) {
    return 'Name must contain letters';
  }

  // No excessive repeating characters (e.g. "aaaaaa")
  if (RegExp(r'(.)\1{3,}').hasMatch(name)) {
    return 'Please enter a real name';
  }

  // Profanity check
  for (final pattern in _profanityPatterns) {
    if (pattern.hasMatch(name)) {
      return 'This name contains inappropriate language';
    }
  }

  return null;
}

/// Validates username (handle).
String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Username is required';
  }
  final username = value.trim();

  if (username.length < 3) {
    return 'Username must be at least 3 characters';
  }

  if (username.length > 30) {
    return 'Username is too long';
  }

  // Only allow letters, numbers, underscores, dots
  if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(username)) {
    return 'Only letters, numbers, dots and underscores allowed';
  }

  // Profanity check
  for (final pattern in _profanityPatterns) {
    if (pattern.hasMatch(username)) {
      return 'This username contains inappropriate language';
    }
  }

  return null;
}
