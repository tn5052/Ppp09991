import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'attendee_card_model.dart';
export 'attendee_card_model.dart';

class AttendeeCardWidget extends StatefulWidget {
  /// this card will be shown on attendee event ticket scan.
  const AttendeeCardWidget({super.key});

  @override
  State<AttendeeCardWidget> createState() => _AttendeeCardWidgetState();
}

class _AttendeeCardWidgetState extends State<AttendeeCardWidget> {
  late AttendeeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendeeCardModel());

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
        width: 240.0,
        height: 350.0,
        decoration: BoxDecoration(
          color: MyFlutterTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.cancel,
                    color: Colors.transparent,
                    size: 24.0,
                  ),
                  Text(
                    'Ticket Scan Result',
                    style: MyFlutterTheme.of(context).labelLarge.override(
                          fontFamily: 'Noto Serif',
                          color: MyFlutterTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 6.0),
                    child: Icon(
                      Icons.cancel,
                      color: MyFlutterTheme.of(context).error,
                      size: 32.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 150.0,
                child: Divider(
                  height: 10.0,
                  thickness: 2.0,
                  color: Color(0x8057636C),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Row(
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
                      height: 64.0,
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
                                color: const Color(0x7FAFAFAF),
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
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 12.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: MyFlutterTheme.of(context).success,
                            size: 60.0,
                          ),
                          Icon(
                            Icons.cancel_outlined,
                            color: MyFlutterTheme.of(context).error,
                            size: 60.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Invalid ',
                        style:
                            MyFlutterTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Noto Serif',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Valid ',
                        style:
                            MyFlutterTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Noto Serif',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Ticket',
                        style:
                            MyFlutterTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Noto Serif',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          4.0, 16.0, 0.0, 0.0),
                      child: Text(
                        'Check-in at: ',
                        style: MyFlutterTheme.of(context).labelLarge.override(
                              fontFamily: 'Noto Serif',
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  Text(
                    '12:30 pm, 10 Nov 2024',
                    style: MyFlutterTheme.of(context).bodyMedium.override(
                          fontFamily: 'Noto Serif',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 16.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.run_circle_sharp,
                          color: MyFlutterTheme.of(context).primary,
                          size: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              6.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Already Check-in',
                            style: MyFlutterTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Noto Serif',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
