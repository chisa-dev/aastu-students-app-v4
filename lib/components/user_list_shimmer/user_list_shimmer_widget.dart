import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'user_list_shimmer_model.dart';
export 'user_list_shimmer_model.dart';

class UserListShimmerWidget extends StatefulWidget {
  const UserListShimmerWidget({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  State<UserListShimmerWidget> createState() => _UserListShimmerWidgetState();
}

class _UserListShimmerWidgetState extends State<UserListShimmerWidget> {
  late UserListShimmerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListShimmerModel());

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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 65.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 8.0, 12.0, 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 44.0,
                      height: 44.0,
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
                          width: 120.0,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: 80.0,
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
              ),
              if (index < widget.itemCount - 1)
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Colors.grey[200],
                ),
            ],
          );
        }),
      ),
    );
  }
}
