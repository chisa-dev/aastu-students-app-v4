import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Loads Virtual ID card image URLs + blurhashes from `app_config/virtual_id`
/// and caches them locally so cards render offline.
///
/// Firestore document: app_config/virtual_id
/// Fields:
///   front_image_url        (String) – public download URL for front card
///   back_image_url         (String) – public download URL for back card
///   front_image_blurhash   (String) – blurhash string for front card
///   back_image_blurhash    (String) – blurhash string for back card
class VirtualIdImageService {
  static const _frontUrlKey = 'virtual_id_front_url';
  static const _backUrlKey = 'virtual_id_back_url';
  static const _frontHashKey = 'virtual_id_front_blurhash';
  static const _backHashKey = 'virtual_id_back_blurhash';
  static const _docPath = 'app_config/virtual_id';

  static Future<String?> getCachedFrontUrl() async =>
      (await SharedPreferences.getInstance()).getString(_frontUrlKey);

  static Future<String?> getCachedBackUrl() async =>
      (await SharedPreferences.getInstance()).getString(_backUrlKey);

  static Future<String?> getCachedFrontBlurhash() async =>
      (await SharedPreferences.getInstance()).getString(_frontHashKey);

  static Future<String?> getCachedBackBlurhash() async =>
      (await SharedPreferences.getInstance()).getString(_backHashKey);

  /// Fetches all four values from Firestore, writes to cache, and returns them.
  /// Falls back to cache on network error.
  static Future<VirtualIdImages> fetchAndCache() async {
    try {
      final snap = await FirebaseFirestore.instance.doc(_docPath).get();
      if (!snap.exists) return await getFromCache();

      final data = snap.data() ?? {};
      final frontUrl = data['front_image_url'] as String?;
      final backUrl = data['back_image_url'] as String?;
      final frontHash = data['front_image_blurhash'] as String?;
      final backHash = data['back_image_blurhash'] as String?;

      final prefs = await SharedPreferences.getInstance();
      if (frontUrl?.isNotEmpty == true) prefs.setString(_frontUrlKey, frontUrl!);
      if (backUrl?.isNotEmpty == true) prefs.setString(_backUrlKey, backUrl!);
      if (frontHash?.isNotEmpty == true) prefs.setString(_frontHashKey, frontHash!);
      if (backHash?.isNotEmpty == true) prefs.setString(_backHashKey, backHash!);

      return VirtualIdImages(
        frontUrl: frontUrl,
        backUrl: backUrl,
        frontBlurhash: frontHash,
        backBlurhash: backHash,
      );
    } catch (_) {
      return await getFromCache();
    }
  }

  static Future<VirtualIdImages> getFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    return VirtualIdImages(
      frontUrl: prefs.getString(_frontUrlKey),
      backUrl: prefs.getString(_backUrlKey),
      frontBlurhash: prefs.getString(_frontHashKey),
      backBlurhash: prefs.getString(_backHashKey),
    );
  }
}

class VirtualIdImages {
  final String? frontUrl;
  final String? backUrl;
  final String? frontBlurhash;
  final String? backBlurhash;

  const VirtualIdImages({
    this.frontUrl,
    this.backUrl,
    this.frontBlurhash,
    this.backBlurhash,
  });
}
