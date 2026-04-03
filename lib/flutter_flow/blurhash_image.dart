import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

/// A network image widget that shows a BlurHash placeholder while loading.
///
/// Falls back to a grey shimmer if [blurHash] is null/empty.
/// Use [shape] = [BoxShape.circle] for circular avatars.
class BlurHashNetworkImage extends StatelessWidget {
  const BlurHashNetworkImage({
    super.key,
    required this.imageUrl,
    this.blurHash,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  final String imageUrl;
  final String? blurHash;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final placeholder = _buildPlaceholder();

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => placeholder,
      errorWidget: (_, __, ___) => Container(
        width: width,
        height: height,
        color: const Color(0xFFE0E0E0),
        child: const Icon(Icons.broken_image_outlined,
            color: Colors.grey, size: 24),
      ),
    );

    if (shape == BoxShape.circle) {
      return ClipOval(
        child: SizedBox(width: width, height: height, child: image),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _buildPlaceholder() {
    if (blurHash != null && blurHash!.isNotEmpty) {
      return SizedBox(
        width: width,
        height: height,
        child: BlurHash(hash: blurHash!, imageFit: fit),
      );
    }
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFE0E0E0),
    );
  }
}
