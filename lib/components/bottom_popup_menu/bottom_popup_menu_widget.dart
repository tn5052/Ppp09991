import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'bottom_popup_menu_model.dart';
export 'bottom_popup_menu_model.dart';

class BottomPopupMenuWidget extends StatefulWidget {
  const BottomPopupMenuWidget({super.key});

  @override
  State<BottomPopupMenuWidget> createState() => _BottomPopupMenuWidgetState();
}

class _BottomPopupMenuWidgetState extends State<BottomPopupMenuWidget> {
  late BottomPopupMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomPopupMenuModel());

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
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(-0.01, -0.02),
              child: Container(
                width: 170.0,
                height: 130.0,
                decoration: BoxDecoration(
                  color: MyFlutterTheme.of(context).secondaryText,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.01, 0.13),
              child: Transform.rotate(
                angle: 45.0 * (math.pi / 180),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: MyFlutterTheme.of(context).secondaryText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
