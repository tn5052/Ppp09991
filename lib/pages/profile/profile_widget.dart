import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/report_widget.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_video_player.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.profileDoc,
  });

  final UsersRecord? profileDoc;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.isRating = false;
      safeSetState(() {});
    });

    _model.tFDisplayNameTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.profileDoc?.displayName,
      'Display Name',
    ));
    _model.tFDisplayNameFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.tFAboutTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.profileDoc?.about,
      'No About',
    ));
    _model.tFAboutFocusNode ??= FocusNode();

    _model.bReviewEditTextController ??= TextEditingController();
    _model.bReviewEditFocusNode ??= FocusNode();

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 160.0.ms,
            duration: 430.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 160.0.ms,
            duration: 430.0.ms,
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
    return StreamBuilder<List<UserRatingRecord>>(
      stream: queryUserRatingRecord(
        queryBuilder: (userRatingRecord) => userRatingRecord.where(
          'mentor',
          isEqualTo: widget.profileDoc?.reference,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitRipple(
                  color: MyFlutterTheme.of(context).primary,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<UserRatingRecord> profileUserRatingRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: MyFlutterIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: MyFlutterTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profile',
                    style: MyFlutterTheme.of(context).headlineMedium.override(
                          fontFamily: 'Noto Serif',
                          color: MyFlutterTheme.of(context).primaryText,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showDialog(
                          barrierColor: const Color(0x30FFB966),
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: const AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: GestureDetector(
                                onTap: () =>
                                    FocusScope.of(dialogContext).unfocus(),
                                child: SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 1.0,
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: ReportWidget(
                                    userID: widget.profileDoc?.reference,
                                    type: 'user',
                                    eventID: null,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0x6AFFA130),
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(
                              widget.profileDoc!.reference),
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

                            final rowUsersRecord = snapshot.data!;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 150.0,
                                  decoration: const BoxDecoration(),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            0.0, 0.0),
                                        child: Container(
                                          width: 125.0,
                                          height: 125.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            fadeInDuration: const Duration(
                                                milliseconds: 100),
                                            fadeOutDuration: const Duration(
                                                milliseconds: 100),
                                            imageUrl: valueOrDefault<String>(
                                              widget.profileDoc?.photoUrl,
                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                            ),
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.PNG',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            0.0, 1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        5.0, 0.0, 0.0, 0.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .tertiary,
                                                  size: 18.0,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        2.0, 2.0, 4.0, 2.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    '${valueOrDefault<String>(
                                                      rowUsersRecord.rating
                                                          .toString(),
                                                      '0',
                                                    )}  (${valueOrDefault<String>(
                                                      formatNumber(
                                                        rowUsersRecord
                                                            .mentorTimesRated,
                                                        formatType:
                                                            FormatType.compact,
                                                      ),
                                                      '0',
                                                    )}) ',
                                                    '0 (0)',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
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
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200.0,
                                      decoration: const BoxDecoration(),
                                      child: TextFormField(
                                        controller:
                                            _model.tFDisplayNameTextController,
                                        focusNode:
                                            _model.tFDisplayNameFocusNode,
                                        autofocus: false,
                                        readOnly: true,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                        style: MyFlutterTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                        maxLength: 14,
                                        buildCounter: (context,
                                                {required currentLength,
                                                required isFocused,
                                                maxLength}) =>
                                            null,
                                        validator: _model
                                            .tFDisplayNameTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 8.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.visibleFollowing = true;
                                              safeSetState(() {});
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      rowUsersRecord
                                                          .followings.length,
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    '0',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontSize: 18.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                                Text(
                                                  'Following',
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30.0,
                                            child: VerticalDivider(
                                              width: 20.0,
                                              thickness: 1.5,
                                              color: Color(0xABA8A8A8),
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.visibleFollowers = true;
                                              safeSetState(() {});
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      rowUsersRecord
                                                          .followers.length,
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    '0',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontSize: 18.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                                Text(
                                                  'Followers',
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 15.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (rowUsersRecord.followers.contains(
                                                  currentUserReference) ==
                                              false)
                                            FFButtonWidget(
                                              onPressed: () async {
                                                await widget
                                                    .profileDoc!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'followers': FieldValue
                                                          .arrayUnion([
                                                        currentUserReference
                                                      ]),
                                                    },
                                                  ),
                                                });

                                                await currentUserReference!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'followings': FieldValue
                                                          .arrayUnion([
                                                        widget.profileDoc
                                                            ?.reference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              },
                                              text: 'Follow',
                                              options: FFButtonOptions(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    MyFlutterTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          if (rowUsersRecord.followers.contains(
                                                  currentUserReference) ==
                                              true)
                                            MyFlutterIconButton(
                                              borderColor:
                                                  MyFlutterTheme.of(context)
                                                      .secondaryText,
                                              borderRadius: 8.0,
                                              borderWidth: 2.0,
                                              buttonSize: 30.0,
                                              fillColor:
                                                  const Color(0x00C6C4C4),
                                              icon: Icon(
                                                Icons.person_remove_outlined,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .secondaryText,
                                                size: 16.0,
                                              ),
                                              onPressed: () async {
                                                await widget
                                                    .profileDoc!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'followers': FieldValue
                                                          .arrayRemove([
                                                        currentUserReference
                                                      ]),
                                                    },
                                                  ),
                                                });

                                                await currentUserReference!
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'followings': FieldValue
                                                          .arrayRemove([
                                                        widget.profileDoc
                                                            ?.reference
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 18.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  color: MyFlutterTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: const Alignment(0.0, 0),
                                      child: TabBar(
                                        labelColor: MyFlutterTheme.of(context)
                                            .primaryText,
                                        unselectedLabelColor:
                                            MyFlutterTheme.of(context)
                                                .secondaryText,
                                        labelStyle: MyFlutterTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                        unselectedLabelStyle: const TextStyle(),
                                        indicatorColor:
                                            MyFlutterTheme.of(context).primary,
                                        padding: const EdgeInsets.all(4.0),
                                        tabs: const [
                                          Tab(
                                            text: 'About',
                                          ),
                                          Tab(
                                            text: 'Event',
                                          ),
                                          Tab(
                                            text: 'Reviews',
                                          ),
                                        ],
                                        controller: _model.tabBarController,
                                        onTap: (i) async {
                                          [
                                            () async {},
                                            () async {},
                                            () async {}
                                          ][i]();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _model.tabBarController,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (currentUserEmail != '')
                                                  Text(
                                                    valueOrDefault<String>(
                                                      widget.profileDoc?.email,
                                                      'email@gmail.com',
                                                    ),
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  child: TextFormField(
                                                    controller: _model
                                                        .tFAboutTextController,
                                                    focusNode:
                                                        _model.tFAboutFocusNode,
                                                    autofocus: false,
                                                    readOnly: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'About',
                                                      labelStyle: MyFlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      hintStyle: MyFlutterTheme
                                                              .of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 4,
                                                    minLines: 1,
                                                    validator: _model
                                                        .tFAboutTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 12.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Interests',
                                                        style:
                                                            MyFlutterTheme.of(
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
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              MyFlutterChoiceChips(
                                                            options: widget
                                                                .profileDoc!
                                                                .interests
                                                                .map((label) =>
                                                                    ChipData(
                                                                        label))
                                                                .toList(),
                                                            onChanged: (val) =>
                                                                safeSetState(() =>
                                                                    _model.choiceChipsValues =
                                                                        val),
                                                            selectedChipStyle:
                                                                ChipStyle(
                                                              backgroundColor:
                                                                  MyFlutterTheme.of(
                                                                          context)
                                                                      .primary,
                                                              textStyle:
                                                                  MyFlutterTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              iconColor: MyFlutterTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              iconSize: 25.0,
                                                              elevation: 4.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                            unselectedChipStyle:
                                                                ChipStyle(
                                                              backgroundColor:
                                                                  MyFlutterTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              textStyle:
                                                                  MyFlutterTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                              iconColor: MyFlutterTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              iconSize: 22.0,
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                            chipSpacing: 12.0,
                                                            rowSpacing: 12.0,
                                                            multiselect: true,
                                                            initialized: _model
                                                                    .choiceChipsValues !=
                                                                null,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            controller: _model
                                                                    .choiceChipsValueController ??=
                                                                FormFieldController<
                                                                    List<
                                                                        String>>(
                                                              (currentUserDocument
                                                                      ?.interests
                                                                      .toList() ??
                                                                  []),
                                                            ),
                                                            wrapped: true,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration:
                                                            const BoxDecoration(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16.0, 6.0, 16.0, 6.0),
                                            child: StreamBuilder<
                                                List<EventsRecord>>(
                                              stream: queryEventsRecord(
                                                queryBuilder: (eventsRecord) =>
                                                    eventsRecord.where(
                                                  'manager',
                                                  isEqualTo: widget
                                                      .profileDoc?.reference,
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
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<EventsRecord>
                                                    listViewEventsRecordList =
                                                    snapshot.data!;
                                                if (listViewEventsRecordList
                                                    .isEmpty) {
                                                  return Center(
                                                    child: Image.asset(
                                                      'assets/images/empty_Box_in_girl_hand_animation.gif',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }

                                                return ListView.separated(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  primary: false,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      listViewEventsRecordList
                                                          .length,
                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(
                                                          height: 10.0),
                                                  itemBuilder:
                                                      (context, listViewIndex) {
                                                    final listViewEventsRecord =
                                                        listViewEventsRecordList[
                                                            listViewIndex];
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
                                                              listViewEventsRecord,
                                                              ParamType
                                                                  .Document,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'docEvent':
                                                                listViewEventsRecord,
                                                          },
                                                        );
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 1.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      listViewEventsRecord
                                                                          .media
                                                                          .first,
                                                                      'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/wizards_Gathering_3dRoom.jpg?alt=media&token=ee109476-abe3-49f3-8f8b-d7d1fc7808b0',
                                                                    ),
                                                                    width: 80.0,
                                                                    height:
                                                                        110.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            12.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  listViewEventsRecord.name,
                                                                                  'Event Name',
                                                                                ),
                                                                                style: MyFlutterTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Noto Serif',
                                                                                      color: MyFlutterTheme.of(context).primaryText,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              Icons.star_outline_rounded,
                                                                              color: MyFlutterTheme.of(context).primary,
                                                                              size: 16.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  listViewEventsRecord.rating.toString(),
                                                                                  '5',
                                                                                ),
                                                                                style: MyFlutterTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Noto Serif',
                                                                                      color: MyFlutterTheme.of(context).secondaryText,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            listViewEventsRecord.description,
                                                                            'Event Description ',
                                                                          ),
                                                                          maxLines:
                                                                              3,
                                                                          style: MyFlutterTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Noto Serif',
                                                                                color: MyFlutterTheme.of(context).secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.location_on_outlined,
                                                                              color: MyFlutterTheme.of(context).primary,
                                                                              size: 16.0,
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    listViewEventsRecord.location?.toString(),
                                                                                    'location',
                                                                                  ),
                                                                                  style: MyFlutterTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Noto Serif',
                                                                                        color: MyFlutterTheme.of(context).primary,
                                                                                        fontSize: 9.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: valueOrDefault<String>(
                                                                                      listViewEventsRecord.currency,
                                                                                      'Pkr',
                                                                                    ),
                                                                                    style: MyFlutterTheme.of(context).bodySmall.override(
                                                                                          fontFamily: 'Noto Serif',
                                                                                          color: MyFlutterTheme.of(context).primary,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                  const TextSpan(
                                                                                    text: '  ',
                                                                                    style: TextStyle(),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: valueOrDefault<String>(
                                                                                      formatNumber(
                                                                                        listViewEventsRecord.price,
                                                                                        formatType: FormatType.compact,
                                                                                      ),
                                                                                      '00',
                                                                                    ),
                                                                                    style: const TextStyle(),
                                                                                  )
                                                                                ],
                                                                                style: MyFlutterTheme.of(context).bodySmall.override(
                                                                                      fontFamily: 'Noto Serif',
                                                                                      color: MyFlutterTheme.of(context).primary,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
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
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20.0, 0.0, 20.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final reviews =
                                                    profileUserRatingRecordList
                                                        .toList();
                                                if (reviews.isEmpty) {
                                                  return Image.asset(
                                                    'assets/images/empty_Box_in_girl_hand_animation.gif',
                                                  );
                                                }

                                                return SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        reviews.length,
                                                        (reviewsIndex) {
                                                      final reviewsItem =
                                                          reviews[reviewsIndex];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(0.0,
                                                                10.0, 0.0, 0.0),
                                                        child: StreamBuilder<
                                                            UsersRecord>(
                                                          stream: UsersRecord
                                                              .getDocument(
                                                                  reviewsItem
                                                                      .mentee!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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

                                                            final containerUsersRecord =
                                                                snapshot.data!;

                                                            return Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 1.0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 125.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            -0.7),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              45.0,
                                                                          height:
                                                                              45.0,
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Image.network(
                                                                            valueOrDefault<String>(
                                                                              containerUsersRecord.photoUrl,
                                                                              'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/Talneties%20logo%20-01.PNG?alt=media&token=c5413c49-885b-498c-a64c-05b5cf48e724',
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorBuilder: (context, error, stackTrace) =>
                                                                                Image.asset(
                                                                              'assets/images/error_image.PNG',
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              12.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        containerUsersRecord.displayName,
                                                                                        'No Name',
                                                                                      ),
                                                                                      style: MyFlutterTheme.of(context).titleMedium.override(
                                                                                            fontFamily: 'Noto Serif',
                                                                                            color: MyFlutterTheme.of(context).primaryText,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        dateTimeFormat("yMMMd", reviewsItem.dateTime),
                                                                                        'No Time',
                                                                                      ),
                                                                                      style: MyFlutterTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Noto Serif',
                                                                                            color: MyFlutterTheme.of(context).secondaryText,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    RatingBarIndicator(
                                                                                      itemBuilder: (context, index) => Icon(
                                                                                        Icons.star_rounded,
                                                                                        color: MyFlutterTheme.of(context).primary,
                                                                                      ),
                                                                                      direction: Axis.horizontal,
                                                                                      rating: valueOrDefault<double>(
                                                                                        reviewsItem.stars.toDouble(),
                                                                                        0.0,
                                                                                      ),
                                                                                      unratedColor: MyFlutterTheme.of(context).accent2,
                                                                                      itemCount: 5,
                                                                                      itemSize: 18.0,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  reviewsItem.review,
                                                                                  'No Review',
                                                                                ),
                                                                                maxLines: 3,
                                                                                style: MyFlutterTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'Noto Serif',
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
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'columnOnPageLoadAnimation']!);
                                              },
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFAFAFA),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Book 1 on 1 eMeeting',
                                          style: MyFlutterTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'bookMeeting',
                                              queryParameters: {
                                                'mentor': serializeParam(
                                                  widget.profileDoc,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'mentor': widget.profileDoc,
                                              },
                                            );
                                          },
                                          text: 'Go ',
                                          icon: const Icon(
                                            Icons.golf_course,
                                            size: 16.0,
                                          ),
                                          options: FFButtonOptions(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: const Color(0xFFEAEBFB),
                                            textStyle: MyFlutterTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  letterSpacing: 0.0,
                                                ),
                                            elevation: 0.0,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.currency_exchange,
                                          color: MyFlutterTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            widget.profileDoc!
                                                        .priceMeetingSlot >
                                                    0.0
                                                ? valueOrDefault<String>(
                                                    formatNumber(
                                                      widget.profileDoc
                                                          ?.priceMeetingSlot,
                                                      formatType:
                                                          FormatType.compact,
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
                                                    MyFlutterTheme.of(context)
                                                        .success,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                      child: StreamBuilder<
                                          List<MentorMeetingSlotsRecord>>(
                                        stream: queryMentorMeetingSlotsRecord(
                                          queryBuilder:
                                              (mentorMeetingSlotsRecord) =>
                                                  mentorMeetingSlotsRecord
                                                      .where(
                                            'mentor',
                                            isEqualTo:
                                                widget.profileDoc?.reference,
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
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<MentorMeetingSlotsRecord>
                                              rowMentorMeetingSlotsRecordList =
                                              snapshot.data!;
                                          if (rowMentorMeetingSlotsRecordList
                                              .isEmpty) {
                                            return Image.asset(
                                              'assets/images/empty_Box_in_girl_hand_animation.gif',
                                            );
                                          }

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  rowMentorMeetingSlotsRecordList
                                                      .length, (rowIndex) {
                                                final rowMentorMeetingSlotsRecord =
                                                    rowMentorMeetingSlotsRecordList[
                                                        rowIndex];
                                                return Container(
                                                  width: 250.0,
                                                  height: 100.0,
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
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              color: MyFlutterTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 20.0,
                                                            ),
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                dateTimeFormat(
                                                                    "yMMMd",
                                                                    rowMentorMeetingSlotsRecord
                                                                        .date),
                                                                'Apr 21, 2024',
                                                              ),
                                                              style: MyFlutterTheme
                                                                      .of(context)
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
                                                          width: 80.0,
                                                          child: Divider(
                                                            thickness: 1.2,
                                                            color: Color(
                                                                0xFF999DA1),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 230.0,
                                                          height: 30.0,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: StreamBuilder<
                                                              List<
                                                                  Mentor15minsSlotsRecord>>(
                                                            stream:
                                                                queryMentor15minsSlotsRecord(
                                                              parent:
                                                                  rowMentorMeetingSlotsRecord
                                                                      .reference,
                                                              queryBuilder:
                                                                  (mentor15minsSlotsRecord) =>
                                                                      mentor15minsSlotsRecord
                                                                          .where(
                                                                'mentee',
                                                                isEqualTo:
                                                                    currentUserReference,
                                                              ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        SpinKitRipple(
                                                                      color: MyFlutterTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<Mentor15minsSlotsRecord>
                                                                  rowMentor15minsSlotsRecordList =
                                                                  snapshot
                                                                      .data!;

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
                                                                    return Stack(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              130.0,
                                                                          height:
                                                                              32.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                MyFlutterTheme.of(context).accent2,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              '${valueOrDefault<String>(
                                                                                dateTimeFormat("jm", rowMentor15minsSlotsRecord.startTime),
                                                                                '10:45 PM',
                                                                              )} - ${valueOrDefault<String>(
                                                                                dateTimeFormat("jm", rowMentor15minsSlotsRecord.endTime),
                                                                                '10:45 PM',
                                                                              )}',
                                                                              '7:10 PM - 7:25 PM',
                                                                            ),
                                                                            style: MyFlutterTheme.of(context).bodySmall.override(
                                                                                  fontFamily: 'Noto Serif',
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }).divide(
                                                                      const SizedBox(
                                                                          width:
                                                                              8.0)),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).divide(
                                                  const SizedBox(width: 12.0)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if ((currentUserDocument?.mentors.toList() ?? [])
                            .contains(widget.profileDoc?.reference))
                          AuthUserStreamWidget(
                            builder: (context) => Container(
                              decoration: const BoxDecoration(),
                              child: Visibility(
                                visible: !(profileUserRatingRecordList
                                    .where(
                                        (e) => e.mentee == currentUserReference)
                                    .toList()
                                    .isNotEmpty),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 3.0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFAFAFA),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Rating',
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (valueOrDefault<bool>(
                                                      _model.isRating == true,
                                                      false,
                                                    ))
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.isRating =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                        text: 'Cancel',
                                                        options:
                                                            FFButtonOptions(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          color: const Color(
                                                              0xFFDEDEDE),
                                                          textStyle:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0),
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                      _model.isRating == true,
                                                      false,
                                                    ))
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(8.0,
                                                                0.0, 0.0, 0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            await widget
                                                                .profileDoc!
                                                                .reference
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'mentorRating':
                                                                      FieldValue.increment(
                                                                          _model
                                                                              .bRatingEditValue!),
                                                                  'mentorTimesRated':
                                                                      FieldValue
                                                                          .increment(
                                                                              1.0),
                                                                },
                                                              ),
                                                            });

                                                            await UserRatingRecord
                                                                .collection
                                                                .doc()
                                                                .set(
                                                                    createUserRatingRecordData(
                                                                  mentor: widget
                                                                      .profileDoc
                                                                      ?.reference,
                                                                  mentee:
                                                                      currentUserReference,
                                                                  stars: _model
                                                                      .bRatingEditValue
                                                                      ?.round(),
                                                                  review: _model
                                                                      .bReviewEditTextController
                                                                      .text,
                                                                  dateTime:
                                                                      getCurrentTimestamp,
                                                                ));
                                                            await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500));
                                                            _model.queryUserDoc =
                                                                await queryUsersRecordOnce(
                                                              queryBuilder:
                                                                  (usersRecord) =>
                                                                      usersRecord
                                                                          .where(
                                                                'uid',
                                                                isEqualTo: widget
                                                                    .profileDoc
                                                                    ?.uid,
                                                              ),
                                                              singleRecord:
                                                                  true,
                                                            ).then((s) => s
                                                                    .firstOrNull);

                                                            await widget
                                                                .profileDoc!
                                                                .reference
                                                                .update(
                                                                    createUsersRecordData(
                                                              rating: valueOrDefault<
                                                                      double>(
                                                                    _model
                                                                        .queryUserDoc
                                                                        ?.mentorRating,
                                                                    1.0,
                                                                  ) /
                                                                  valueOrDefault<
                                                                      double>(
                                                                    _model
                                                                        .queryUserDoc
                                                                        ?.mentorTimesRated,
                                                                    1.0,
                                                                  ),
                                                            ));
                                                            _model.isRating =
                                                                false;
                                                            safeSetState(() {});

                                                            safeSetState(() {});
                                                          },
                                                          text: 'Submit',
                                                          options:
                                                              FFButtonOptions(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    8.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .accent1,
                                                            textStyle:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Noto Serif',
                                                                      color: MyFlutterTheme.of(
                                                                              context)
                                                                          .success,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderSide:
                                                                const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14.0),
                                                          ),
                                                        ),
                                                      ),
                                                    if (valueOrDefault<bool>(
                                                      _model.isRating == false,
                                                      true,
                                                    ))
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.isRating =
                                                              true;
                                                          safeSetState(() {});
                                                        },
                                                        text: 'Review',
                                                        icon: const Icon(
                                                          Icons
                                                              .mode_edit_rounded,
                                                          size: 16.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                          iconPadding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          color: const Color(
                                                              0xFFEAEBFB),
                                                          textStyle:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (_model.isRating == true)
                                                  RatingBar.builder(
                                                    onRatingUpdate: (newValue) =>
                                                        safeSetState(() => _model
                                                                .bRatingEditValue =
                                                            newValue),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                    direction: Axis.horizontal,
                                                    initialRating: _model
                                                            .bRatingEditValue ??=
                                                        3.0,
                                                    unratedColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .accent2,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(10.0, 6.0,
                                                            10.0, 8.0),
                                                    itemSize: 32.0,
                                                    glowColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (_model.isRating == false)
                                                  RatingBarIndicator(
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                    direction: Axis.horizontal,
                                                    rating: 0.0,
                                                    unratedColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .accent2,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .fromLTRB(10.0, 6.0,
                                                            10.0, 8.0),
                                                    itemSize: 32.0,
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Tell others what you think:',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                if (_model.isRating == true)
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .bReviewEditTextController,
                                                      focusNode: _model
                                                          .bReviewEditFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintStyle:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: MyFlutterTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLength: 80,
                                                      maxLengthEnforcement:
                                                          MaxLengthEnforcement
                                                              .enforced,
                                                      cursorColor:
                                                          MyFlutterTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .bReviewEditTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (profileUserRatingRecordList
                            .where((e) => e.mentee == currentUserReference)
                            .toList()
                            .isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 3.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFAFAFA),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Rating',
                                            style: MyFlutterTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (valueOrDefault<bool>(
                                                _model.isRating == true,
                                                false,
                                              ))
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    _model.isRating = false;
                                                    safeSetState(() {});
                                                  },
                                                  text: 'Cancel',
                                                  options: FFButtonOptions(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8.0, 0.0, 8.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    color:
                                                        const Color(0xFFDEDEDE),
                                                    textStyle: MyFlutterTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: MyFlutterTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0.0,
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.0),
                                                  ),
                                                ),
                                              if (valueOrDefault<bool>(
                                                _model.isRating == true,
                                                false,
                                              ))
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      await widget
                                                          .profileDoc!.reference
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'mentorRating': FieldValue.increment(
                                                                -(profileUserRatingRecordList
                                                                    .where((e) =>
                                                                        e.mentee ==
                                                                        currentUserReference)
                                                                    .toList()
                                                                    .first
                                                                    .stars
                                                                    .toDouble())),
                                                          },
                                                        ),
                                                      });

                                                      await widget
                                                          .profileDoc!.reference
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'mentorRating': FieldValue
                                                                .increment(_model
                                                                    .ratingEditValue!),
                                                          },
                                                        ),
                                                      });

                                                      await profileUserRatingRecordList
                                                          .where((e) =>
                                                              e.mentee ==
                                                              currentUserReference)
                                                          .toList()
                                                          .first
                                                          .reference
                                                          .update(
                                                              createUserRatingRecordData(
                                                            mentor: widget
                                                                .profileDoc
                                                                ?.reference,
                                                            mentee:
                                                                currentUserReference,
                                                            stars: _model
                                                                .ratingEditValue
                                                                ?.round(),
                                                            review: _model
                                                                .textController4
                                                                .text,
                                                            dateTime:
                                                                getCurrentTimestamp,
                                                            menteeName:
                                                                currentUserDisplayName,
                                                            menteeImage:
                                                                currentUserPhoto,
                                                          ));
                                                      _model.queryUserDoc1 =
                                                          await UsersRecord
                                                              .getDocumentOnce(
                                                                  widget
                                                                      .profileDoc!
                                                                      .reference);

                                                      await widget
                                                          .profileDoc!.reference
                                                          .update(
                                                              createUsersRecordData(
                                                        rating: valueOrDefault<
                                                                double>(
                                                              _model
                                                                  .queryUserDoc1
                                                                  ?.mentorRating,
                                                              1.0,
                                                            ) /
                                                            valueOrDefault<
                                                                double>(
                                                              _model
                                                                  .queryUserDoc1
                                                                  ?.mentorTimesRated,
                                                              1.0,
                                                            ),
                                                      ));
                                                      _model.isRating = false;
                                                      safeSetState(() {});

                                                      safeSetState(() {});
                                                    },
                                                    text: 'Submit',
                                                    options: FFButtonOptions(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(8.0,
                                                              0.0, 8.0, 0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              0.0, 0.0, 0.0),
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .accent1,
                                                      textStyle:
                                                          MyFlutterTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Noto Serif',
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .success,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      elevation: 0.0,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                    ),
                                                  ),
                                                ),
                                              if (valueOrDefault<bool>(
                                                _model.isRating == false,
                                                true,
                                              ))
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    _model.isRating = true;
                                                    safeSetState(() {});
                                                  },
                                                  text: 'Edit',
                                                  icon: const Icon(
                                                    Icons.mode_edit_rounded,
                                                    size: 16.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            8.0, 0.0, 8.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    color:
                                                        const Color(0xFFEAEBFB),
                                                    textStyle: MyFlutterTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .primary,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0.0,
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.0),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.isRating == true)
                                            RatingBar.builder(
                                              onRatingUpdate: (newValue) =>
                                                  safeSetState(() =>
                                                      _model.ratingEditValue =
                                                          newValue),
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                              ),
                                              direction: Axis.horizontal,
                                              initialRating: _model
                                                      .ratingEditValue ??=
                                                  profileUserRatingRecordList
                                                      .where((e) =>
                                                          e.mentee ==
                                                          currentUserReference)
                                                      .toList()
                                                      .first
                                                      .stars
                                                      .toDouble(),
                                              unratedColor:
                                                  MyFlutterTheme.of(context)
                                                      .accent2,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 6.0, 10.0, 8.0),
                                              itemSize: 32.0,
                                              glowColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                            ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (_model.isRating == false)
                                            RatingBarIndicator(
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                              ),
                                              direction: Axis.horizontal,
                                              rating:
                                                  profileUserRatingRecordList
                                                      .where((e) =>
                                                          e.mentee ==
                                                          currentUserReference)
                                                      .toList()
                                                      .first
                                                      .stars
                                                      .toDouble(),
                                              unratedColor:
                                                  MyFlutterTheme.of(context)
                                                      .accent2,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      10.0, 6.0, 10.0, 8.0),
                                              itemSize: 32.0,
                                            ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tell others what you think:',
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          if (_model.isRating == true)
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                controller:
                                                    _model.textController4 ??=
                                                        TextEditingController(
                                                  text: profileUserRatingRecordList
                                                      .where((e) =>
                                                          e.mentee ==
                                                          currentUserReference)
                                                      .toList()
                                                      .first
                                                      .review,
                                                ),
                                                focusNode:
                                                    _model.textFieldFocusNode1,
                                                autofocus: false,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      MyFlutterTheme.of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintStyle:
                                                      MyFlutterTheme.of(context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryText,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryBackground,
                                                ),
                                                style: MyFlutterTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                                maxLength: 80,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                cursorColor:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                validator: _model
                                                    .textController4Validator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          if (_model.isRating == false)
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -1.0, 0.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 6.0, 0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    profileUserRatingRecordList
                                                        .where((e) =>
                                                            e.mentee ==
                                                            currentUserReference)
                                                        .toList()
                                                        .first
                                                        .review,
                                                    'No Review',
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
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 18.0, 12.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Important Links',
                                      style: MyFlutterTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 290.0,
                                ),
                                decoration: const BoxDecoration(),
                                child: Builder(
                                  builder: (context) {
                                    final linksProfile = widget
                                            .profileDoc?.links
                                            .map((e) => e)
                                            .toList()
                                            .toList() ??
                                        [];

                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: linksProfile.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 14.0),
                                      itemBuilder:
                                          (context, linksProfileIndex) {
                                        final linksProfileItem =
                                            linksProfile[linksProfileIndex];
                                        return Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await launchURL(linksProfileItem);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                    await Clipboard.setData(
                                                        ClipboardData(
                                                            text:
                                                                linksProfileItem));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Link Copied',
                                                          style: TextStyle(
                                                            color: MyFlutterTheme
                                                                    .of(context)
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
                                                                .secondaryText,
                                                      ),
                                                    );
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.link,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 16.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Builder(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  linksProfileItem);
                                                            },
                                                            onLongPress:
                                                                () async {
                                                              await Share.share(
                                                                linksProfileItem,
                                                                sharePositionOrigin:
                                                                    getWidgetBoundingBox(
                                                                        context),
                                                              );
                                                            },
                                                            child: Text(
                                                              linksProfileItem,
                                                              style: MyFlutterTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              6.0, 12.0, 6.0, 0.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Spotlights',
                                          style: MyFlutterTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'spotlights',
                                              queryParameters: {
                                                'postedBy': serializeParam(
                                                  widget.profileDoc?.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Text(
                                            'View All',
                                            style: MyFlutterTheme.of(context)
                                                .titleMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 0.0),
                                      child: StreamBuilder<List<ReelsRecord>>(
                                        stream: queryReelsRecord(
                                          queryBuilder: (reelsRecord) =>
                                              reelsRecord.where(
                                            'postedBy',
                                            isEqualTo:
                                                widget.profileDoc?.reference,
                                          ),
                                          limit: 3,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: SpinKitRipple(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }
                                          List<ReelsRecord> rowReelsRecordList =
                                              snapshot.data!;
                                          if (rowReelsRecordList.isEmpty) {
                                            return Image.asset(
                                              'assets/images/empty_Box_in_girl_hand_animation.gif',
                                            );
                                          }

                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                rowReelsRecordList.length,
                                                (rowIndex) {
                                              final rowReelsRecord =
                                                  rowReelsRecordList[rowIndex];
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.29,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.5,
                                                    decoration: BoxDecoration(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                    ),
                                                    child: MyFlutterVideoPlayer(
                                                      path: rowReelsRecord
                                                          .reelMediaPath,
                                                      videoType:
                                                          VideoType.network,
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.84,
                                                      autoPlay: false,
                                                      looping: true,
                                                      showControls: true,
                                                      allowFullScreen: true,
                                                      allowPlaybackSpeedMenu:
                                                          false,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(),
                        ),
                      ],
                    ),
                  ),
                  if (valueOrDefault<bool>(
                    _model.visibleFollowers != false,
                    true,
                  ))
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0x52909090),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.visibleFollowers = false;
                                safeSetState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(
                                      width: 60.0,
                                      child: Divider(
                                        thickness: 3.0,
                                        color: Color(0x9457636C),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  formatNumber(
                                                    widget.profileDoc?.followers
                                                        .length,
                                                    formatType:
                                                        FormatType.compact,
                                                  ),
                                                  '0',
                                                ),
                                                style: MyFlutterTheme.of(
                                                        context)
                                                    .headlineSmall
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              const TextSpan(
                                                text: '    Followers',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4.0, 4.0, 4.0, 4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: const Color(0x7E394147),
                                            width: 1.8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController5,
                                                  focusNode: _model
                                                      .textFieldFocusNode2,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText: 'Search',
                                                    labelStyle: MyFlutterTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintStyle: MyFlutterTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                  validator: _model
                                                      .textController5Validator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.search,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.57,
                                      decoration: const BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final followersList = widget
                                                  .profileDoc?.followers
                                                  .toList() ??
                                              [];

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: followersList.length,
                                            itemBuilder:
                                                (context, followersListIndex) {
                                              final followersListItem =
                                                  followersList[
                                                      followersListIndex];
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 12.0, 0.0, 0.0),
                                                child: StreamBuilder<
                                                    List<UsersRecord>>(
                                                  stream: queryUsersRecord(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.where(
                                                      'uid',
                                                      isEqualTo:
                                                          followersListItem.id,
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 55.0,
                                                              height: 55.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
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
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      rowUsersRecord
                                                                          ?.displayName,
                                                                      'No Name',
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
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        rowUsersRecord
                                                                            ?.email,
                                                                        'No Email',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
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
                          ],
                        ),
                      ),
                    ),
                  if (valueOrDefault<bool>(
                    _model.visibleFollowing != false,
                    true,
                  ))
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0x52909090),
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.visibleFollowing = false;
                                safeSetState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 6.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(
                                      width: 60.0,
                                      child: Divider(
                                        thickness: 3.0,
                                        color: Color(0x9457636C),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  formatNumber(
                                                    widget.profileDoc
                                                        ?.followings.length,
                                                    formatType:
                                                        FormatType.compact,
                                                  ),
                                                  '0',
                                                ),
                                                style: MyFlutterTheme.of(
                                                        context)
                                                    .headlineSmall
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              const TextSpan(
                                                text: '    Following',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4.0, 4.0, 4.0, 4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: const Color(0x7E394147),
                                            width: 1.8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController6,
                                                  focusNode: _model
                                                      .textFieldFocusNode3,
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText: 'Search',
                                                    labelStyle: MyFlutterTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintStyle: MyFlutterTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                  validator: _model
                                                      .textController6Validator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.search,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.57,
                                      decoration: const BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final followingList = widget
                                                  .profileDoc?.followings
                                                  .toList() ??
                                              [];

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: followingList.length,
                                            itemBuilder:
                                                (context, followingListIndex) {
                                              final followingListItem =
                                                  followingList[
                                                      followingListIndex];
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0.0, 12.0, 0.0, 0.0),
                                                child: StreamBuilder<
                                                    List<UsersRecord>>(
                                                  stream: queryUsersRecord(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.where(
                                                      'uid',
                                                      isEqualTo:
                                                          followingListItem.id,
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: 55.0,
                                                              height: 55.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
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
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      rowUsersRecord
                                                                          ?.displayName,
                                                                      'No Name',
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
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        rowUsersRecord
                                                                            ?.email,
                                                                        'No Email',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
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
                          ],
                        ),
                      ),
                    ),
                  if (widget.profileDoc?.status == 'ban')
                    Container(
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 50.0, 0.0, 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.ban,
                              color: MyFlutterTheme.of(context).error,
                              size: 90.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 0.0),
                            child: Text(
                              'User currently unavailable!\n\nContact Support for more details.',
                              textAlign: TextAlign.center,
                              style: MyFlutterTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 40.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Clipboard.setData(const ClipboardData(
                                    text: 'Jaaneabubakar1@gmail.com'));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_email,
                                    color: MyFlutterTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Jaaneabubakar1@gmail.com',
                                      style: MyFlutterTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
