import '/components/bottom_navbar_basic1/bottom_navbar_basic1_widget.dart';
import '/components/floating_button_basic1/floating_button_basic1_widget.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_bar1_model.dart';
export 'bottom_nav_bar1_model.dart';

class BottomNavBar1Widget extends StatefulWidget {
  const BottomNavBar1Widget({super.key});

  @override
  State<BottomNavBar1Widget> createState() => _BottomNavBar1WidgetState();
}

class _BottomNavBar1WidgetState extends State<BottomNavBar1Widget> {
  late BottomNavBar1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavBar1Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 1.0),
          child: wrapWithModel(
            model: _model.bottomNavbarBasic1Model,
            updateCallback: () => safeSetState(() {}),
            child: const BottomNavbarBasic1Widget(),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 1.0),
          child: wrapWithModel(
            model: _model.floatingButtonBasic1Model,
            updateCallback: () => safeSetState(() {}),
            child: const FloatingButtonBasic1Widget(),
          ),
        ),
      ],
    );
  }
}
