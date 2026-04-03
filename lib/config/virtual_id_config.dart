/// Configuration for Virtual ID card field positions.
///
/// Adjust x,y coordinates to control where each field appears
/// on the ID card preview. Values are in logical pixels relative
/// to the card container (320x200).
class VirtualIdConfig {
  // Card dimensions
  static const double cardWidth = 320.0;
  static const double cardHeight = 200.0;

  // ── Front card field positions (x, y offsets from top-left) ──

  // Photo position (right side of the card)
  static const double photoX = 215.0;
  static const double photoY = 75.0;
  static const double photoWidth = 78.0;
  static const double photoHeight = 83.0;

  // Text fields start position (left side)
  static const double fieldsStartX = 126.0;
  static const double fieldsStartY = 72.5;
  static const double fieldLineHeight = 18.0;

  // Individual field Y offsets (relative to fieldsStartY)
  static const double fullNameOffsetY = 0.0;
  static const double genderOffsetY = 16.0;
  static const double collegeOffsetY = 32.0;
  static const double studyLevelOffsetY = 51.0;
  static const double admissionOffsetY = 68.0;
  static const double phoneNoOffsetY = 85.0;

  // Website URL position (bottom center of front card)
  static const double websiteUrlY = 172.0;
  static const double websiteUrlFontSize = 9.0;

  // Rotated SID number position (right edge, vertical)
  static const double sidX = 308.0;
  static const double sidY = 67.0;
  static const double sidFontSize = 9.0;

  // Text styling
  static const double labelFontSize = 7.0;
  static const double valueFontSize = 9.0;
  static const double nameFontSize = 10.0;

  // ── Back card field positions ──

  // QR code position (left-bottom of back card)
  static const double qrX = 8.0;
  static const double qrY = 130.0;
  static const double qrSize = 55.0;

  // Issued date position
  static const double issuedDateX = 142.0;
  static const double issuedDateY = 147.0;

  // Expiry date position
  static const double expiryDateX = 142.0;
  static const double expiryDateY = 159.0;

  // Date text styling
  static const double dateFontSize = 8.0;

  // ── ID card assets ──
  static const String frontCardImage = 'assets/images/20241026_092225.jpg';
  static const String backCardImage = 'assets/images/20240317_164704.jpg';
}
