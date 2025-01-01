import '/auth/firebase_auth/auth_util.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ban_page_model.dart';
export 'ban_page_model.dart';

class BanPageWidget extends StatefulWidget {
  /// when user gets banned
  const BanPageWidget({super.key});

  @override
  State<BanPageWidget> createState() => _BanPageWidgetState();
}

class _BanPageWidgetState extends State<BanPageWidget> {
  late BanPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BanPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault(currentUserDocument?.status, '') != 'ban') {
        context.goNamed(
          'home',
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: MyFlutterTheme.of(context).primaryBackground,
          body: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: MyFlutterTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.ban,
                    color: MyFlutterTheme.of(context).error,
                    size: 90.0,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Text(
                    'Your Profile has been banned!\n\nContact Support for more details.',
                    textAlign: TextAlign.center,
                    style: MyFlutterTheme.of(context).headlineSmall.override(
                          fontFamily: 'Noto Serif',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await Clipboard.setData(const ClipboardData(
                          text: 'Jaaneabubakar1@gmail.com'));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Email Coppied',
                            style: TextStyle(
                              color: MyFlutterTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          duration: const Duration(milliseconds: 4000),
                          backgroundColor: MyFlutterTheme.of(context).primary,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_email,
                          color: MyFlutterTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Jaaneabubakar1@gmail.com',
                            style:
                                MyFlutterTheme.of(context).titleMedium.override(
                                      fontFamily: 'Noto Serif',
                                      color: MyFlutterTheme.of(context).primary,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();

                      context.goNamedAuth('onBoarding', context.mounted);
                    },
                    text: 'Logout',
                    options: FFButtonOptions(
                      height: 30.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: const Color(0x005669FF),
                      textStyle: MyFlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Serif',
                            color: MyFlutterTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: MyFlutterTheme.of(context).secondaryText,
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
