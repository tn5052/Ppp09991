import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/text_filed_component/text_filed_component_widget.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_video_player.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import '/my_flutter/upload_data.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'my_profile_model.dart';
export 'my_profile_model.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({super.key});

  @override
  State<MyProfileWidget> createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget>
    with TickerProviderStateMixin {
  late MyProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyProfileModel());

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

    _model.tFDisplayNameTextController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.tFDisplayNameFocusNode ??= FocusNode();

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.tFAboutTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.about, ''));
    _model.tFAboutFocusNode ??= FocusNode();

    _model.tFAddLinkTextTextController ??= TextEditingController();
    _model.tFAddLinkTextFocusNode ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    animationsMap.addAll({
      'listViewOnPageLoadAnimation': AnimationInfo(
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
                'My Profile',
                style: MyFlutterTheme.of(context).headlineMedium.override(
                      fontFamily: 'Noto Serif',
                      color: MyFlutterTheme.of(context).primaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: MediaQuery.sizeOf(context).height * 0.18,
                          decoration: const BoxDecoration(),
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: 125.0,
                                    height: 125.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 100),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 100),
                                      imageUrl: valueOrDefault<String>(
                                        currentUserPhoto,
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
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 1.0),
                                child: StreamBuilder<List<UsersRecord>>(
                                  stream: queryUsersRecord(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.where(
                                      'uid',
                                      isEqualTo: currentUserReference?.id,
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
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            size: 50.0,
                                          ),
                                        ),
                                      );
                                    }
                                    List<UsersRecord> containerUsersRecordList =
                                        snapshot.data!;
                                    // Return an empty Container when the item does not exist.
                                    if (snapshot.data!.isEmpty) {
                                      return Container();
                                    }
                                    final containerUsersRecord =
                                        containerUsersRecordList.isNotEmpty
                                            ? containerUsersRecordList.first
                                            : null;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            MyFlutterTheme.of(context).primary,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Color(0xFFFFD830),
                                              size: 18.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                '${valueOrDefault<String>(
                                                  containerUsersRecord?.rating
                                                      .toString(),
                                                  '0',
                                                )}  (${valueOrDefault<String>(
                                                  formatNumber(
                                                    containerUsersRecord
                                                        ?.mentorTimesRated,
                                                    formatType:
                                                        FormatType.compact,
                                                  ),
                                                  '0',
                                                )}) ',
                                                '0 (0)',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (valueOrDefault<bool>(
                                _model.profileEdit != false,
                                true,
                              ))
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          imageQuality: 50,
                                          allowPhoto: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() =>
                                              _model.isDataUploading1 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            _model.isDataUploading1 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile1 =
                                                  selectedUploadedFiles.first;
                                            });
                                          } else {
                                            safeSetState(() {});
                                            return;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: 125.0,
                                        height: 125.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.memory(
                                          _model.uploadedLocalFile1.bytes ??
                                              Uint8List.fromList([]),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.PNG',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
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
                            Align(
                              alignment: const AlignmentDirectional(1.0, -1.0),
                              child: Container(
                                width: 200.0,
                                decoration: const BoxDecoration(),
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(1.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (valueOrDefault<bool>(
                                        _model.profileEdit == true,
                                        true,
                                      ))
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.profileEdit = false;
                                            safeSetState(() {});
                                            safeSetState(() {
                                              _model.tFDisplayNameTextController
                                                      ?.text =
                                                  currentUserDisplayName;
                                            });
                                            safeSetState(() {
                                              _model.isDataUploading1 = false;
                                              _model.uploadedLocalFile1 =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []));
                                            });
                                          },
                                          text: 'Cancel',
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                            color: MyFlutterTheme.of(context)
                                                .secondaryText,
                                            size: 16.0,
                                          ),
                                          options: FFButtonOptions(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: const Color(0x71CBCBCB),
                                            textStyle: MyFlutterTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryText,
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
                                      if (valueOrDefault<bool>(
                                        _model.profileEdit == true,
                                        true,
                                      ))
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(6.0, 0.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              _model.profileEdit = false;
                                              safeSetState(() {});
                                              if ((_model.uploadedLocalFile1
                                                      .bytes?.isNotEmpty ??
                                                  false)) {
                                                {
                                                  safeSetState(() => _model
                                                      .isDataUploading2 = true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];
                                                  var selectedMedia =
                                                      <SelectedFile>[];
                                                  var downloadUrls = <String>[];
                                                  try {
                                                    showUploadMessage(
                                                      context,
                                                      'Uploading file...',
                                                      showLoading: true,
                                                    );
                                                    selectedUploadedFiles = _model
                                                            .uploadedLocalFile1
                                                            .bytes!
                                                            .isNotEmpty
                                                        ? [
                                                            _model
                                                                .uploadedLocalFile1
                                                          ]
                                                        : <FFUploadedFile>[];
                                                    selectedMedia =
                                                        selectedFilesFromUploadedFiles(
                                                      selectedUploadedFiles,
                                                    );
                                                    downloadUrls = (await Future
                                                            .wait(
                                                      selectedMedia.map(
                                                        (m) async =>
                                                            await uploadData(
                                                                m.storagePath,
                                                                m.bytes),
                                                      ),
                                                    ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                                  } finally {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    _model.isDataUploading2 =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length &&
                                                      downloadUrls.length ==
                                                          selectedMedia
                                                              .length) {
                                                    safeSetState(() {
                                                      _model.uploadedLocalFile2 =
                                                          selectedUploadedFiles
                                                              .first;
                                                      _model.uploadedFileUrl2 =
                                                          downloadUrls.first;
                                                    });
                                                    showUploadMessage(
                                                        context, 'Success!');
                                                  } else {
                                                    safeSetState(() {});
                                                    showUploadMessage(context,
                                                        'Failed to upload data');
                                                    return;
                                                  }
                                                }

                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  displayName: _model
                                                      .tFDisplayNameTextController
                                                      .text,
                                                  photoUrl:
                                                      _model.uploadedFileUrl2,
                                                ));
                                              } else {
                                                await currentUserReference!
                                                    .update(
                                                        createUsersRecordData(
                                                  displayName: _model
                                                      .tFDisplayNameTextController
                                                      .text,
                                                ));
                                              }
                                            },
                                            text: 'Save',
                                            icon: const Icon(
                                              Icons.save_outlined,
                                              color: Color(0xC6084E30),
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
                                              color: MyFlutterTheme.of(context)
                                                  .accent1,
                                              textStyle: MyFlutterTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0xFF084E30),
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
                                        ),
                                      if (valueOrDefault<bool>(
                                        _model.profileEdit == false,
                                        true,
                                      ))
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.profileEdit = true;
                                            safeSetState(() {});
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.edit,
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            size: 18.0,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 200.0,
                              decoration: const BoxDecoration(),
                              child: AuthUserStreamWidget(
                                builder: (context) => TextFormField(
                                  controller:
                                      _model.tFDisplayNameTextController,
                                  focusNode: _model.tFDisplayNameFocusNode,
                                  autofocus: false,
                                  readOnly: _model.profileEdit == false,
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
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            valueOrDefault<String>(
                                              formatNumber(
                                                (currentUserDocument?.followings
                                                            .toList() ??
                                                        [])
                                                    .length,
                                                formatType: FormatType.compact,
                                              ),
                                              '0',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Following',
                                          style: MyFlutterTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Noto Serif',
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
                                        AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            valueOrDefault<String>(
                                              formatNumber(
                                                (currentUserDocument?.followers
                                                            .toList() ??
                                                        [])
                                                    .length,
                                                formatType: FormatType.compact,
                                              ),
                                              '0',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          'Followers',
                                          style: MyFlutterTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
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
                      ],
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
                                    labelColor:
                                        MyFlutterTheme.of(context).primaryText,
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
                                                currentUserEmail,
                                                style:
                                                    MyFlutterTheme.of(context)
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
                                              child: AuthUserStreamWidget(
                                                builder: (context) =>
                                                    TextFormField(
                                                  controller: _model
                                                      .tFAboutTextController,
                                                  focusNode:
                                                      _model.tFAboutFocusNode,
                                                  autofocus: false,
                                                  readOnly:
                                                      _model.aboutEdit == false,
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
                                                  style:
                                                      MyFlutterTheme.of(context)
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
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 12.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                            0.0, 0.0),
                                                    child: Text(
                                                      'Interests',
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (valueOrDefault<bool>(
                                                        _model.aboutEdit ==
                                                            true,
                                                        true,
                                                      ))
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.aboutEdit =
                                                                false;
                                                            safeSetState(() {});
                                                            safeSetState(() {
                                                              _model.tFAboutTextController
                                                                      ?.text =
                                                                  valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.about,
                                                                      '');
                                                            });
                                                            safeSetState(() {
                                                              _model
                                                                  .choiceChipsValueController
                                                                  ?.reset();
                                                            });
                                                          },
                                                          text: 'Cancel',
                                                          icon: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .secondaryText,
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
                                                                0x71CBCBCB),
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
                                                        _model.aboutEdit ==
                                                            true,
                                                        true,
                                                      ))
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  6.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.aboutEdit =
                                                                  false;
                                                              safeSetState(
                                                                  () {});

                                                              await currentUserReference!
                                                                  .update({
                                                                ...createUsersRecordData(
                                                                  about: _model
                                                                      .tFAboutTextController
                                                                      .text,
                                                                  interestsCombined:
                                                                      valueOrDefault<
                                                                          String>(
                                                                    functions.combineListToSingleString(_model
                                                                        .choiceChipsValues
                                                                        ?.toList()),
                                                                    'None',
                                                                  ),
                                                                ),
                                                                ...mapToFirestore(
                                                                  {
                                                                    'interests':
                                                                        _model
                                                                            .choiceChipsValues,
                                                                  },
                                                                ),
                                                              });
                                                            },
                                                            text: 'Save',
                                                            icon: const Icon(
                                                              Icons
                                                                  .save_outlined,
                                                              color: Color(
                                                                  0xC6084E30),
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
                                                                        color: const Color(
                                                                            0xFF084E30),
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
                                                        _model.aboutEdit ==
                                                            false,
                                                        true,
                                                      ))
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.aboutEdit =
                                                                true;
                                                            safeSetState(() {});
                                                          },
                                                          text: 'Chanage',
                                                          icon: const Icon(
                                                            Icons.mode,
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
                                            ),
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          MyFlutterChoiceChips(
                                                        options: const [
                                                          ChipData('Tech',
                                                              Icons.terminal),
                                                          ChipData(
                                                              'Business',
                                                              Icons
                                                                  .business_center_sharp),
                                                          ChipData('Health',
                                                              Icons.healing),
                                                          ChipData(
                                                              'Entertainment',
                                                              Icons
                                                                  .live_tv_rounded),
                                                          ChipData(
                                                              'Sports',
                                                              Icons
                                                                  .sports_score)
                                                        ],
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
                                                                    color: MyFlutterTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          iconColor:
                                                              MyFlutterTheme.of(
                                                                      context)
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
                                                            WrapAlignment.start,
                                                        controller: _model
                                                                .choiceChipsValueController ??=
                                                            FormFieldController<
                                                                List<String>>(
                                                          (currentUserDocument
                                                                  ?.interests
                                                                  .toList() ??
                                                              []),
                                                        ),
                                                        wrapped: true,
                                                      ),
                                                    ),
                                                  ),
                                                  if (_model.aboutEdit == false)
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
                                        child:
                                            StreamBuilder<List<EventsRecord>>(
                                          stream: queryEventsRecord(
                                            queryBuilder: (eventsRecord) =>
                                                eventsRecord.where(
                                              'manager',
                                              isEqualTo: currentUserReference,
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
                                                    color: MyFlutterTheme.of(
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

                                            return ListView.separated(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              primary: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewEventsRecordList
                                                      .length,
                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(height: 10.0),
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
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'docEvent':
                                                            listViewEventsRecord,
                                                      },
                                                    );
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 1.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 120.0,
                                                      decoration: BoxDecoration(
                                                        color: MyFlutterTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(12.0,
                                                                0.0, 12.0, 0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  listViewEventsRecord
                                                                      .media
                                                                      .first,
                                                                  'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/wizards_Gathering_3dRoom.jpg?alt=media&token=ee109476-abe3-49f3-8f8b-d7d1fc7808b0',
                                                                ),
                                                                width: 80.0,
                                                                height: 110.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.asset(
                                                                  'assets/images/error_image.PNG',
                                                                  width: 80.0,
                                                                  height: 110.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        12.0),
                                                                child: Column(
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
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
                                                                          Icons
                                                                              .star_outline_rounded,
                                                                          color:
                                                                              MyFlutterTheme.of(context).primary,
                                                                          size:
                                                                              16.0,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              2.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
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
                                                                        listViewEventsRecord
                                                                            .description,
                                                                        'Event Description ',
                                                                      ),
                                                                      maxLines:
                                                                          3,
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            color:
                                                                                MyFlutterTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .location_on_outlined,
                                                                          color:
                                                                              MyFlutterTheme.of(context).primary,
                                                                          size:
                                                                              16.0,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                4.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
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
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
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
                                        child: StreamBuilder<
                                            List<UserRatingRecord>>(
                                          stream: queryUserRatingRecord(
                                            queryBuilder: (userRatingRecord) =>
                                                userRatingRecord.where(
                                              'mentor',
                                              isEqualTo: currentUserReference,
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
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 50.0,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<UserRatingRecord>
                                                listViewUserRatingRecordList =
                                                snapshot.data!;
                                            if (listViewUserRatingRecordList
                                                .isEmpty) {
                                              return Image.asset(
                                                'assets/images/empty_Box_in_girl_hand_animation.gif',
                                              );
                                            }

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewUserRatingRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewUserRatingRecord =
                                                    listViewUserRatingRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: StreamBuilder<
                                                      UsersRecord>(
                                                    stream: UsersRecord.getDocument(
                                                        listViewUserRatingRecord
                                                            .mentee!),
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
                                                              color: MyFlutterTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 50.0,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      final containerUsersRecord =
                                                          snapshot.data!;

                                                      return Material(
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
                                                          height: 125.0,
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
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          -0.7),
                                                                  child:
                                                                      Container(
                                                                    width: 45.0,
                                                                    height:
                                                                        45.0,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        containerUsersRecord
                                                                            .photoUrl,
                                                                        'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/Talneties%20logo%20-01.PNG?alt=media&token=c5413c49-885b-498c-a64c-05b5cf48e724',
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.PNG',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
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
                                                                                  dateTimeFormat("yMMMd", listViewUserRatingRecord.dateTime),
                                                                                  'Sep 26, 2024',
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
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              0.0,
                                                                              2.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              RatingBarIndicator(
                                                                                itemBuilder: (context, index) => Icon(
                                                                                  Icons.star_rounded,
                                                                                  color: MyFlutterTheme.of(context).primary,
                                                                                ),
                                                                                direction: Axis.horizontal,
                                                                                rating: listViewUserRatingRecord.stars.toDouble(),
                                                                                unratedColor: MyFlutterTheme.of(context).accent2,
                                                                                itemCount: 5,
                                                                                itemSize: 18.0,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          listViewUserRatingRecord
                                                                              .review,
                                                                          maxLines:
                                                                              3,
                                                                          style: MyFlutterTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
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
                                              },
                                            ).animateOnPageLoad(animationsMap[
                                                'listViewOnPageLoadAnimation']!);
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 4.0, 0.0),
                                          child: Icon(
                                            Icons.edit_calendar,
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            size: 22.0,
                                          ),
                                        ),
                                        Text(
                                          'Created 1 on 1 eMeeting',
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
                                      ],
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        context
                                            .pushNamed('createMeetingsSlots');
                                      },
                                      text: 'Edit',
                                      icon: const Icon(
                                        Icons.mode_edit,
                                        size: 16.0,
                                      ),
                                      options: FFButtonOptions(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                        currentUserReference,
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
                                              MainAxisAlignment.spaceBetween,
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
                                                color:
                                                    MyFlutterTheme.of(context)
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
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
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
                                                      width: 80.0,
                                                      child: Divider(
                                                        thickness: 1.2,
                                                        color:
                                                            Color(0xFF999DA1),
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
                                                                      )
                                                                      .orderBy(
                                                                          'startTime'),
                                                        ),
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
                                                                return Stack(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          130.0,
                                                                      height:
                                                                          32.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: rowMentor15minsSlotsRecord.mentee !=
                                                                                null
                                                                            ? const Color(0xFFABACAD)
                                                                            : MyFlutterTheme.of(context).accent2,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          '${valueOrDefault<String>(
                                                                            dateTimeFormat("jm",
                                                                                rowMentor15minsSlotsRecord.startTime),
                                                                            '10:45 PM',
                                                                          )} - ${valueOrDefault<String>(
                                                                            dateTimeFormat("jm",
                                                                                rowMentor15minsSlotsRecord.startTime),
                                                                            '10:45 PM',
                                                                          )}',
                                                                          '7:10 PM - 7:25 PM',
                                                                        ),
                                                                        style: MyFlutterTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 18.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (valueOrDefault<bool>(
                                    _model.linksEdit == true,
                                    false,
                                  ))
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.linksEdit = false;
                                        safeSetState(() {});

                                        await currentUserReference!.update({
                                          ...mapToFirestore(
                                            {
                                              'links': _model.linksGit,
                                            },
                                          ),
                                        });
                                        safeSetState(() {
                                          _model.tFAddLinkTextTextController
                                              ?.clear();
                                        });
                                      },
                                      text: 'Cancel',
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        size: 16.0,
                                      ),
                                      options: FFButtonOptions(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                    ),
                                  if (valueOrDefault<bool>(
                                    _model.linksEdit == true,
                                    false,
                                  ))
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              6.0, 0.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (_model.tFAddLinkTextTextController
                                                  .text !=
                                              '') {
                                            await currentUserReference!.update({
                                              ...mapToFirestore(
                                                {
                                                  'links':
                                                      FieldValue.arrayUnion([
                                                    _model
                                                        .tFAddLinkTextTextController
                                                        .text
                                                  ]),
                                                },
                                              ),
                                            });
                                          }
                                          safeSetState(() {
                                            _model.tFAddLinkTextTextController
                                                ?.clear();
                                          });
                                          _model.linksEdit = false;
                                          safeSetState(() {});
                                        },
                                        text: 'Save',
                                        icon: const Icon(
                                          Icons.save_outlined,
                                          color: Color(0xC6084E30),
                                          size: 16.0,
                                        ),
                                        options: FFButtonOptions(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: MyFlutterTheme.of(context)
                                              .accent1,
                                          textStyle: MyFlutterTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color: const Color(0xFF084E30),
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
                                    ),
                                  if (valueOrDefault<bool>(
                                    _model.linksEdit == false,
                                    true,
                                  ))
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.linksGit = (currentUserDocument
                                                    ?.links
                                                    .toList() ??
                                                [])
                                            .toList()
                                            .cast<String>();
                                        safeSetState(() {});
                                        _model.linksEdit = true;
                                        safeSetState(() {});
                                      },
                                      text: 'Edit',
                                      icon: const Icon(
                                        Icons.mode_edit,
                                        size: 16.0,
                                      ),
                                      options: FFButtonOptions(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                        iconPadding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (valueOrDefault<bool>(
                          _model.linksEdit == true,
                          false,
                        ))
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.95,
                              child: TextFormField(
                                controller: _model.tFAddLinkTextTextController,
                                focusNode: _model.tFAddLinkTextFocusNode,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: '+ New link',
                                  labelStyle: MyFlutterTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
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
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyFlutterTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyFlutterTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyFlutterTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                style: MyFlutterTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      color: MyFlutterTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                    ),
                                validator: _model
                                    .tFAddLinkTextTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 290.0,
                          ),
                          decoration: const BoxDecoration(),
                          child: AuthUserStreamWidget(
                            builder: (context) => Builder(
                              builder: (context) {
                                final links =
                                    (currentUserDocument?.links.toList() ?? [])
                                        .toList();

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: links.length,
                                  itemBuilder: (context, linksIndex) {
                                    final linksItem = links[linksIndex];
                                    return Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 12.0, 5.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (valueOrDefault<bool>(
                                              _model.linksEdit == true,
                                              false,
                                            ))
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        4.0, 0.0, 0.0, 0.0),
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
                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'links': FieldValue
                                                              .arrayRemove(
                                                                  [linksItem]),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .error,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.87,
                                              decoration: const BoxDecoration(),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onLongPress: () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: linksItem));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Link Copied ',
                                                        style: TextStyle(
                                                          color: MyFlutterTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 1500),
                                                      backgroundColor:
                                                          MyFlutterTheme.of(
                                                                  context)
                                                              .primary,
                                                    ),
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model
                                                      .textFiledComponentModels
                                                      .getModel(
                                                    linksIndex.toString(),
                                                    linksIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child:
                                                      TextFiledComponentWidget(
                                                    key: Key(
                                                      'Key7jg_${linksIndex.toString()}',
                                                    ),
                                                    linkText: linksItem,
                                                    linkEditParameter:
                                                        !_model.linksEdit,
                                                  ),
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
                            padding: const EdgeInsets.all(9.0),
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
                                            color: MyFlutterTheme.of(context)
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
                                              currentUserReference,
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
                                              color: MyFlutterTheme.of(context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: StreamBuilder<List<ReelsRecord>>(
                                    stream: queryReelsRecord(
                                      queryBuilder: (reelsRecord) =>
                                          reelsRecord.where(
                                        'postedBy',
                                        isEqualTo: currentUserReference,
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
                                              color: MyFlutterTheme.of(context)
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.29,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                ),
                                                child: MyFlutterVideoPlayer(
                                                  path: rowReelsRecord
                                                      .reelMediaPath,
                                                  videoType: VideoType.network,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.84,
                                                  autoPlay: false,
                                                  looping: true,
                                                  showControls: true,
                                                  allowFullScreen: true,
                                                  allowPlaybackSpeedMenu: false,
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 20.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();

                          context.goNamedAuth('onBoarding', context.mounted);
                        },
                        text: 'Log out',
                        options: FFButtonOptions(
                          height: 30.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 14.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: MyFlutterTheme.of(context).secondaryBackground,
                          textStyle:
                              MyFlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: MyFlutterTheme.of(context).primary,
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
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
                                  color:
                                      MyFlutterTheme.of(context).secondaryText,
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
                                        color:
                                            MyFlutterTheme.of(context).primary,
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
                              _model.postNewPopup = !_model.postNewPopup;
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
                              size: 60.0,
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
                _model.postNewPopup != false,
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
                              _model.postNewPopup = !_model.postNewPopup;
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
                            color:
                                MyFlutterTheme.of(context).secondaryBackground,
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
                                                (currentUserDocument?.followers
                                                            .toList() ??
                                                        [])
                                                    .length,
                                                formatType: FormatType.compact,
                                              ),
                                              '0',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 4.0, 4.0, 4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController4,
                                              focusNode:
                                                  _model.textFieldFocusNode1,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Search',
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
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                              validator: _model
                                                  .textController4Validator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.search,
                                            color: MyFlutterTheme.of(context)
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
                                      MediaQuery.sizeOf(context).height * 0.57,
                                  decoration: const BoxDecoration(),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Builder(
                                      builder: (context) {
                                        final followersList =
                                            (currentUserDocument?.followers
                                                        .toList() ??
                                                    [])
                                                .toList();

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
                                                  queryBuilder: (usersRecord) =>
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
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
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
                                                  if (snapshot.data!.isEmpty) {
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
                                                            clipBehavior:
                                                                Clip.antiAlias,
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
                                                                'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/Talneties%20logo%20-01.PNG?alt=media&token=c5413c49-885b-498c-a64c-05b5cf48e724',
                                                              ),
                                                              fit: BoxFit.cover,
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
                                                                  padding:
                                                                      const EdgeInsetsDirectional
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
                            color:
                                MyFlutterTheme.of(context).secondaryBackground,
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
                                                (currentUserDocument?.followings
                                                            .toList() ??
                                                        [])
                                                    .length,
                                                formatType: FormatType.compact,
                                              ),
                                              '0',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 4.0, 4.0, 4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.textController5,
                                              focusNode:
                                                  _model.textFieldFocusNode2,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Search',
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
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.search,
                                            color: MyFlutterTheme.of(context)
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
                                      MediaQuery.sizeOf(context).height * 0.57,
                                  decoration: const BoxDecoration(),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Builder(
                                      builder: (context) {
                                        final followingList =
                                            (currentUserDocument?.followings
                                                        .toList() ??
                                                    [])
                                                .toList();

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
                                                  queryBuilder: (usersRecord) =>
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
                                                          color:
                                                              MyFlutterTheme.of(
                                                                      context)
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
                                                  if (snapshot.data!.isEmpty) {
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
                                                            clipBehavior:
                                                                Clip.antiAlias,
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
                                                                'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/Talneties%20logo%20-01.PNG?alt=media&token=c5413c49-885b-498c-a64c-05b5cf48e724',
                                                              ),
                                                              fit: BoxFit.cover,
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
                                                                  padding:
                                                                      const EdgeInsetsDirectional
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
                                ),
                              ],
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
      ),
    );
  }
}
