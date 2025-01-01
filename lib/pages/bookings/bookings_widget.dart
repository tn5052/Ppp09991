import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:text_search/text_search.dart';
import 'bookings_model.dart';
export 'bookings_model.dart';

class BookingsWidget extends StatefulWidget {
  const BookingsWidget({
    super.key,
    String? byNav,
  }) : byNav = byNav ?? '  Events  ';

  final String byNav;

  @override
  State<BookingsWidget> createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget>
    with TickerProviderStateMixin {
  late BookingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.postNewbottomPopup = false;
      safeSetState(() {});
      if (valueOrDefault(currentUserDocument?.status, '') == 'ban') {
        context.goNamed(
          'ban_Page',
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

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.tfEventsTextController ??= TextEditingController();
    _model.tfEventsFocusNode ??= FocusNode();

    _model.tfMentorsTextController ??= TextEditingController();
    _model.tfMentorsFocusNode ??= FocusNode();

    animationsMap.addAll({
      'rowOnPageLoadAnimation1': AnimationInfo(
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
      'rowOnPageLoadAnimation2': AnimationInfo(
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
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 0.0,
            end: -0.25,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: const Alignment(0.0, 0),
                    child: TabBar(
                      labelColor: MyFlutterTheme.of(context).primary,
                      unselectedLabelColor:
                          MyFlutterTheme.of(context).secondaryText,
                      labelStyle:
                          MyFlutterTheme.of(context).titleMedium.override(
                                fontFamily: 'Noto Serif',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                      unselectedLabelStyle:
                          MyFlutterTheme.of(context).titleMedium.override(
                                fontFamily: 'Noto Serif',
                                letterSpacing: 0.0,
                              ),
                      indicatorColor: MyFlutterTheme.of(context).primary,
                      tabs: const [
                        Tab(
                          text: 'Events',
                        ),
                        Tab(
                          text: 'Mentors',
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}, () async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                              tabletLandscape: false,
                            ))
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 8.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          color: MyFlutterTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: MyFlutterTheme.of(context)
                                                .primaryBackground,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(2.0, 0.0, 2.0, 0.0),
                                          child: TextFormField(
                                            controller:
                                                _model.tfEventsTextController,
                                            focusNode: _model.tfEventsFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.tfEventsTextController',
                                              const Duration(
                                                  milliseconds: 2000),
                                              () async {
                                                safeSetState(() => _model
                                                        .algoliaSearchResults =
                                                    null);
                                                await EventsRecord.search(
                                                  term: valueOrDefault<String>(
                                                    _model
                                                        .tfEventsTextController
                                                        .text,
                                                    '*',
                                                  ),
                                                )
                                                    .then((r) => _model
                                                            .algoliaSearchResults =
                                                        r)
                                                    .onError((_, __) => _model
                                                            .algoliaSearchResults =
                                                        [])
                                                    .whenComplete(() =>
                                                        safeSetState(() {}));
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: 'Search for Events',
                                              hintStyle: MyFlutterTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0xFF828282),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              prefixIcon: FaIcon(
                                                FontAwesomeIcons.search,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                              ),
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                            validator: _model
                                                .tfEventsTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 0.0, 0.0, 0.0),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5.0, 5.0, 5.0, 5.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Icon(
                                                      Icons.filter_list,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          3.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    'Filters',
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: MyFlutterTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).animateOnPageLoad(
                                    animationsMap['rowOnPageLoadAnimation1']!),
                              ),
                            SafeArea(
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.78,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Builder(
                                      builder: (context) {
                                        final eventTicketList =
                                            (currentUserDocument?.eventTickets
                                                        .toList() ??
                                                    [])
                                                .toList();
                                        if (eventTicketList.isEmpty) {
                                          return Image.asset(
                                            'assets/images/empty_Box_in_girl_hand_animation.gif',
                                          );
                                        }

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: eventTicketList.length,
                                          itemBuilder:
                                              (context, eventTicketListIndex) {
                                            final eventTicketListItem =
                                                eventTicketList[
                                                    eventTicketListIndex];
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 10.0, 10.0, 0.0),
                                              child:
                                                  StreamBuilder<EventsRecord>(
                                                stream:
                                                    EventsRecord.getDocument(
                                                        eventTicketListItem),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: SpinKitRipple(
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          size: 50.0,
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  final containerEventsRecord =
                                                      snapshot.data!;

                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'event',
                                                        queryParameters: {
                                                          'docEvent':
                                                              serializeParam(
                                                            containerEventsRecord,
                                                            ParamType.Document,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'docEvent':
                                                              containerEventsRecord,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 250.0,
                                                      height: 130.0,
                                                      decoration: BoxDecoration(
                                                        color: MyFlutterTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        border: Border.all(
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              child:
                                                                  CachedNetworkImage(
                                                                fadeInDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                fadeOutDuration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                imageUrl:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  containerEventsRecord
                                                                      .media
                                                                      .firstOrNull,
                                                                  'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53',
                                                                ),
                                                                width: 82.0,
                                                                height: 110.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  'assets/images/error_image.PNG',
                                                                  width: 82.0,
                                                                  height: 110.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerEventsRecord
                                                                          .name,
                                                                      'name',
                                                                    ).maybeHandleOverflow(
                                                                      maxChars:
                                                                          14,
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          color:
                                                                              MyFlutterTheme.of(context).primaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerEventsRecord
                                                                          .description,
                                                                      'name',
                                                                    ).maybeHandleOverflow(
                                                                      maxChars:
                                                                          25,
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 80.0,
                                                                    child:
                                                                        Divider(
                                                                      height:
                                                                          4.0,
                                                                      thickness:
                                                                          1.2,
                                                                      color: Color(
                                                                          0xFF999DA1),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${valueOrDefault<String>(
                                                                      dateTimeFormat(
                                                                          "yMMMd",
                                                                          containerEventsRecord
                                                                              .timeStart),
                                                                      '0',
                                                                    )} - ${valueOrDefault<String>(
                                                                      dateTimeFormat(
                                                                          "jm",
                                                                          containerEventsRecord
                                                                              .timeStart),
                                                                      '0',
                                                                    )}',
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          color:
                                                                              MyFlutterTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    height:
                                                                        32.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: MyFlutterTheme.of(
                                                                              context)
                                                                          .accent2,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          '${valueOrDefault<String>(
                                                                            dateTimeFormat("yMMMd",
                                                                                containerEventsRecord.timeEnd),
                                                                            '0',
                                                                          )} - ${valueOrDefault<String>(
                                                                            dateTimeFormat("jm",
                                                                                containerEventsRecord.timeEnd),
                                                                            '0',
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
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 250.0,
                              decoration: const BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                                desktop: false,
                              ))
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 8.0, 20.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100.0,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                            color: MyFlutterTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: MyFlutterTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                          ),
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(2.0, 0.0, 2.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .tfMentorsTextController,
                                              focusNode:
                                                  _model.tfMentorsFocusNode,
                                              onChanged: (_) =>
                                                  EasyDebounce.debounce(
                                                '_model.tfMentorsTextController',
                                                const Duration(
                                                    milliseconds: 2000),
                                                () async {
                                                  await queryUsersRecordOnce()
                                                      .then(
                                                        (records) => _model
                                                                .simpleSearchResults =
                                                            TextSearch(
                                                          records
                                                              .map(
                                                                (record) =>
                                                                    TextSearchItem
                                                                        .fromTerms(
                                                                            record,
                                                                            [
                                                                      record
                                                                          .email,
                                                                      record
                                                                          .displayName,
                                                                      record
                                                                          .about
                                                                    ]),
                                                              )
                                                              .toList(),
                                                        )
                                                                .search(_model
                                                                    .tfMentorsTextController
                                                                    .text)
                                                                .map((r) =>
                                                                    r.object)
                                                                .toList(),
                                                      )
                                                      .onError((_, __) => _model
                                                              .simpleSearchResults =
                                                          [])
                                                      .whenComplete(() =>
                                                          safeSetState(() {}));
                                                },
                                              ),
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Search for Mentors',
                                                hintStyle:
                                                    MyFlutterTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: const Color(
                                                              0xFF828282),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                prefixIcon: FaIcon(
                                                  FontAwesomeIcons.search,
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                ),
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .headlineSmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    letterSpacing: 0.0,
                                                  ),
                                              validator: _model
                                                  .tfMentorsTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.0, 0.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 5.0, 5.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Icon(
                                                        Icons.filter_list,
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            3.0, 0.0, 0.0, 0.0),
                                                    child: Text(
                                                      'Filters',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).animateOnPageLoad(animationsMap[
                                      'rowOnPageLoadAnimation2']!),
                                ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    14.0, 14.0, 14.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Mentor\'s',
                                      style: MyFlutterTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: MyFlutterTheme.of(context)
                                              .secondaryText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                child: StreamBuilder<
                                    List<Mentor15minsSlotsRecord>>(
                                  stream: queryMentor15minsSlotsRecord(
                                    queryBuilder: (mentor15minsSlotsRecord) =>
                                        mentor15minsSlotsRecord
                                            .where(Filter.and(
                                      Filter(
                                        'mentee',
                                        isEqualTo: currentUserReference,
                                      ),
                                      Filter(
                                        'mentor',
                                        isNotEqualTo: currentUserReference,
                                      ),
                                    )),
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
                                        listViewMentor15minsSlotsRecordList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewMentor15minsSlotsRecordList
                                              .length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewMentor15minsSlotsRecord =
                                            listViewMentor15minsSlotsRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 10.0, 10.0, 0.0),
                                          child: StreamBuilder<UsersRecord>(
                                            stream: UsersRecord.getDocument(
                                                listViewMentor15minsSlotsRecord
                                                    .mentor!),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    child: SpinKitRipple(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      size: 50.0,
                                                    ),
                                                  ),
                                                );
                                              }

                                              final containerUsersRecord =
                                                  snapshot.data!;

                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
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
                                                      kTransitionInfoKey:
                                                          const TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .scale,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 250.0,
                                                  height: 130.0,
                                                  decoration: BoxDecoration(
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    border: Border.all(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            fadeOutDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            imageUrl:
                                                                valueOrDefault<
                                                                    String>(
                                                              containerUsersRecord
                                                                  .photoUrl,
                                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                            ),
                                                            width: 82.0,
                                                            height: 110.0,
                                                            fit: BoxFit.cover,
                                                            errorWidget: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                              'assets/images/error_image.PNG',
                                                              width: 82.0,
                                                              height: 110.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerUsersRecord
                                                                      .displayName,
                                                                  'No Name',
                                                                ).maybeHandleOverflow(
                                                                  maxChars: 14,
                                                                ),
                                                                style: MyFlutterTheme.of(
                                                                        context)
                                                                    .labelLarge
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
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                width: 80.0,
                                                                child: Divider(
                                                                  thickness:
                                                                      1.2,
                                                                  color: Color(
                                                                      0xFF999DA1),
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                      "yMMMd",
                                                                      listViewMentor15minsSlotsRecord
                                                                          .date),
                                                                  'May 20, 2024',
                                                                ),
                                                                style: MyFlutterTheme.of(
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
                                                              Container(
                                                                height: 32.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .accent2,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      '${dateTimeFormat("jm", listViewMentor15minsSlotsRecord.startTime)} - ${dateTimeFormat("jm", listViewMentor15minsSlotsRecord.endTime)}',
                                                                      '7:10 PM - 7:25 PM',
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            FFButtonWidget(
                                                              onPressed: !((listViewMentor15minsSlotsRecord
                                                                              .startTime! <
                                                                          getCurrentTimestamp) &&
                                                                      (listViewMentor15minsSlotsRecord
                                                                              .endTime! >
                                                                          getCurrentTimestamp))
                                                                  ? null
                                                                  : () async {
                                                                      context
                                                                          .pushNamed(
                                                                        'meetingArea',
                                                                        queryParameters:
                                                                            {
                                                                          'slot15min':
                                                                              serializeParam(
                                                                            listViewMentor15minsSlotsRecord.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                              text: 'join',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 40.0,
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                textStyle: MyFlutterTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Noto Serif',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                disabledColor:
                                                                    const Color(
                                                                        0x3E57636C),
                                                                disabledTextColor:
                                                                    MyFlutterTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    14.0, 18.0, 14.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Mentee\'s',
                                      style: MyFlutterTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          color: MyFlutterTheme.of(context)
                                              .secondaryText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                child: StreamBuilder<
                                    List<Mentor15minsSlotsRecord>>(
                                  stream: queryMentor15minsSlotsRecord(
                                    queryBuilder: (mentor15minsSlotsRecord) =>
                                        mentor15minsSlotsRecord
                                            .where(Filter.and(
                                      Filter(
                                        'mentor',
                                        isEqualTo: currentUserReference,
                                      ),
                                      Filter(
                                        'mentee',
                                        isNotEqualTo: currentUserReference,
                                      ),
                                    )),
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
                                        listViewMentor15minsSlotsRecordList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewMentor15minsSlotsRecordList
                                              .length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewMentor15minsSlotsRecord =
                                            listViewMentor15minsSlotsRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 10.0, 10.0, 0.0),
                                          child: Container(
                                            width: 250.0,
                                            height: 130.0,
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              border: Border.all(
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: StreamBuilder<UsersRecord>(
                                                stream: UsersRecord.getDocument(
                                                    listViewMentor15minsSlotsRecord
                                                        .mentee!),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: SpinKitRipple(
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          size: 50.0,
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  final rowUsersRecord =
                                                      snapshot.data!;

                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'profile',
                                                        queryParameters: {
                                                          'profileDoc':
                                                              serializeParam(
                                                            rowUsersRecord,
                                                            ParamType.Document,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'profileDoc':
                                                              rowUsersRecord,
                                                          kTransitionInfoKey:
                                                              const TransitionInfo(
                                                            hasTransition: true,
                                                            transitionType:
                                                                PageTransitionType
                                                                    .scale,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                          ),
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            fadeOutDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            imageUrl:
                                                                valueOrDefault<
                                                                    String>(
                                                              rowUsersRecord
                                                                  .photoUrl,
                                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                            ),
                                                            width: 82.0,
                                                            height: 110.0,
                                                            fit: BoxFit.cover,
                                                            errorWidget: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                              'assets/images/error_image.PNG',
                                                              width: 82.0,
                                                              height: 110.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  rowUsersRecord
                                                                      .displayName,
                                                                  'No Name',
                                                                ).maybeHandleOverflow(
                                                                  maxChars: 14,
                                                                ),
                                                                style: MyFlutterTheme.of(
                                                                        context)
                                                                    .labelLarge
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
                                                                              .w600,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                width: 80.0,
                                                                child: Divider(
                                                                  thickness:
                                                                      1.2,
                                                                  color: Color(
                                                                      0xFF999DA1),
                                                                ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                      "yMMMd",
                                                                      listViewMentor15minsSlotsRecord
                                                                          .date),
                                                                  'May 20, 2024',
                                                                ),
                                                                style: MyFlutterTheme.of(
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
                                                              Container(
                                                                height: 32.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .accent2,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                  child:
                                                                      AutoSizeText(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      '${dateTimeFormat("jm", listViewMentor15minsSlotsRecord.startTime)} - ${dateTimeFormat("jm", listViewMentor15minsSlotsRecord.endTime)}',
                                                                      '7:10 PM - 7:25 PM',
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            FFButtonWidget(
                                                              onPressed: !((listViewMentor15minsSlotsRecord
                                                                              .startTime! <
                                                                          getCurrentTimestamp) &&
                                                                      (listViewMentor15minsSlotsRecord
                                                                              .endTime! >
                                                                          getCurrentTimestamp))
                                                                  ? null
                                                                  : () async {
                                                                      context
                                                                          .pushNamed(
                                                                        'meetingArea',
                                                                        queryParameters:
                                                                            {
                                                                          'slot15min':
                                                                              serializeParam(
                                                                            listViewMentor15minsSlotsRecord.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                              text: 'join',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 40.0,
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                textStyle: MyFlutterTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Noto Serif',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                disabledColor:
                                                                    const Color(
                                                                        0x3E57636C),
                                                                disabledTextColor:
                                                                    MyFlutterTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: 150.0,
                                decoration: const BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 65.0,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Feed',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.leftToRight,
                                  ),
                                },
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.play_circle,
                                  color: Color(0xAB545353),
                                  size: 26.0,
                                ),
                                Text(
                                  'Feed',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('home');
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.explore,
                                  color: Color(0xAB545353),
                                  size: 26.0,
                                ),
                                Text(
                                  'Explore',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: const Color(0xAB545353),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
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
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Bookings',
                                queryParameters: {
                                  'byNav': serializeParam(
                                    '   Events   ',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.memory_outlined,
                                  color: MyFlutterTheme.of(context).primary,
                                  size: 26.0,
                                ),
                                AutoSizeText(
                                  'Bookings',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color:
                                            MyFlutterTheme.of(context).primary,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'myProfile',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.08,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.08,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        currentUserPhoto,
                                        'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/Talneties%20logo%20-01.PNG?alt=media&token=c5413c49-885b-498c-a64c-05b5cf48e724',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  'me',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: const CircleBorder(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyFlutterTheme.of(context).primary,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.postNewbottomPopup =
                                  !_model.postNewbottomPopup;
                              safeSetState(() {});
                              if (animationsMap[
                                      'iconOnActionTriggerAnimation'] !=
                                  null) {
                                await animationsMap[
                                        'iconOnActionTriggerAnimation']!
                                    .controller
                                    .forward(from: 0.0);
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: MyFlutterTheme.of(context)
                                  .secondaryBackground,
                              size: 50.0,
                            ),
                          ).animateOnActionTrigger(
                            animationsMap['iconOnActionTriggerAnimation']!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (valueOrDefault<bool>(
                _model.postNewbottomPopup != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(-0.01, 0.7),
                  child: Transform.rotate(
                    angle: 45.0 * (math.pi / 180),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF394147),
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.postNewbottomPopup != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(-0.01, 0.62),
                  child: Container(
                    width: 170.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF394147),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'spotlightAdd',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Spotlight',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.video_camera_back_outlined,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'createMeetingsSlots',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Meeting',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.play_circle_outline,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.postNewbottomPopup = false;
                              safeSetState(() {});

                              context.pushNamed('postNewEvent');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Event',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
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
