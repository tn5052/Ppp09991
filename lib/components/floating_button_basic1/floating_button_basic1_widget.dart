import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'floating_button_basic1_model.dart';
export 'floating_button_basic1_model.dart';

class FloatingButtonBasic1Widget extends StatefulWidget {
  const FloatingButtonBasic1Widget({super.key});

  @override
  State<FloatingButtonBasic1Widget> createState() =>
      _FloatingButtonBasic1WidgetState();
}

class _FloatingButtonBasic1WidgetState
    extends State<FloatingButtonBasic1Widget> {
  late FloatingButtonBasic1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FloatingButtonBasic1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyFlutterTheme.of(context).primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: MyFlutterTheme.of(context).secondaryBackground,
                size: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
