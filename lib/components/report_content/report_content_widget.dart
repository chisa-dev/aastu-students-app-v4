import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

/// Shows a report bottom sheet for posts or stories.
/// [contentRef] is the DocumentReference to the post/story being reported.
/// [contentType] is 'post' or 'story'.
Future<bool?> showReportContentSheet(
  BuildContext context, {
  required DocumentReference contentRef,
  required String contentType,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ReportContentWidget(
      contentRef: contentRef,
      contentType: contentType,
    ),
  );
}

class ReportContentWidget extends StatefulWidget {
  const ReportContentWidget({
    super.key,
    required this.contentRef,
    required this.contentType,
  });

  final DocumentReference contentRef;
  final String contentType;

  @override
  State<ReportContentWidget> createState() => _ReportContentWidgetState();
}

class _ReportContentWidgetState extends State<ReportContentWidget> {
  String? _selectedReason;
  bool _isSubmitting = false;
  bool _submitted = false;

  static const _reportReasons = [
    'Inappropriate or offensive content',
    'Spam or misleading',
    'Harassment or bullying',
    'Hate speech or discrimination',
    'Violence or dangerous content',
    'Copyright violation',
    'Other',
  ];

  Future<void> _submitReport() async {
    if (_selectedReason == null || currentUserReference == null) return;

    setState(() => _isSubmitting = true);

    try {
      // Add reporter to the reporters array and mark as reported
      await widget.contentRef.update({
        'isReported': true,
        'reporters': FieldValue.arrayUnion([currentUserReference]),
        'reportReasons': FieldValue.arrayUnion([
          {
            'userId': currentUserReference,
            'reason': _selectedReason,
            'timestamp': FieldValue.serverTimestamp(),
          }
        ]),
      });

      setState(() {
        _isSubmitting = false;
        _submitted = true;
      });

      // Auto-dismiss after showing success
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit report. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.0,
              height: 4.0,
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            if (_submitted)
              _buildSuccessView()
            else
              _buildReportForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: FlutterFlowTheme.of(context).primary,
          size: 56.0,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Report Submitted',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Outfit',
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Thank you for helping keep our community safe. We\'ll review this ${widget.contentType} within 24 hours.',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildReportForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.flag_rounded,
              color: FlutterFlowTheme.of(context).error,
              size: 24.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Report ${widget.contentType == 'post' ? 'Post' : 'Story'}',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Outfit',
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Why are you reporting this content?',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Figtree',
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
        ),
        const SizedBox(height: 16.0),
        ...(_reportReasons.map((reason) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () => setState(() => _selectedReason = reason),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedReason == reason
                        ? FlutterFlowTheme.of(context).accent1
                        : FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: _selectedReason == reason
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).alternate,
                      width: _selectedReason == reason ? 2.0 : 1.0,
                    ),
                  ),
                  child: Text(
                    reason,
                    style:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Figtree',
                              color: _selectedReason == reason
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                  ),
                ),
              ),
            ))),
        const SizedBox(height: 16.0),
        FFButtonWidget(
          onPressed:
              (_selectedReason != null && !_isSubmitting) ? _submitReport : null,
          text: _isSubmitting ? 'Submitting...' : 'Submit Report',
          options: FFButtonOptions(
            width: double.infinity,
            height: 50.0,
            color: FlutterFlowTheme.of(context).error,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'Figtree',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
            elevation: 0.0,
            disabledColor: FlutterFlowTheme.of(context).alternate,
            disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ],
    );
  }
}
