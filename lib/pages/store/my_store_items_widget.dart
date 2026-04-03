import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'my_store_items_model.dart';
export 'my_store_items_model.dart';

class MyStoreItemsWidget extends StatefulWidget {
  const MyStoreItemsWidget({super.key});

  @override
  State<MyStoreItemsWidget> createState() => _MyStoreItemsWidgetState();
}

class _MyStoreItemsWidgetState extends State<MyStoreItemsWidget> {
  late MyStoreItemsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyStoreItemsModel());

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
      title: 'My Items',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          title: Text(
            'My Items',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
          ),
          elevation: 0.0,
        ),
        body: StreamBuilder<List<StoreItemsRecord>>(
          stream: queryStoreItemsRecord(
            queryBuilder: (q) => q
                .where('seller', isEqualTo: currentUserReference)
                .orderBy('created_at', descending: true),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = snapshot.data ?? [];

            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.storefront_outlined,
                      size: 64.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'You haven\'t posted any items yet',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        context.pushNamed('StoreItemUpload');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                      ),
                      child: const Text('Post Your First Item'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(0.0),
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(
                height: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildItemCard(context, item);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, StoreItemsRecord item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Leading image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: item.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: item.images.first,
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      width: 60.0,
                      height: 60.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      child: Icon(
                        Icons.image_not_supported,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  )
                : Container(
                    width: 60.0,
                    height: 60.0,
                    color: FlutterFlowTheme.of(context).alternate,
                    child: Icon(
                      Icons.storefront,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
          ),
          const SizedBox(width: 12.0),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Readex Pro',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${item.hasPrice() && item.price > 0 ? 'ETB ${item.price.toStringAsFixed(2)}' : 'Free'}${item.hasCreatedAt() ? ' \u00b7 ${dateTimeFormat('relative', item.createdAt!)}' : ''}',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          // Status badge
          _buildStatusBadge(context, item.status),
          // Delete button
          IconButton(
            onPressed: () => _showDeleteConfirmation(context, item),
            icon: Icon(
              Icons.delete_outline,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status.toLowerCase()) {
      case 'approved':
        backgroundColor = Colors.green.withValues(alpha: 0.15);
        textColor = Colors.green;
        label = 'Approved';
        break;
      case 'rejected':
        backgroundColor = Colors.red.withValues(alpha: 0.15);
        textColor = Colors.red;
        label = 'Rejected';
        break;
      case 'pending':
      default:
        backgroundColor = Colors.amber.withValues(alpha: 0.15);
        textColor = Colors.amber.shade800;
        label = 'Pending';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: FlutterFlowTheme.of(context).labelSmall.override(
              fontFamily: 'Readex Pro',
              color: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.0,
            ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, StoreItemsRecord item) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content:
              const Text('Are you sure you want to delete this item?'),
          backgroundColor:
              FlutterFlowTheme.of(context).secondaryBackground,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await item.reference.delete();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
