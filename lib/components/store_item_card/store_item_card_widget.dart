import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/blurhash_image.dart';
import 'package:flutter/material.dart';
import 'store_item_card_model.dart';
export 'store_item_card_model.dart';

class StoreItemCardWidget extends StatefulWidget {
  const StoreItemCardWidget({
    super.key,
    required this.item,
  });

  final StoreItemsRecord item;

  @override
  State<StoreItemCardWidget> createState() => _StoreItemCardWidgetState();
}

class _StoreItemCardWidgetState extends State<StoreItemCardWidget> {
  late StoreItemCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreItemCardModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        widget.item.images.isNotEmpty ? widget.item.images.first : '';

    return InkWell(
      onTap: () {
        context.pushNamed(
          'StoreItemDetail',
          queryParameters: {
            'item': serializeParam(
              widget.item,
              ParamType.Document,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'item': widget.item,
          },
        );
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: imageUrl.isNotEmpty
                  ? BlurHashNetworkImage(
                      imageUrl: imageUrl,
                      blurHash: widget.item.photoBlurHash,
                      width: double.infinity,
                      height: 120.0,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 120.0,
                      color: Colors.grey[200],
                      child: Icon(Icons.storefront,
                          size: 40, color: Colors.grey),
                    ),
            ),
            // Info
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title.maybeHandleOverflow(
                      maxChars: 22,
                      replacement: '…',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.item.hasPrice() && widget.item.price > 0
                        ? '${widget.item.price.toStringAsFixed(0)} ETB'
                        : 'Free / Negotiable',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Figtree',
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.0,
                        ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.item.category,
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Figtree',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
