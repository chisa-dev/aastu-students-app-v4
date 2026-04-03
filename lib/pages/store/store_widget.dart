import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/store_item_card/store_item_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/account_gate_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'store_model.dart';
export 'store_model.dart';

class StoreWidget extends StatefulWidget {
  const StoreWidget({super.key});

  @override
  State<StoreWidget> createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  late StoreModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _navigateToUploadOrActivate() async {
    final canProceed = await requireAccount(context, featureName: 'sell an item');
    if (!canProceed || !mounted) return;
    context.pushNamed('StoreItemUpload');
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Store',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: Visibility(
          visible: MediaQuery.sizeOf(context).width <= 990.0,
          child: FloatingActionButton(
            onPressed: _navigateToUploadOrActivate,
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ),
        appBar: responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor:
                    FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                title: Text(
                  'Store',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                actions: [
                  StreamBuilder<List<StoreItemsRecord>>(
                    stream: queryStoreItemsRecord(
                      queryBuilder: (q) => q
                          .where('seller', isEqualTo: currentUserReference)
                          .where('status', isEqualTo: 'pending'),
                    ),
                    builder: (context, snapshot) {
                      final pendingCount = snapshot.data?.length ?? 0;
                      return IconButton(
                        icon: Badge(
                          isLabelVisible: pendingCount > 0,
                          label: Text(
                            '$pendingCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.inventory_2_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                        onPressed: () {
                          context.pushNamed('MyStoreItems');
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: _navigateToUploadOrActivate,
                  ),
                ],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1 - Category Filter
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: FutureBuilder<List<StoreCategoriesRecord>>(
                    future: queryStoreCategoriesRecordOnce(
                      queryBuilder: (q) => q.orderBy('order'),
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: 40.0,
                          child: Center(
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      final categories = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 0.0),
                              child: ChoiceChip(
                                label: Text('All'),
                                selected: _selectedCategory == null,
                                onSelected: (selected) {
                                  safeSetState(() {
                                    _selectedCategory = null;
                                  });
                                },
                                selectedColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: _selectedCategory == null
                                          ? Colors.white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            ...categories.map(
                              (category) => Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                child: ChoiceChip(
                                  label: Text(category.name),
                                  selected:
                                      _selectedCategory == category.name,
                                  onSelected: (selected) {
                                    safeSetState(() {
                                      _selectedCategory =
                                          selected ? category.name : null;
                                    });
                                  },
                                  selectedColor:
                                      FlutterFlowTheme.of(context).primary,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: _selectedCategory ==
                                                category.name
                                            ? Colors.white
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Section 2 - Recently Added
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recently Added',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: SizedBox(
                    height: 240.0,
                    child: StreamBuilder<List<StoreItemsRecord>>(
                      stream: queryStoreItemsRecord(
                        queryBuilder: (q) => q
                            .where('status', isEqualTo: 'approved')
                            .orderBy('created_at', descending: true),
                        limit: 10,
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return _buildHorizontalShimmer();
                        }
                        final recentItems = snapshot.data!;
                        if (recentItems.isEmpty) {
                          return Center(
                            child: Text(
                              'No items yet',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: recentItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 12.0, 0.0),
                              child: SizedBox(
                                width: 180.0,
                                child: StoreItemCardWidget(
                                  item: recentItems[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Section 3 - All Items Grid
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        _selectedCategory != null
                            ? 'Browse $_selectedCategory'
                            : 'Browse Items',
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 24.0),
                  child: StreamBuilder<List<StoreItemsRecord>>(
                    stream: queryStoreItemsRecord(
                      queryBuilder: (q) {
                        var query = q
                            .where('status', isEqualTo: 'approved')
                            .orderBy('created_at', descending: true);
                        if (_selectedCategory != null) {
                          query = q
                              .where('status', isEqualTo: 'approved')
                              .where('category',
                                  isEqualTo: _selectedCategory)
                              .orderBy('created_at', descending: true);
                        }
                        return query;
                      },
                      limit: 50,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return _buildGridShimmer();
                      }
                      final allItems = snapshot.data!;
                      if (allItems.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 40.0, 0.0, 40.0),
                            child: Text(
                              'No items found',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        );
                      }
                      return _buildMixedLayout(allItems);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a mixed layout: mostly 2-column grid with an occasional
  /// full-width featured card every 5th item for visual variety.
  Widget _buildMixedLayout(List<StoreItemsRecord> items) {
    final List<Widget> rows = [];
    int i = 0;
    int itemsSinceLastFull = 0;

    while (i < items.length) {
      // Show a full-width card at position 0, then every ~5 items
      if (itemsSinceLastFull >= 4 || (i == 0 && items.length > 3)) {
        rows.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
            child: StoreItemCardWidget(item: items[i]),
          ),
        );
        i++;
        itemsSinceLastFull = 0;
      } else {
        // Two-column row
        final first = items[i];
        final second = (i + 1 < items.length) ? items[i + 1] : null;
        rows.add(
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: StoreItemCardWidget(item: first),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: second != null
                        ? StoreItemCardWidget(item: second)
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
        i += 2;
        itemsSinceLastFull += 2;
      }
    }

    return Column(
      children: rows,
    );
  }

  Widget _buildHorizontalShimmer() {
    return ListView.builder(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
          child: Shimmer.fromColors(
            baseColor: FlutterFlowTheme.of(context).primaryBackground,
            highlightColor:
                FlutterFlowTheme.of(context).secondaryBackground,
            child: Container(
              width: 180.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridShimmer() {
    return Column(
      children: [
        // Full-width shimmer
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Shimmer.fromColors(
            baseColor: FlutterFlowTheme.of(context).primaryBackground,
            highlightColor: FlutterFlowTheme.of(context).secondaryBackground,
            child: Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        // Two-column shimmer
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: FlutterFlowTheme.of(context).primaryBackground,
                  highlightColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  child: Container(
                    height: 190.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: FlutterFlowTheme.of(context).primaryBackground,
                  highlightColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  child: Container(
                    height: 190.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
