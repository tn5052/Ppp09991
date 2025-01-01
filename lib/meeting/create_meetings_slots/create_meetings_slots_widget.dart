import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'create_meetings_slots_model.dart';
export 'create_meetings_slots_model.dart';

class CreateMeetingsSlotsWidget extends StatefulWidget {
  const CreateMeetingsSlotsWidget({super.key});

  @override
  State<CreateMeetingsSlotsWidget> createState() =>
      _CreateMeetingsSlotsWidgetState();
}

class _CreateMeetingsSlotsWidgetState extends State<CreateMeetingsSlotsWidget>
    with TickerProviderStateMixin {
  late CreateMeetingsSlotsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateMeetingsSlotsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timeStartLocal = getCurrentTimestamp;
      _model.timeEndLocal = getCurrentTimestamp;
      _model.liveSlotsEdit = false;
      _model.addMeetSlots = false;
      _model.viewMeetSlots = false;
      _model.dateLocal = getCurrentTimestamp;
      _model.eTimeStartLocal = getCurrentTimestamp;
      _model.eTimeEndLocal = getCurrentTimestamp;
      _model.eDateLocal = getCurrentTimestamp;
      _model.isMenteeCardVisible = false;
      safeSetState(() {});
    });

    _model.tFPriceMeetingSlotTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      valueOrDefault(currentUserDocument?.priceMeetingSlot, 0.0) > 0.0
          ? valueOrDefault<String>(
              formatNumber(
                valueOrDefault(currentUserDocument?.priceMeetingSlot, 0.0),
                formatType: FormatType.compact,
              ),
              'Free',
            )
          : 'Free',
      'Free',
    ));
    _model.tFPriceMeetingSlotFocusNode ??= FocusNode();

    animationsMap.addAll({
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 10.0),
            end: const Offset(0.0, 0.0),
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
        backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 70.0, 12.0, 16.0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 8.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Text(
                                'Slots Live for Booking Meet\'s.',
                                style: MyFlutterTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (valueOrDefault<bool>(
                                  _model.liveSlotsEdit == true,
                                  false,
                                ))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.liveSlotsEdit = false;
                                      safeSetState(() {});
                                    },
                                    text: 'Cancel',
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: MyFlutterTheme.of(context)
                                          .secondaryText,
                                      size: 16.0,
                                    ),
                                    options: FFButtonOptions(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8.0, 0.0, 8.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: const Color(0x71CBCBCB),
                                      textStyle: MyFlutterTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                                if (valueOrDefault<bool>(
                                  _model.liveSlotsEdit == false,
                                  true,
                                ))
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.liveSlotsEdit = true;
                                      safeSetState(() {});
                                    },
                                    text: 'Edit',
                                    icon: const Icon(
                                      Icons.mode_edit,
                                      size: 16.0,
                                    ),
                                    options: FFButtonOptions(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8.0, 0.0, 8.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: const Color(0xFFEAEBFB),
                                      textStyle: MyFlutterTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: StreamBuilder<List<MentorMeetingSlotsRecord>>(
                            stream: queryMentorMeetingSlotsRecord(
                              queryBuilder: (mentorMeetingSlotsRecord) =>
                                  mentorMeetingSlotsRecord
                                      .where(
                                        'mentor',
                                        isEqualTo: currentUserReference,
                                      )
                                      .orderBy('startTime'),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: SpinKitRipple(
                                      color: MyFlutterTheme.of(context).primary,
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              }
                              List<MentorMeetingSlotsRecord>
                                  gridViewMentorMeetingSlotsRecordList =
                                  snapshot.data!;
                              if (gridViewMentorMeetingSlotsRecordList
                                  .isEmpty) {
                                return Image.asset(
                                  'assets/images/empty_Box_in_girl_hand_animation.gif',
                                );
                              }

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 24.0,
                                  mainAxisSpacing: 12.0,
                                  childAspectRatio: 1.1,
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    gridViewMentorMeetingSlotsRecordList.length,
                                itemBuilder: (context, gridViewIndex) {
                                  final gridViewMentorMeetingSlotsRecord =
                                      gridViewMentorMeetingSlotsRecordList[
                                          gridViewIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.selectedSlot =
                                          gridViewMentorMeetingSlotsRecord;
                                      _model.eDateLocal =
                                          gridViewMentorMeetingSlotsRecord.date;
                                      _model.eTimeStartLocal =
                                          gridViewMentorMeetingSlotsRecord
                                              .startTime;
                                      _model.eTimeEndLocal =
                                          gridViewMentorMeetingSlotsRecord
                                              .endTime;
                                      _model.viewMeetSlots = true;
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      width: 45.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.2,
                                      decoration: const BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.45,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.2,
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          dateTimeFormat(
                                                              "yMMMd",
                                                              gridViewMentorMeetingSlotsRecord
                                                                  .date),
                                                          'Apr 16, 2024',
                                                        ),
                                                        style:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 60.0,
                                                    child: Divider(
                                                      thickness: 1.2,
                                                      color: Color(0xFF999DA1),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                        Icons.access_time,
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                      SelectionArea(
                                                          child: Text(
                                                        valueOrDefault<String>(
                                                          dateTimeFormat(
                                                              "jm",
                                                              gridViewMentorMeetingSlotsRecord
                                                                  .startTime),
                                                          '9:28 PM',
                                                        ),
                                                        style:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                      )),
                                                      Icon(
                                                        Icons.access_time,
                                                        color: MyFlutterTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        size: 20.0,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'To',
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                        Icons.access_time,
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                      SelectionArea(
                                                          child: Text(
                                                        valueOrDefault<String>(
                                                          dateTimeFormat(
                                                              "jm",
                                                              gridViewMentorMeetingSlotsRecord
                                                                  .endTime),
                                                          '9:28 PM',
                                                        ),
                                                        style:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                      )),
                                                      Icon(
                                                        Icons.access_time,
                                                        color: MyFlutterTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        size: 20.0,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (valueOrDefault<bool>(
                                            _model.liveSlotsEdit == true,
                                            false,
                                          ))
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1.0, -1.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Permanently Delete Current Slots?'),
                                                                content: const Text(
                                                                    'You will not be able to undo.'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: const Text(
                                                                        'Confirm'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    await gridViewMentorMeetingSlotsRecord
                                                        .reference
                                                        .delete();
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .error,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyFlutterTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 24.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Icon(
                                Icons.keyboard_backspace_rounded,
                                color: MyFlutterTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Create Meeting',
                                style: MyFlutterTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.editPrice = !_model.editPrice;
                            safeSetState(() {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.currency_exchange,
                                color: MyFlutterTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => Text(
                                  valueOrDefault<String>(
                                    valueOrDefault(
                                                currentUserDocument
                                                    ?.priceMeetingSlot,
                                                0.0) >
                                            0.0
                                        ? valueOrDefault<String>(
                                            formatNumber(
                                              valueOrDefault(
                                                  currentUserDocument
                                                      ?.priceMeetingSlot,
                                                  0.0),
                                              formatType: FormatType.compact,
                                            ),
                                            'Free',
                                          )
                                        : 'Free',
                                    'Free',
                                  ),
                                  style: MyFlutterTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color:
                                            MyFlutterTheme.of(context).success,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['rowOnPageLoadAnimation']!),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.addMeetSlots = true;
                      safeSetState(() {});
                    },
                    text: 'Add New Meeting Slot\'s',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: MyFlutterTheme.of(context).primary,
                      textStyle: MyFlutterTheme.of(context).titleSmall.override(
                            fontFamily: 'Noto Serif',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              if (valueOrDefault<bool>(
                _model.addMeetSlots != false,
                true,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: const BoxDecoration(
                    color: Color(0x50383838),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      decoration: BoxDecoration(
                        color: MyFlutterTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.36,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 22.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Add New Slots for Meeting.',
                                        style: MyFlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.addMeetSlots = false;
                                        safeSetState(() {});
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        size: 32.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.95,
                                  decoration: BoxDecoration(
                                    color: MyFlutterTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                SelectionArea(
                                                    child: Text(
                                                  valueOrDefault<String>(
                                                    dateTimeFormat("yMMMd",
                                                        _model.dateLocal),
                                                    'Apr 16, 2024',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                )),
                                              ],
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                // datePicked-1
                                                final datePicked1Date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      getCurrentTimestamp,
                                                  firstDate:
                                                      getCurrentTimestamp,
                                                  lastDate: DateTime(2050),
                                                );

                                                if (datePicked1Date != null) {
                                                  safeSetState(() {
                                                    _model.datePicked1 =
                                                        DateTime(
                                                      datePicked1Date.year,
                                                      datePicked1Date.month,
                                                      datePicked1Date.day,
                                                    );
                                                  });
                                                }
                                                _model.dateLocal =
                                                    _model.datePicked1;
                                                _model.timeStartLocal =
                                                    functions.cFDate1Time2(
                                                        _model.datePicked1,
                                                        _model.timeStartLocal);
                                                _model.timeEndLocal =
                                                    functions.cFDate1Time2(
                                                        _model.datePicked1,
                                                        _model.timeEndLocal);
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 130.0,
                                                height: 25.0,
                                                decoration:
                                                    const BoxDecoration(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70.0,
                                          child: Divider(
                                            thickness: 1.5,
                                            color: Color(0xFF999DA1),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'From',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Icon(
                                                            Icons.access_time,
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                        SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "jm",
                                                                _model
                                                                    .timeStartLocal),
                                                            '06:00 PM',
                                                          ),
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'To',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Icon(
                                                            Icons.access_time,
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                        SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "jm",
                                                                _model
                                                                    .timeEndLocal),
                                                            '07:00 PM',
                                                          ),
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    final datePicked2Time =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay
                                                          .fromDateTime(
                                                              getCurrentTimestamp),
                                                      builder:
                                                          (context, child) {
                                                        return wrapInMaterialTimePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          headerForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .info,
                                                          headerTextStyle:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    fontSize:
                                                                        32.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          pickerBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          pickerForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          selectedDateTimeBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          selectedDateTimeForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .info,
                                                          actionButtonForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );
                                                    if (datePicked2Time !=
                                                        null) {
                                                      safeSetState(() {
                                                        _model.datePicked2 =
                                                            DateTime(
                                                          getCurrentTimestamp
                                                              .year,
                                                          getCurrentTimestamp
                                                              .month,
                                                          getCurrentTimestamp
                                                              .day,
                                                          datePicked2Time.hour,
                                                          datePicked2Time
                                                              .minute,
                                                        );
                                                      });
                                                    }
                                                    _model.timeStartLocal =
                                                        functions.cFDate1Time2(
                                                            _model.dateLocal,
                                                            _model.datePicked2);
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 130.0,
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    final datePicked3Time =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime: TimeOfDay
                                                          .fromDateTime(
                                                              getCurrentTimestamp),
                                                      builder:
                                                          (context, child) {
                                                        return wrapInMaterialTimePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          headerForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .info,
                                                          headerTextStyle:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    fontSize:
                                                                        32.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          pickerBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          pickerForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          selectedDateTimeBackgroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          selectedDateTimeForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .info,
                                                          actionButtonForegroundColor:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );
                                                    if (datePicked3Time !=
                                                        null) {
                                                      safeSetState(() {
                                                        _model.datePicked3 =
                                                            DateTime(
                                                          getCurrentTimestamp
                                                              .year,
                                                          getCurrentTimestamp
                                                              .month,
                                                          getCurrentTimestamp
                                                              .day,
                                                          datePicked3Time.hour,
                                                          datePicked3Time
                                                              .minute,
                                                        );
                                                      });
                                                    }
                                                    _model.timeEndLocal =
                                                        functions.cFDate1Time2(
                                                            _model.dateLocal,
                                                            _model.datePicked3);
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 130.0,
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.58,
                                decoration: const BoxDecoration(),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      MyFlutterChoiceChips(
                                        options: functions
                                            .newCustomFunction(
                                                _model.timeStartLocal,
                                                _model.timeEndLocal)!
                                            .map((label) => ChipData(label))
                                            .toList(),
                                        onChanged: (val) => safeSetState(() =>
                                            _model.ccSelectSlotsValues = val),
                                        selectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              MyFlutterTheme.of(context)
                                                  .primary,
                                          textStyle: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .secondaryBackground,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor: MyFlutterTheme.of(context)
                                              .primaryText,
                                          iconSize: 18.0,
                                          elevation: 4.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        unselectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              MyFlutterTheme.of(context)
                                                  .primaryBackground,
                                          textStyle: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                          iconColor: MyFlutterTheme.of(context)
                                              .primaryBackground,
                                          iconSize: 18.0,
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        chipSpacing: 12.0,
                                        rowSpacing: 12.0,
                                        multiselect: true,
                                        initialized:
                                            _model.ccSelectSlotsValues != null,
                                        alignment: WrapAlignment.start,
                                        controller: _model
                                                .ccSelectSlotsValueController ??=
                                            FormFieldController<List<String>>(
                                          functions.newCustomFunction(
                                              _model.timeStartLocal,
                                              _model.timeEndLocal),
                                        ),
                                        wrapped: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: (_model
                                          .ccSelectSlotsValues!.isEmpty)
                                      ? null
                                      : () async {
                                          var mentorMeetingSlotsRecordReference =
                                              MentorMeetingSlotsRecord
                                                  .collection
                                                  .doc();
                                          await mentorMeetingSlotsRecordReference
                                              .set(
                                                  createMentorMeetingSlotsRecordData(
                                            date: _model.dateLocal,
                                            startTime: _model.timeStartLocal,
                                            endTime: _model.datePicked3,
                                            mentor: currentUserReference,
                                          ));
                                          _model.aoMentorMeetingSlots =
                                              MentorMeetingSlotsRecord
                                                  .getDocumentFromData(
                                                      createMentorMeetingSlotsRecordData(
                                                        date: _model.dateLocal,
                                                        startTime: _model
                                                            .timeStartLocal,
                                                        endTime:
                                                            _model.datePicked3,
                                                        mentor:
                                                            currentUserReference,
                                                      ),
                                                      mentorMeetingSlotsRecordReference);
                                          _model.selectedSlotsIndexes = _model
                                              .ccSelectSlotsValues!
                                              .toList()
                                              .cast<String>();
                                          safeSetState(() {});
                                          _model.loopIndexAddSlots = 0;
                                          safeSetState(() {});
                                          while (_model.loopIndexAddSlots! <
                                              _model.ccSelectSlotsValues!
                                                  .length) {
                                            await Mentor15minsSlotsRecord
                                                    .createDoc(_model
                                                        .aoMentorMeetingSlots!
                                                        .reference)
                                                .set(
                                                    createMentor15minsSlotsRecordData(
                                              mentor: currentUserReference,
                                              date: _model.dateLocal,
                                              startTime:
                                                  functions.cfAddSlots15MinTime(
                                                      _model.timeStartLocal,
                                                      _model.loopIndexAddSlots),
                                              endTime: functions
                                                  .cfAddSlots15MinTime2(
                                                      _model.timeStartLocal,
                                                      _model.loopIndexAddSlots),
                                            ));
                                            _model.loopIndexAddSlots =
                                                _model.loopIndexAddSlots! + 1;
                                            safeSetState(() {});
                                          }
                                          _model.addMeetSlots = false;
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.ccSelectSlotsValueController
                                                ?.reset();
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'New Slots Added',
                                                style: MyFlutterTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 4000),
                                              backgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                            ),
                                          );

                                          safeSetState(() {});
                                        },
                                  text: 'Add Slots',
                                  options: FFButtonOptions(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: MyFlutterTheme.of(context).primary,
                                    textStyle: MyFlutterTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    disabledColor: const Color(0x8157636C),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.viewMeetSlots != false,
                true,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: const BoxDecoration(
                    color: Color(0x50383838),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      decoration: BoxDecoration(
                        color: MyFlutterTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.36,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 22.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Set Available Slots for Meeting.',
                                        style: MyFlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.viewMeetSlots = false;
                                        safeSetState(() {});
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        size: 32.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.95,
                                  decoration: BoxDecoration(
                                    color: MyFlutterTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                SelectionArea(
                                                    child: Text(
                                                  valueOrDefault<String>(
                                                    dateTimeFormat("yMMMd",
                                                        _model.eDateLocal),
                                                    'Apr 16, 2024',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                )),
                                              ],
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (valueOrDefault<bool>(
                                                  _model.liveSlotsEdit == true,
                                                  false,
                                                )) {
                                                  final datePicked4Date =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        getCurrentTimestamp,
                                                    firstDate:
                                                        getCurrentTimestamp,
                                                    lastDate: DateTime(2050),
                                                    builder: (context, child) {
                                                      return wrapInMaterialDatePickerTheme(
                                                        context,
                                                        child!,
                                                        headerBackgroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        headerForegroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .info,
                                                        headerTextStyle:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  fontSize:
                                                                      32.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                        pickerBackgroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        pickerForegroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        selectedDateTimeBackgroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        selectedDateTimeForegroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .info,
                                                        actionButtonForegroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        iconSize: 24.0,
                                                      );
                                                    },
                                                  );

                                                  if (datePicked4Date != null) {
                                                    safeSetState(() {
                                                      _model.datePicked4 =
                                                          DateTime(
                                                        datePicked4Date.year,
                                                        datePicked4Date.month,
                                                        datePicked4Date.day,
                                                      );
                                                    });
                                                  }
                                                  _model.eDateLocal =
                                                      _model.datePicked4;
                                                  safeSetState(() {});
                                                }
                                              },
                                              child: Container(
                                                width: 125.0,
                                                height: 25.0,
                                                decoration:
                                                    const BoxDecoration(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 70.0,
                                          child: Divider(
                                            thickness: 1.5,
                                            color: Color(0xFF999DA1),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'From',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Icon(
                                                            Icons.access_time,
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                        SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "jm",
                                                                _model
                                                                    .eTimeStartLocal),
                                                            '9:57 PM',
                                                          ),
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'To',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Icon(
                                                            Icons.access_time,
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                        SelectionArea(
                                                            child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                                "jm",
                                                                _model
                                                                    .eTimeEndLocal),
                                                            '9:57 PM',
                                                          ),
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                        )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                if (valueOrDefault<bool>(
                                                  _model.liveSlotsEdit == true,
                                                  false,
                                                ))
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      final datePicked5Time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                getCurrentTimestamp),
                                                        builder:
                                                            (context, child) {
                                                          return wrapInMaterialTimePickerTheme(
                                                            context,
                                                            child!,
                                                            headerBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                            headerForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .info,
                                                            headerTextStyle:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Noto Serif',
                                                                      fontSize:
                                                                          32.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                            pickerBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            pickerForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            selectedDateTimeBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                            selectedDateTimeForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .info,
                                                            actionButtonForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            iconSize: 24.0,
                                                          );
                                                        },
                                                      );
                                                      if (datePicked5Time !=
                                                          null) {
                                                        safeSetState(() {
                                                          _model.datePicked5 =
                                                              DateTime(
                                                            getCurrentTimestamp
                                                                .year,
                                                            getCurrentTimestamp
                                                                .month,
                                                            getCurrentTimestamp
                                                                .day,
                                                            datePicked5Time
                                                                .hour,
                                                            datePicked5Time
                                                                .minute,
                                                          );
                                                        });
                                                      }
                                                      if (_model.datePicked5! <
                                                          _model
                                                              .eTimeEndLocal!) {
                                                        _model.eTimeStartLocal =
                                                            _model.datePicked5;
                                                        safeSetState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              '[From] time should be  <  than [To] time.',
                                                              style: TextStyle(
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        4000),
                                                            backgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 130.0,
                                                      height: 40.0,
                                                      decoration:
                                                          const BoxDecoration(),
                                                    ),
                                                  ),
                                                if (valueOrDefault<bool>(
                                                  _model.liveSlotsEdit == true,
                                                  false,
                                                ))
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      final datePicked6Time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                getCurrentTimestamp),
                                                        builder:
                                                            (context, child) {
                                                          return wrapInMaterialTimePickerTheme(
                                                            context,
                                                            child!,
                                                            headerBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                            headerForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .info,
                                                            headerTextStyle:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .override(
                                                                      fontFamily:
                                                                          'Noto Serif',
                                                                      fontSize:
                                                                          32.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                            pickerBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                            pickerForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            selectedDateTimeBackgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                            selectedDateTimeForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .info,
                                                            actionButtonForegroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            iconSize: 24.0,
                                                          );
                                                        },
                                                      );
                                                      if (datePicked6Time !=
                                                          null) {
                                                        safeSetState(() {
                                                          _model.datePicked6 =
                                                              DateTime(
                                                            getCurrentTimestamp
                                                                .year,
                                                            getCurrentTimestamp
                                                                .month,
                                                            getCurrentTimestamp
                                                                .day,
                                                            datePicked6Time
                                                                .hour,
                                                            datePicked6Time
                                                                .minute,
                                                          );
                                                        });
                                                      }
                                                      if (_model
                                                              .eTimeStartLocal! <
                                                          _model.datePicked6!) {
                                                        _model.eTimeEndLocal =
                                                            _model.datePicked6;
                                                        safeSetState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .clearSnackBars();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              '[To] time should be  <  than [From] time.',
                                                              style: TextStyle(
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        4000),
                                                            backgroundColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 130.0,
                                                      height: 40.0,
                                                      decoration:
                                                          const BoxDecoration(),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.58,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: StreamBuilder<
                                      List<Mentor15minsSlotsRecord>>(
                                    stream: queryMentor15minsSlotsRecord(
                                      parent: _model.selectedSlot?.reference,
                                      queryBuilder: (mentor15minsSlotsRecord) =>
                                          mentor15minsSlotsRecord
                                              .orderBy('startTime'),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpinKitRipple(
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 50.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<Mentor15minsSlotsRecord>
                                          gridViewMentor15minsSlotsRecordList =
                                          snapshot.data!;

                                      return GridView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                          0,
                                          8.0,
                                          0,
                                          0,
                                        ),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                          childAspectRatio: 4.0,
                                        ),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            gridViewMentor15minsSlotsRecordList
                                                .length,
                                        itemBuilder: (context, gridViewIndex) {
                                          final gridViewMentor15minsSlotsRecord =
                                              gridViewMentor15minsSlotsRecordList[
                                                  gridViewIndex];
                                          return Stack(
                                            children: [
                                              Container(
                                                width: 140.0,
                                                height: 26.0,
                                                decoration: BoxDecoration(
                                                  color: valueOrDefault<Color>(
                                                    gridViewMentor15minsSlotsRecord
                                                                .mentee !=
                                                            null
                                                        ? const Color(
                                                            0xFFABACAD)
                                                        : MyFlutterTheme.of(
                                                                context)
                                                            .accent2,
                                                    MyFlutterTheme.of(context)
                                                        .accent2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                ),
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    '${valueOrDefault<String>(
                                                      dateTimeFormat(
                                                          "jm",
                                                          gridViewMentor15minsSlotsRecord
                                                              .startTime),
                                                      '7:10 PM',
                                                    )} - ${valueOrDefault<String>(
                                                      dateTimeFormat(
                                                          "jm",
                                                          gridViewMentor15minsSlotsRecord
                                                              .endTime),
                                                      '7:25 PM',
                                                    )}',
                                                    '7:10 PM - 7:25 PM',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                ),
                                              ),
                                              if (gridViewMentor15minsSlotsRecord
                                                      .mentee !=
                                                  null)
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.menteeRef =
                                                        gridViewMentor15minsSlotsRecord
                                                            .mentee;
                                                    _model.selectedSlot15min =
                                                        gridViewMentor15minsSlotsRecord;
                                                    _model.isMenteeCardVisible =
                                                        true;
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    width: 140.0,
                                                    height: 26.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (valueOrDefault<bool>(
                                _model.liveSlotsEdit == true,
                                false,
                              ))
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: ('1' == '1')
                                        ? null
                                        : () async {
                                            await _model.selectedSlot!.reference
                                                .update(
                                                    createMentorMeetingSlotsRecordData(
                                              date: _model.eDateLocal,
                                              startTime: _model.eTimeStartLocal,
                                              endTime: _model.eTimeEndLocal,
                                            ));
                                            _model.viewMeetSlots = false;
                                            safeSetState(() {});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Slot Updated',
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                              ),
                                            );
                                          },
                                    text: 'Update Slots',
                                    options: FFButtonOptions(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: MyFlutterTheme.of(context).primary,
                                      textStyle: MyFlutterTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                      disabledColor: const Color(0x8157636C),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.isMenteeCardVisible != false,
                true,
              ))
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.isMenteeCardVisible = false;
                    safeSetState(() {});
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: const BoxDecoration(
                      color: Color(0x50383838),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(_model.menteeRef!),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitRipple(
                                    color: MyFlutterTheme.of(context).primary,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }

                            final containerUsersRecord = snapshot.data!;

                            return Container(
                              width: 230.0,
                              height: 130.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(14.0, 0.0, 0.0, 0.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.ellipsisV,
                                            color: MyFlutterTheme.of(context)
                                                .secondaryText,
                                            size: 16.0,
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            '${valueOrDefault<String>(
                                              dateTimeFormat(
                                                  "jm",
                                                  _model.selectedSlot15min
                                                      ?.startTime),
                                              '7:10 PM',
                                            )} - ${valueOrDefault<String>(
                                              dateTimeFormat(
                                                  "jm",
                                                  _model.selectedSlot15min
                                                      ?.endTime),
                                              '7:25 PM',
                                            )}',
                                            '7:10 PM - 7:25 PM',
                                          ),
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 6.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.isMenteeCardVisible =
                                                  false;
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: MyFlutterTheme.of(context)
                                                  .error,
                                              size: 24.0,
                                            ),
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 70.0,
                                          height: 70.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            containerUsersRecord.photoUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 70.0,
                                        decoration: const BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8.0, 4.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                valueOrDefault<String>(
                                                  containerUsersRecord
                                                      .displayName,
                                                  'Not Booked',
                                                ),
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                    'profile',
                                                    queryParameters: {
                                                      'profileDoc':
                                                          serializeParam(
                                                        containerUsersRecord,
                                                        ParamType.Document,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      'profileDoc':
                                                          containerUsersRecord,
                                                    },
                                                  );
                                                },
                                                text: 'View Profile',
                                                options: FFButtonOptions(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  color:
                                                      const Color(0xFFAFAFAF),
                                                  textStyle:
                                                      MyFlutterTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  elevation: 0.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.editPrice != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(0.69, -0.8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                    width: 200.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: MyFlutterTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(
                        color: MyFlutterTheme.of(context).primaryText,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Set Meeting Slot Price',
                            style:
                                MyFlutterTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 6.0, 30.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => SizedBox(
                                width: 200.0,
                                child: TextFormField(
                                  controller:
                                      _model.tFPriceMeetingSlotTextController,
                                  focusNode: _model.tFPriceMeetingSlotFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: MyFlutterTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Price',
                                    hintStyle: MyFlutterTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            MyFlutterTheme.of(context).primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyFlutterTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyFlutterTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    filled: true,
                                    fillColor: MyFlutterTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color:
                                            MyFlutterTheme.of(context).success,
                                        letterSpacing: 3.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLength: 4,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  cursorColor:
                                      MyFlutterTheme.of(context).primaryText,
                                  validator: _model
                                      .tFPriceMeetingSlotTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.editPrice = false;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    width: 30.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0x4B57636C),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.times,
                                      color: MyFlutterTheme.of(context)
                                          .primaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      priceMeetingSlot: double.tryParse(_model
                                          .tFPriceMeetingSlotTextController
                                          .text),
                                    ));
                                    _model.editPrice = false;
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    width: 30.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      color: MyFlutterTheme.of(context).accent1,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.check,
                                      color: MyFlutterTheme.of(context)
                                          .primaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
