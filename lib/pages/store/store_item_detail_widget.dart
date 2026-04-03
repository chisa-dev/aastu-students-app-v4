import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'store_item_detail_model.dart';
export 'store_item_detail_model.dart';

class StoreItemDetailWidget extends StatefulWidget {
  const StoreItemDetailWidget({
    super.key,
    this.item,
  });

  final StoreItemsRecord? item;

  @override
  State<StoreItemDetailWidget> createState() => _StoreItemDetailWidgetState();
}

class _StoreItemDetailWidgetState extends State<StoreItemDetailWidget> {
  late StoreItemDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreItemDetailModel());

    _model.pageController = PageController();
    _model.reviewTextController ??= TextEditingController();
    _model.reviewFocusNode ??= FocusNode();

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
      title: 'Store Item Detail',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: true,
          title: Text(
            widget.item?.title ?? 'Item Detail',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel
              _buildImageCarousel(context),
              // Info Section
              _buildInfoSection(context),
              // Seller Info
              _buildSellerInfo(context),
              // Contact Buttons
              _buildContactButtons(context),
              // Reviews Section
              _buildReviewsSection(context),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel(BuildContext context) {
    final images = widget.item?.images ?? [];
    if (images.isEmpty) {
      return Container(
        width: double.infinity,
        height: 300.0,
        color: FlutterFlowTheme.of(context).alternate,
        child: Center(
          child: Icon(
            Icons.storefront,
            size: 64.0,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300.0,
          child: PageView.builder(
            controller: _model.pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              safeSetState(() {
                _model.currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300.0,
                errorWidget: (context, url, error) => Container(
                  color: FlutterFlowTheme.of(context).alternate,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 48.0,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (images.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _model.currentImageIndex == index
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).alternate,
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item?.title ?? '',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.item?.hasPrice() == true && widget.item!.price > 0
                ? 'ETB ${widget.item!.price.toStringAsFixed(2)}'
                : 'Free / Negotiable',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 16.0),
          Text(
            widget.item?.description ?? '',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 16.0),
          if (widget.item?.hasCategory() == true &&
              widget.item!.category.isNotEmpty)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
              child: Text(
                widget.item!.category,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Readex Pro',
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSellerInfo(BuildContext context) {
    if (widget.item?.seller == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FutureBuilder<UsersRecord>(
        future: UsersRecord.getDocumentOnce(widget.item!.seller!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          width: 80.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) return const SizedBox.shrink();

          final seller = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: FlutterFlowTheme.of(context).alternate,
                  backgroundImage: seller.photoUrl.isNotEmpty
                      ? CachedNetworkImageProvider(seller.photoUrl)
                      : null,
                  child: seller.photoUrl.isEmpty
                      ? Icon(
                          Icons.person,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        )
                      : null,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        seller.displayName,
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                      ),
                      if (seller.department.isNotEmpty)
                        Text(
                          seller.department,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactButtons(BuildContext context) {
    final hasPhone = widget.item?.phoneNumber.isNotEmpty == true;
    final hasTelegram = widget.item?.telegramLink.isNotEmpty == true;

    if (!hasPhone && !hasTelegram) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (hasPhone)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await launchUrl(
                      Uri.parse('tel:${widget.item!.phoneNumber}'));
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          if (hasPhone && hasTelegram) const SizedBox(width: 12.0),
          if (hasTelegram)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await launchUrl(
                      Uri.parse(widget.item!.telegramLink));
                },
                icon: const Icon(Icons.send),
                label: const Text('Telegram'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
              ),
              TextButton(
                onPressed: () => _showReviewBottomSheet(context),
                child: Text(
                  'Write Review',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<List<StoreReviewsRecord>>(
          stream: queryStoreReviewsRecord(
            queryBuilder: (q) => q
                .where('item', isEqualTo: widget.item!.reference)
                .orderBy('created_at', descending: true),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final reviews = snapshot.data ?? [];

            if (reviews.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Text(
                    'No reviews yet. Be the first to review!',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(context, review);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context, StoreReviewsRecord review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: FutureBuilder<UsersRecord>(
        future: review.user != null
            ? UsersRecord.getDocumentOnce(review.user!)
            : null,
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16.0,
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      backgroundImage:
                          user != null && user.photoUrl.isNotEmpty
                              ? CachedNetworkImageProvider(user.photoUrl)
                              : null,
                      child: user == null || user.photoUrl.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 16.0,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryText,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'User',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          if (review.hasCreatedAt())
                            Text(
                              dateTimeFormat(
                                  'relative', review.createdAt!),
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (i) {
                        return Icon(
                          i < review.rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          size: 16.0,
                          color: Colors.amber,
                        );
                      }),
                    ),
                  ],
                ),
                if (review.comment.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      review.comment,
                      style:
                          FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showReviewBottomSheet(BuildContext context) {
    _model.reviewRating = 5.0;
    _model.reviewTextController?.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Form(
                key: _model.reviewFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write a Review',
                      style:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setModalState(() {
                              _model.reviewRating = (index + 1).toDouble();
                            });
                          },
                          icon: Icon(
                            index < _model.reviewRating.round()
                                ? Icons.star
                                : Icons.star_border,
                            size: 36.0,
                            color: Colors.amber,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _model.reviewTextController,
                      focusNode: _model.reviewFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      maxLines: 4,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please write a comment';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!_model.reviewFormKey.currentState!
                              .validate()) {
                            return;
                          }

                          final ref = StoreReviewsRecord.collection.doc();
                          await ref.set(createStoreReviewsRecordData(
                            item: widget.item!.reference,
                            user: currentUserReference,
                            rating: _model.reviewRating,
                            comment:
                                _model.reviewTextController!.text,
                            createdAt: getCurrentTimestamp,
                          ));

                          _model.reviewTextController?.clear();
                          _model.reviewRating = 5.0;

                          if (context.mounted) {
                            Navigator.of(bottomSheetContext).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding:
                              const EdgeInsets.symmetric(vertical: 14.0),
                        ),
                        child: const Text('Submit Review'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
