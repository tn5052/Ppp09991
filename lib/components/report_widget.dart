import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'report_model.dart';
export 'report_model.dart';

class ReportWidget extends StatefulWidget {
  /// component to report something to admin
  const ReportWidget({
    super.key,
    this.userID,
    this.eventID,
    String? type,
  }) : type = type ?? 'user';

  final DocumentReference? userID;
  final DocumentReference? eventID;
  final String type;

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  late ReportModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Container(
            width: 300.0,
            height: 240.0,
            decoration: BoxDecoration(
              color: MyFlutterTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report to Admin',
                        style: MyFlutterTheme.of(context).titleMedium.override(
                              fontFamily: 'Noto Serif',
                              color: MyFlutterTheme.of(context).error,
                              letterSpacing: 0.0,
                            ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: MyFlutterTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2.0,
                    color: MyFlutterTheme.of(context).alternate,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 7.0, 0.0, 0.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Reason',
                          labelStyle:
                              MyFlutterTheme.of(context).labelMedium.override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'used inappropriate profile picture!',
                          hintStyle:
                              MyFlutterTheme.of(context).labelMedium.override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyFlutterTheme.of(context).secondaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyFlutterTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyFlutterTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyFlutterTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        style: MyFlutterTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Serif',
                              letterSpacing: 0.0,
                            ),
                        maxLines: 3,
                        maxLength: 90,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            null,
                        cursorColor: MyFlutterTheme.of(context).primaryText,
                        validator:
                            _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 7.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            unselectedWidgetColor:
                                MyFlutterTheme.of(context).alternate,
                          ),
                          child: Checkbox(
                            value: _model.checkboxValue ??= false,
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.checkboxValue = newValue!);
                            },
                            side: BorderSide(
                              width: 2,
                              color: MyFlutterTheme.of(context).alternate,
                            ),
                            activeColor: MyFlutterTheme.of(context).tertiary,
                            checkColor: MyFlutterTheme.of(context).info,
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'If you want to report a REVIEW report \nthe place, where its been commented!',
                              maxLines: 3,
                              style: MyFlutterTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 7.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await ReportsRecord.collection
                              .doc()
                              .set(createReportsRecordData(
                                reportedBy: currentUserReference,
                                reportID: '',
                                typeReported: valueOrDefault<String>(
                                  _model.checkboxValue!
                                      ? '${widget.type}_review'
                                      : widget.type,
                                  'review',
                                ),
                                userReported: widget.userID,
                                dateTime: getCurrentTimestamp,
                                reason: _model.textController.text,
                                eventReported: widget.eventID,
                              ));
                          Navigator.pop(context);
                        },
                        text: 'send',
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: MyFlutterTheme.of(context).error,
                          textStyle:
                              MyFlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Noto Serif',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
