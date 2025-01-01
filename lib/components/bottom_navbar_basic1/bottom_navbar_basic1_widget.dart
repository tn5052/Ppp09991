import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'bottom_navbar_basic1_model.dart';
export 'bottom_navbar_basic1_model.dart';

class BottomNavbarBasic1Widget extends StatefulWidget {
  const BottomNavbarBasic1Widget({super.key});

  @override
  State<BottomNavbarBasic1Widget> createState() =>
      _BottomNavbarBasic1WidgetState();
}

class _BottomNavbarBasic1WidgetState extends State<BottomNavbarBasic1Widget> {
  late BottomNavbarBasic1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavbarBasic1Model());

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
      child: Container(
        width: double.infinity,
        height: 80.0,
        decoration: BoxDecoration(
          color: MyFlutterTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.play_circle,
                      color: Color(0xAB545353),
                      size: 30.0,
                    ),
                    Text(
                      '   Feed   ',
                      style: MyFlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Serif',
                            color: const Color(0xAB545353),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.explore,
                      color: Color(0xAB545353),
                      size: 30.0,
                    ),
                    Text(
                      'Explore',
                      style: MyFlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Serif',
                            color: const Color(0xAB545353),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: const BoxDecoration(),
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      color: Color(0x00545353),
                      size: 30.0,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.memory_outlined,
                      color: Color(0xAB545353),
                      size: 30.0,
                    ),
                    AutoSizeText(
                      'Comunity',
                      style: MyFlutterTheme.of(context).bodySmall.override(
                            fontFamily: 'Noto Serif',
                            color: const Color(0xAB545353),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.15,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(
                      Icons.catching_pokemon,
                      color: Color(0xAB545353),
                      size: 30.0,
                    ),
                    Text(
                      'Booking',
                      style: MyFlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Serif',
                            color: const Color(0xAB545353),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
