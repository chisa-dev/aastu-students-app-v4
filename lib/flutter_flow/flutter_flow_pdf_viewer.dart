import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FlutterFlowPdfViewer extends StatefulWidget {
  const FlutterFlowPdfViewer({
    super.key,
    this.networkPath,
    this.assetPath,
    this.fileBytes,
    this.width,
    this.height,
    this.horizontalScroll = false,
  }) : assert(
            (networkPath != null) ^ (assetPath != null) ^ (fileBytes != null));

  final String? networkPath;
  final String? assetPath;
  final Uint8List? fileBytes;
  final double? width;
  final double? height;
  final bool horizontalScroll;

  @override
  State<FlutterFlowPdfViewer> createState() => _FlutterFlowPdfViewerState();
}

class _FlutterFlowPdfViewerState extends State<FlutterFlowPdfViewer> {
  PdfController? controller;
  bool _isLoading = true;
  String get networkPath => widget.networkPath ?? '';
  String get assetPath => widget.assetPath ?? '';
  Uint8List get fileBytes => widget.fileBytes ?? Uint8List.fromList([]);

  Future<void> _initializeController() async {
    safeSetState(() => _isLoading = true);
    final pdfDocument =
        networkPath.isNotEmpty || assetPath.isNotEmpty || fileBytes.isNotEmpty
            ? assetPath.isNotEmpty
                ? await PdfDocument.openAsset(assetPath)
                : networkPath.isNotEmpty
                    ? await PdfDocument.openData(InternetFile.get(networkPath))
                    : await PdfDocument.openData(Uint8List.fromList(fileBytes))
            : null;
    controller = pdfDocument != null
        ? PdfController(document: Future.value(pdfDocument))
        : null;
    safeSetState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(FlutterFlowPdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.networkPath != widget.networkPath ||
        oldWidget.fileBytes != widget.fileBytes) {
      _initializeController();
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : controller != null
                ? PdfView(
                    controller: controller!,
                    scrollDirection: widget.horizontalScroll
                        ? Axis.horizontal
                        : Axis.vertical,
                    builders: PdfViewBuilders<DefaultBuilderOptions>(
                      options: const DefaultBuilderOptions(),
                      documentLoaderBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      pageLoaderBuilder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      errorBuilder: (_, __) => Container(),
                    ),
                  )
                : const SizedBox(),
      );
}
