import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_toggle_icon.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_video_player.dart';
import 'dart:math';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'feed_model.dart';
export 'feed_model.dart';

class FeedWidget extends StatefulWidget {
  /// Tiktok Reels
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> with TickerProviderStateMixin {
  late FeedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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

    animationsMap.addAll({
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: StreamBuilder<List<ReelsRecord>>(
                    stream: FFAppState().feedCache(
                      requestFn: () => queryReelsRecord(
                        queryBuilder: (reelsRecord) => reelsRecord
                            .orderBy('postDateTime', descending: true),
                      ),
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
                      List<ReelsRecord> pageViewReelsRecordList =
                          snapshot.data!;

                      return SizedBox(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.93,
                        child: PageView.builder(
                          controller: _model.pageViewController ??=
                              PageController(
                                  initialPage: max(
                                      0,
                                      min(0,
                                          pageViewReelsRecordList.length - 1))),
                          scrollDirection: Axis.vertical,
                          itemCount: pageViewReelsRecordList.length,
                          itemBuilder: (context, pageViewIndex) {
                            final pageViewReelsRecord =
                                pageViewReelsRecordList[pageViewIndex];
                            return SafeArea(
                              child: ClipRRect(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.93,
                                  decoration: const BoxDecoration(),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, -1.0),
                                          child: MyFlutterVideoPlayer(
                                            path: pageViewReelsRecord
                                                .reelMediaPath,
                                            videoType: VideoType.network,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.03,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.93,
                                            autoPlay: true,
                                            looping: true,
                                            showControls: true,
                                            allowFullScreen: false,
                                            allowPlaybackSpeedMenu: true,
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.77),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: StreamBuilder<
                                                    List<UsersRecord>>(
                                                  stream: queryUsersRecord(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.where(
                                                      'uid',
                                                      isEqualTo:
                                                          pageViewReelsRecord
                                                              .postedBy?.id,
                                                    ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child: SpinKitRipple(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<UsersRecord>
                                                        rowUsersRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final rowUsersRecord =
                                                        rowUsersRecordList
                                                                .isNotEmpty
                                                            ? rowUsersRecordList
                                                                .first
                                                            : null;

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'spotlights',
                                                              queryParameters: {
                                                                'postedBy':
                                                                    serializeParam(
                                                                  pageViewReelsRecord
                                                                      .postedBy,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                kTransitionInfoKey:
                                                                    const TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .leftToRight,
                                                                ),
                                                              },
                                                            );
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: 32.0,
                                                                height: 32.0,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        ?.photoUrl,
                                                                    'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        6.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        ?.displayName,
                                                                    'No Name',
                                                                  ),
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16.0, 4.0, 0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            'Title:${"\n"}${valueOrDefault<String>(
                                                              pageViewReelsRecord
                                                                  .title,
                                                              'no title',
                                                            )}${"\n\n"}Description:${"\n"}${valueOrDefault<String>(
                                                              pageViewReelsRecord
                                                                  .reelDescription,
                                                              'no description',
                                                            )}',
                                                            'null',
                                                          ),
                                                          style: TextStyle(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    5000),
                                                        backgroundColor:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      pageViewReelsRecord.title,
                                                      'no title',
                                                    ),
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.9, 0.62),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ToggleIcon(
                                                    onPressed: () async {
                                                      final likesElement =
                                                          currentUserReference;
                                                      final likesUpdate =
                                                          pageViewReelsRecord
                                                                  .likes
                                                                  .contains(
                                                                      likesElement)
                                                              ? FieldValue
                                                                  .arrayRemove([
                                                                  likesElement
                                                                ])
                                                              : FieldValue
                                                                  .arrayUnion([
                                                                  likesElement
                                                                ]);
                                                      await pageViewReelsRecord
                                                          .reference
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'likes':
                                                                likesUpdate,
                                                          },
                                                        ),
                                                      });
                                                      if (pageViewReelsRecord
                                                              .likes
                                                              .contains(
                                                                  currentUserReference) ==
                                                          true) {
                                                        await pageViewReelsRecord
                                                            .reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'likes': FieldValue
                                                                  .arrayRemove([
                                                                currentUserReference
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                      } else {
                                                        await pageViewReelsRecord
                                                            .reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'likes': FieldValue
                                                                  .arrayUnion([
                                                                currentUserReference
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                      }
                                                    },
                                                    value: pageViewReelsRecord
                                                        .likes
                                                        .contains(
                                                            currentUserReference),
                                                    onIcon: Icon(
                                                      Icons.favorite,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      size: 24.0,
                                                    ),
                                                    offIcon: Icon(
                                                      Icons.favorite_border,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryText,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      formatNumber(
                                                        pageViewReelsRecord
                                                            .likes.length,
                                                        formatType:
                                                            FormatType.compact,
                                                      ),
                                                      '0',
                                                    ),
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 26.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Builder(
                                                      builder: (context) =>
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
                                                          await pageViewReelsRecord
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'shares': FieldValue
                                                                    .arrayUnion([
                                                                  currentUserReference
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          await Share.share(
                                                            'talenties://talenties.com${GoRouterState.of(context).uri.toString()}',
                                                            sharePositionOrigin:
                                                                getWidgetBoundingBox(
                                                                    context),
                                                          );
                                                        },
                                                        child: FaIcon(
                                                          FontAwesomeIcons
                                                              .share,
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              4.0, 0.0, 0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          formatNumber(
                                                            pageViewReelsRecord
                                                                .shares.length,
                                                            formatType:
                                                                FormatType
                                                                    .compact,
                                                          ),
                                                          '0',
                                                        ),
                                                        style:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
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
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.play_circle,
                                  color: MyFlutterTheme.of(context).primary,
                                  size: 26.0,
                                ),
                                Text(
                                  'Feed',
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
                                    color: MyFlutterTheme.of(context)
                                        .secondaryText,
                                    size: 26.0,
                                  ),
                                  AutoSizeText(
                                    'Bookings',
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.08,
                                      height: MediaQuery.sizeOf(context).width *
                                          0.08,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 25.0),
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
                                if (animationsMap[
                                        'iconOnActionTriggerAnimation'] !=
                                    null) {
                                  await animationsMap[
                                          'iconOnActionTriggerAnimation']!
                                      .controller
                                      .forward(from: 0.0);
                                }
                                _model.postNewPopup = !_model.postNewPopup;
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.add,
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                size: 42.0,
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
                  _model.postNewPopup != false,
                  true,
                ))
                  Align(
                    alignment: const AlignmentDirectional(-0.01, 0.77),
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
                  _model.postNewPopup != false,
                  true,
                ))
                  Align(
                    alignment: const AlignmentDirectional(-0.01, 0.69),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                _model.postNewPopup = false;
                                safeSetState(() {});

                                context.pushNamed('postNewEvent');
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
