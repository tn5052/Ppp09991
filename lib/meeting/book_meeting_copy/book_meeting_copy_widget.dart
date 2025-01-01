import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/cc_list_view/cc_list_view_widget.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'book_meeting_copy_model.dart';
export 'book_meeting_copy_model.dart';

class BookMeetingCopyWidget extends StatefulWidget {
  const BookMeetingCopyWidget({
    super.key,
    this.mentor,
  });

  final UsersRecord? mentor;

  @override
  State<BookMeetingCopyWidget> createState() => _BookMeetingCopyWidgetState();
}

class _BookMeetingCopyWidgetState extends State<BookMeetingCopyWidget>
    with TickerProviderStateMixin {
  late BookMeetingCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookMeetingCopyModel());

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
                          'Asia/Karachi Standar time.',
                          style: MyFlutterTheme.of(context).bodyMedium.override(
                                fontFamily: 'Noto Serif',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color:
                                MyFlutterTheme.of(context).secondaryBackground,
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
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    unselectedChipStyle: ChipStyle(
                                      backgroundColor:
                                          MyFlutterTheme.of(context).alternate,
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
                                      borderRadius: BorderRadius.circular(16.0),
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
                                                  .orderBy('date'),
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
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 6.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      dateTimeFormat(
                                                          "yMMMd",
                                                          listViewMentorMeetingSlotsRecord
                                                              .date),
                                                      'Apr 15, 2024',
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
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      CcListViewWidget(
                                                        key: Key(
                                                            'Keynbg_${listViewIndex}_of_${listViewMentorMeetingSlotsRecordList.length}'),
                                                        parameter1:
                                                            listViewMentorMeetingSlotsRecord
                                                                .startTime,
                                                        parameter2:
                                                            listViewMentorMeetingSlotsRecord
                                                                .endTime,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                          onPressed: () async {},
                          text: 'Proceed and Pay \$35',
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
                        Container(
                          decoration: const BoxDecoration(),
                          child: badges.Badge(
                            badgeContent: Text(
                              '1',
                              style: MyFlutterTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            showBadge: true,
                            shape: badges.BadgeShape.circle,
                            badgeColor: MyFlutterTheme.of(context).error,
                            elevation: 4.0,
                            padding: const EdgeInsets.all(5.0),
                            position: badges.BadgePosition.topEnd(),
                            animationType: badges.BadgeAnimationType.scale,
                            toAnimate: true,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                GoRouter.of(context).prepareAuthEvent();
                                await authManager.signOut();
                                GoRouter.of(context).clearRedirectLocation();

                                context.goNamedAuth(
                                    'onBoarding', context.mounted);
                              },
                              child: Icon(
                                Icons.notifications_outlined,
                                color: MyFlutterTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                            ),
                          ),
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
