import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'comment_shimmer_model.dart';
export 'comment_shimmer_model.dart';

class CommentShimmerWidget extends StatefulWidget {
  const CommentShimmerWidget({
    super.key,
    this.itemCount = 3,
  });

  final int itemCount;

  @override
  State<CommentShimmerWidget> createState() => _CommentShimmerWidgetState();
}

class _CommentShimmerWidgetState extends State<CommentShimmerWidget> {
  late CommentShimmerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentShimmerModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.itemCount, (index) {
          return Container(
            height: 50.0,
            padding:
                const EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
            child: Row(
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 200.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
