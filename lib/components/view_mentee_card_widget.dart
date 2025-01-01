import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'view_mentee_card_model.dart';
export 'view_mentee_card_model.dart';

class ViewMenteeCardWidget extends StatefulWidget {
  const ViewMenteeCardWidget({super.key});

  @override
  State<ViewMenteeCardWidget> createState() => _ViewMenteeCardWidgetState();
}

class _ViewMenteeCardWidgetState extends State<ViewMenteeCardWidget> {
  late ViewMenteeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewMenteeCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: const BoxDecoration(
        color: Color(0x50383838),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 230.0,
            height: 130.0,
            decoration: BoxDecoration(
              color: MyFlutterTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.cancel,
                        color: Colors.transparent,
                        size: 24.0,
                      ),
                      Text(
                        'Hello World',
                        style: MyFlutterTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Serif',
                              letterSpacing: 0.0,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 6.0),
                        child: Icon(
                          Icons.cancel,
                          color: MyFlutterTheme.of(context).error,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                  child: Divider(
                    height: 10.0,
                    thickness: 2.0,
                    color: Color(0x8057636C),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 70.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Hello World',
                              style: MyFlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'View Profilee',
                              options: FFButtonOptions(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFFAFAFAF),
                                textStyle: MyFlutterTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
