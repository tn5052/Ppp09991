import '/auth/firebase_auth/auth_util.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'phone_signin_code_model.dart';
export 'phone_signin_code_model.dart';

class PhoneSigninCodeWidget extends StatefulWidget {
  const PhoneSigninCodeWidget({
    super.key,
    String? phoneNumberSignin,
  }) : phoneNumberSignin = phoneNumberSignin ?? '0000';

  final String phoneNumberSignin;

  @override
  State<PhoneSigninCodeWidget> createState() => _PhoneSigninCodeWidgetState();
}

class _PhoneSigninCodeWidgetState extends State<PhoneSigninCodeWidget>
    with TickerProviderStateMixin {
  late PhoneSigninCodeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhoneSigninCodeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      GoRouter.of(context).prepareAuthEvent();
      final smsCodeVal = _model.pinCodeController!.text;
      if (smsCodeVal.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter SMS verification code.'),
          ),
        );
        return;
      }
      final phoneVerifiedUser = await authManager.verifySmsCode(
        context: context,
        smsCode: smsCodeVal,
      );
      if (phoneVerifiedUser == null) {
        return;
      }

      context.goNamedAuth('home', context.mounted);
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.0, 140.0),
            end: const Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: const Offset(-0.349, 0),
            end: const Offset(0, 0),
          ),
        ],
      ),
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyFlutterTheme.of(context).primaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyFlutterTheme.of(context).primaryBackground,
                      MyFlutterTheme.of(context).alternate,
                      MyFlutterTheme.of(context).primary
                    ],
                    stops: const [0.2, 0.3, 0.9],
                    begin: const AlignmentDirectional(0.87, -1.0),
                    end: const AlignmentDirectional(-0.87, 1.0),
                  ),
                ),
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.safePop();
                            },
                            text: 'Back',
                            icon: const Icon(
                              Icons.keyboard_backspace_outlined,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: const Color(0x005669FF),
                              textStyle: MyFlutterTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color:
                                        MyFlutterTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 32.0),
                        child: Container(
                          width: 200.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/linker.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 570.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                MyFlutterTheme.of(context).secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 20.0),
                                    child: Text(
                                      'PinCode',
                                      style: MyFlutterTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 20.0),
                                    child: AutoSizeText(
                                      'Enter Pin Code send to  ${widget.phoneNumberSignin}',
                                      style: MyFlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                                PinCodeTextField(
                                  autoDisposeControllers: false,
                                  appContext: context,
                                  length: 6,
                                  textStyle: MyFlutterTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  enableActiveFill: false,
                                  autoFocus: true,
                                  enablePinAutofill: false,
                                  errorTextSpace: 16.0,
                                  showCursor: true,
                                  cursorColor:
                                      MyFlutterTheme.of(context).primary,
                                  obscureText: false,
                                  hintCharacter: '●',
                                  keyboardType: TextInputType.number,
                                  pinTheme: PinTheme(
                                    fieldHeight: 44.0,
                                    fieldWidth: 44.0,
                                    borderWidth: 2.0,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                    shape: PinCodeFieldShape.box,
                                    activeColor:
                                        MyFlutterTheme.of(context).primaryText,
                                    inactiveColor:
                                        MyFlutterTheme.of(context).alternate,
                                    selectedColor:
                                        MyFlutterTheme.of(context).primary,
                                  ),
                                  controller: _model.pinCodeController,
                                  onChanged: (_) {},
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: _model.pinCodeControllerValidator
                                      .asValidator(context),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 20.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        GoRouter.of(context).prepareAuthEvent();
                                        final smsCodeVal =
                                            _model.pinCodeController!.text;
                                        if (smsCodeVal.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Enter SMS verification code.'),
                                            ),
                                          );
                                          return;
                                        }
                                        final phoneVerifiedUser =
                                            await authManager.verifySmsCode(
                                          context: context,
                                          smsCode: smsCodeVal,
                                        );
                                        if (phoneVerifiedUser == null) {
                                          return;
                                        }

                                        context.goNamedAuth(
                                            'home', context.mounted);
                                      },
                                      text: 'Confirm',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(100.0, 0.0, 100.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color:
                                            MyFlutterTheme.of(context).primary,
                                        textStyle: MyFlutterTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!),
                      ),
                    ],
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
