import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'book_meeting_model.dart';
export 'book_meeting_model.dart';

class BookMeetingWidget extends StatefulWidget {
  const BookMeetingWidget({
    super.key,
    this.mentor,
  });

  final UsersRecord? mentor;

  @override
  State<BookMeetingWidget> createState() => _BookMeetingWidgetState();
}

class _BookMeetingWidgetState extends State<BookMeetingWidget>
    with TickerProviderStateMixin {
  late BookMeetingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookMeetingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});

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
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: Text(
                          'Asia/Karachi Standar time',
                          style: MyFlutterTheme.of(context).bodyMedium.override(
                                fontFamily: 'Noto Serif',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: MyFlutterTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meeting Duration',
                                    style: MyFlutterTheme.of(context)
                                        .labelLarge
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: MyFlutterTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Expanded(
                                    child: MyFlutterChoiceChips(
                                      options: const [
                                        ChipData('Standard 15 mins'),
                                        ChipData('30 mins'),
                                        ChipData('1 hour')
                                      ],
                                      onChanged: (val) => safeSetState(() =>
                                          _model.choiceChipsValue =
                                              val?.firstOrNull),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            MyFlutterTheme.of(context).primary,
                                        textStyle: MyFlutterTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                        iconColor: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        iconSize: 25.0,
                                        elevation: 4.0,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor:
                                            MyFlutterTheme.of(context)
                                                .alternate,
                                        textStyle: MyFlutterTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryText,
                                              letterSpacing: 0.0,
                                            ),
                                        iconColor: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        iconSize: 22.0,
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      chipSpacing: 12.0,
                                      rowSpacing: 12.0,
                                      multiselect: false,
                                      alignment: WrapAlignment.start,
                                      controller:
                                          _model.choiceChipsValueController ??=
                                              FormFieldController<List<String>>(
                                        [],
                                      ),
                                      wrapped: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          decoration: BoxDecoration(
                            color:
                                MyFlutterTheme.of(context).secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  5.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time Slots',
                                  style: MyFlutterTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Expanded(
                                  child: StreamBuilder<
                                      List<MentorMeetingSlotsRecord>>(
                                    stream: queryMentorMeetingSlotsRecord(
                                      queryBuilder:
                                          (mentorMeetingSlotsRecord) =>
                                              mentorMeetingSlotsRecord
                                                  .where(
                                                    'mentor',
                                                    isEqualTo: widget
                                                        .mentor?.reference,
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
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 50.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<MentorMeetingSlotsRecord>
                                          listViewMentorMeetingSlotsRecordList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewMentorMeetingSlotsRecordList
                                                .length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewMentorMeetingSlotsRecord =
                                              listViewMentorMeetingSlotsRecordList[
                                                  listViewIndex];
                                          return Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.1,
                                            decoration: const BoxDecoration(),
                                            child: Visibility(
                                              visible:
                                                  listViewMentorMeetingSlotsRecord
                                                          .endTime! >
                                                      getCurrentTimestamp,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 6.0,
                                                            0.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        dateTimeFormat(
                                                            "yMMMd",
                                                            listViewMentorMeetingSlotsRecord
                                                                .date),
                                                        'Apr 21, 2024',
                                                      ),
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 8.0, 0.0, 0.0),
                                                    child: StreamBuilder<
                                                        List<
                                                            Mentor15minsSlotsRecord>>(
                                                      stream:
                                                          queryMentor15minsSlotsRecord(
                                                        parent:
                                                            listViewMentorMeetingSlotsRecord
                                                                .reference,
                                                        queryBuilder:
                                                            (mentor15minsSlotsRecord) =>
                                                                mentor15minsSlotsRecord
                                                                    .orderBy(
                                                                        'startTime'),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              child:
                                                                  SpinKitRipple(
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 50.0,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<Mentor15minsSlotsRecord>
                                                            rowMentor15minsSlotsRecordList =
                                                            snapshot.data!;

                                                        return SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                rowMentor15minsSlotsRecordList
                                                                    .length,
                                                                (rowIndex) {
                                                              final rowMentor15minsSlotsRecord =
                                                                  rowMentor15minsSlotsRecordList[
                                                                      rowIndex];
                                                              return Visibility(
                                                                visible: rowMentor15minsSlotsRecord
                                                                        .startTime! >
                                                                    getCurrentTimestamp,
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          150.0,
                                                                      height:
                                                                          35.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            () {
                                                                          if (rowMentor15minsSlotsRecord.mentee ==
                                                                              currentUserReference) {
                                                                            return MyFlutterTheme.of(context).primary;
                                                                          } else if (rowMentor15minsSlotsRecord.mentee !=
                                                                              null) {
                                                                            return const Color(0xFFABACAD);
                                                                          } else {
                                                                            return MyFlutterTheme.of(context).accent2;
                                                                          }
                                                                        }(),
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            '${valueOrDefault<String>(
                                                                              dateTimeFormat("jm", rowMentor15minsSlotsRecord.startTime),
                                                                              '10:45 PM',
                                                                            )} - ${valueOrDefault<String>(
                                                                              dateTimeFormat("jm", rowMentor15minsSlotsRecord.endTime),
                                                                              '10:45 PM',
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
                                                                      ),
                                                                    ),
                                                                    if ((rowMentor15minsSlotsRecord.mentee ==
                                                                            null) ||
                                                                        (rowMentor15minsSlotsRecord.mentee ==
                                                                            currentUserReference))
                                                                      Opacity(
                                                                        opacity:
                                                                            0.01,
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            if (rowMentor15minsSlotsRecord.mentee !=
                                                                                null) {
                                                                              await rowMentor15minsSlotsRecord.reference.update({
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'mentee': FieldValue.delete(),
                                                                                  },
                                                                                ),
                                                                              });
                                                                            } else {
                                                                              await rowMentor15minsSlotsRecord.reference.update(createMentor15minsSlotsRecordData(
                                                                                mentee: currentUserReference,
                                                                              ));
                                                                            }

                                                                            _model.newSelectedSlot =
                                                                                rowMentor15minsSlotsRecord.startTime;
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                0.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 150.0,
                                                                              height: 35.0,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                              ),
                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            }).divide(
                                                              const SizedBox(
                                                                  width: 12.0),
                                                              filterFn:
                                                                  (rowIndex) {
                                                                final rowMentor15minsSlotsRecord =
                                                                    rowMentor15minsSlotsRecordList[
                                                                        rowIndex];
                                                                return rowMentor15minsSlotsRecord
                                                                        .startTime! >
                                                                    getCurrentTimestamp;
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 100.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final paymentResponse = await processStripePayment(
                              context,
                              amount: valueOrDefault<int>(
                                ((valueOrDefault<double>(
                                              widget.mentor?.priceMeetingSlot,
                                              0.0,
                                            ) +
                                            valueOrDefault<double>(
                                              1.00,
                                              1.00,
                                            )) *
                                        100)
                                    .round(),
                                100,
                              ),
                              currency: 'USD',
                              customerEmail: currentUserEmail,
                              customerName: currentUserDisplayName,
                              description: valueOrDefault<String>(
                                '${valueOrDefault<String>(
                                  widget.mentor?.email,
                                  'none',
                                )}${"/n"}${_model.choiceChipsValue}',
                                'Nothing Special',
                              ),
                              allowGooglePay: true,
                              allowApplePay: false,
                              themeStyle: ThemeMode.system,
                              buttonColor: MyFlutterTheme.of(context).primary,
                              buttonTextColor: MyFlutterTheme.of(context)
                                  .secondaryBackground,
                            );
                            if (paymentResponse.paymentId == null &&
                                paymentResponse.errorMessage != null) {
                              showSnackbar(
                                context,
                                'Error: ${paymentResponse.errorMessage}',
                              );
                            }
                            _model.paymentId = paymentResponse.paymentId ?? '';

                            if (_model.paymentId != null &&
                                _model.paymentId != '') {
                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'mentors': FieldValue.arrayUnion(
                                        [widget.mentor?.reference]),
                                  },
                                ),
                              });

                              await InAppNotificationsRecord.collection
                                  .doc()
                                  .set(createInAppNotificationsRecordData(
                                    info:
                                        '$currentUserDisplayName booked meeting.',
                                    dateTime: getCurrentTimestamp,
                                    mentee: currentUserReference,
                                    meetingTime: _model.newSelectedSlot,
                                    mentor: widget.mentor?.reference,
                                  ));

                              await InAppNotificationsRecord.collection
                                  .doc()
                                  .set(createInAppNotificationsRecordData(
                                    info:
                                        '$currentUserDisplayName booked meeting.',
                                    dateTime: getCurrentTimestamp,
                                    mentee: currentUserReference,
                                    meetingTime:
                                        _model.selected15Slot?.startTime,
                                    mentor: widget.mentor?.reference,
                                  ));

                              context.pushNamed(
                                'bookedMeetingSummery',
                                queryParameters: {
                                  'mentor': serializeParam(
                                    widget.mentor,
                                    ParamType.Document,
                                  ),
                                  'slotTme': serializeParam(
                                    _model.newSelectedSlot,
                                    ParamType.DateTime,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'mentor': widget.mentor,
                                },
                              );
                            }

                            safeSetState(() {});
                          },
                          text: valueOrDefault<String>(
                            'Pay USD  ${valueOrDefault<String>(
                              widget.mentor?.priceMeetingSlot.toString(),
                              '0',
                            )}  +  Tax',
                            '0',
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: MyFlutterTheme.of(context).primary,
                            textStyle:
                                MyFlutterTheme.of(context).titleSmall.override(
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
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.safePop();
                                },
                                child: Text(
                                  'Book 1 on 1 Meeting',
                                  style: MyFlutterTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['rowOnPageLoadAnimation']!),
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
