import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'gallery_fullscreen_viewer.dart';
import 'gallery_model.dart';
export 'gallery_model.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late GalleryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GalleryModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Gallery',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 18, 16, 0),
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => context.safePop(),
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AASTU Gallery',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SF Pro Display',
                            fontSize: 22,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                    ),
                  ],
                ),
              ),

              // Gallery grid
              Expanded(
                child: StreamBuilder<List<GalleryRecord>>(
                  stream: queryGalleryRecord(
                    queryBuilder: (galleryRecord) => galleryRecord.where(
                      'approved',
                      isEqualTo: true,
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }

                    final galleryImages = snapshot.data!;

                    if (galleryImages.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 64,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No photos yet',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Figtree',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }

                    return _MasonryGrid(
                      images: galleryImages,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pinterest-style masonry grid with two columns of varying heights.
class _MasonryGrid extends StatelessWidget {
  const _MasonryGrid({required this.images});

  final List<GalleryRecord> images;

  @override
  Widget build(BuildContext context) {
    // Split images into two columns, alternating assignment
    final leftColumn = <_IndexedImage>[];
    final rightColumn = <_IndexedImage>[];

    for (var i = 0; i < images.length; i++) {
      final item = _IndexedImage(index: i, record: images[i]);
      if (i % 2 == 0) {
        leftColumn.add(item);
      } else {
        rightColumn.add(item);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftColumn
                  .map((item) => _GalleryTile(
                        image: item.record,
                        index: item.index,
                        allImages: images,
                        heightFactor: _getHeightFactor(item.index),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              children: rightColumn
                  .map((item) => _GalleryTile(
                        image: item.record,
                        index: item.index,
                        allImages: images,
                        heightFactor: _getHeightFactor(item.index),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Creates varied heights for a Pinterest feel.
  double _getHeightFactor(int index) {
    const factors = [1.3, 1.0, 1.15, 0.9, 1.25, 1.05, 0.95, 1.2];
    return factors[index % factors.length];
  }
}

class _IndexedImage {
  final int index;
  final GalleryRecord record;
  const _IndexedImage({required this.index, required this.record});
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({
    required this.image,
    required this.index,
    required this.allImages,
    required this.heightFactor,
  });

  final GalleryRecord image;
  final int index;
  final List<GalleryRecord> allImages;
  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    final baseHeight = MediaQuery.sizeOf(context).width * 0.38;
    final tileHeight = baseHeight * heightFactor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  GalleryFullscreenViewer(
                images: allImages,
                initialIndex: index,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 250),
            ),
          );
        },
        child: Hero(
          tag: image.imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: tileHeight,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: image.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => image.blurHash.isNotEmpty
                    ? BlurHash(
                        hash: image.blurHash,
                        imageFit: BoxFit.cover,
                      )
                    : Container(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                errorWidget: (context, url, error) => Container(
                  color: FlutterFlowTheme.of(context).alternate,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
