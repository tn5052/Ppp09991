import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_drop_down.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_place_picker.dart';
import '/my_flutter/my_flutter_static_map.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/form_field_controller.dart';
import '/my_flutter/upload_data.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'package:mapbox_search/mapbox_search.dart' as mapbox;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'post_new_event_model.dart';
export 'post_new_event_model.dart';

class PostNewEventWidget extends StatefulWidget {
  const PostNewEventWidget({super.key});

  @override
  State<PostNewEventWidget> createState() => _PostNewEventWidgetState();
}

class _PostNewEventWidgetState extends State<PostNewEventWidget>
    with TickerProviderStateMixin {
  late PostNewEventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostNewEventModel());

    _model.tfEventNameTextController ??= TextEditingController();
    _model.tfEventNameFocusNode ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.tfDescriptionTextController ??= TextEditingController();
    _model.tfDescriptionFocusNode ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
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
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250.0,
                            child: Stack(
                              children: [
                                PageView(
                                  controller: _model.pageViewController ??=
                                      PageController(initialPage: 0),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.memory(
                                          _model.uploadedLocalFile1.bytes ??
                                              Uint8List.fromList([]),
                                          width: double.infinity,
                                          height: 250.0,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.PNG',
                                            width: double.infinity,
                                            height: 250.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if ((_model.uploadedLocalFile1.bytes
                                                ?.isEmpty ??
                                            true))
                                          InkWell(
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
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                    .isDataUploading1 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading1 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile1 =
                                                        selectedUploadedFiles
                                                            .first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/addImage.jpg',
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        if ((_model.uploadedLocalFile1.bytes
                                                ?.isNotEmpty ??
                                            false))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.9, -0.7),
                                            child: MyFlutterIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 50.0,
                                              fillColor:
                                                  const Color(0x80FFFFFF),
                                              icon: Icon(
                                                Icons.cancel_presentation,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                size: 26.0,
                                              ),
                                              onPressed: () async {
                                                safeSetState(() {
                                                  _model.isDataUploading1 =
                                                      false;
                                                  _model.uploadedLocalFile1 =
                                                      FFUploadedFile(
                                                          bytes: Uint8List
                                                              .fromList([]));
                                                });
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.memory(
                                            _model.uploadedLocalFile2.bytes ??
                                                Uint8List.fromList([]),
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.PNG',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        if ((_model.uploadedLocalFile2.bytes
                                                ?.isEmpty ??
                                            true))
                                          InkWell(
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
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                    .isDataUploading2 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading2 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile2 =
                                                        selectedUploadedFiles
                                                            .first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/addImage.jpg',
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        if ((_model.uploadedLocalFile2.bytes
                                                ?.isNotEmpty ??
                                            false))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.9, -0.7),
                                            child: MyFlutterIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 50.0,
                                              fillColor:
                                                  const Color(0x80FFFFFF),
                                              icon: Icon(
                                                Icons.cancel_presentation,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                size: 26.0,
                                              ),
                                              onPressed: () async {
                                                safeSetState(() {
                                                  _model.isDataUploading2 =
                                                      false;
                                                  _model.uploadedLocalFile2 =
                                                      FFUploadedFile(
                                                          bytes: Uint8List
                                                              .fromList([]));
                                                });
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.memory(
                                            _model.uploadedLocalFile3.bytes ??
                                                Uint8List.fromList([]),
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/error_image.PNG',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        if ((_model.uploadedLocalFile3.bytes
                                                ?.isEmpty ??
                                            true))
                                          InkWell(
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
                                                allowVideo: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                    .isDataUploading3 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading3 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile3 =
                                                        selectedUploadedFiles
                                                            .first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              child: Image.asset(
                                                'assets/images/addImage.jpg',
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        if ((_model.uploadedLocalFile3.bytes
                                                ?.isNotEmpty ??
                                            false))
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                    0.9, -0.7),
                                            child: MyFlutterIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 50.0,
                                              fillColor:
                                                  const Color(0x80FFFFFF),
                                              icon: Icon(
                                                Icons.cancel_presentation,
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                size: 26.0,
                                              ),
                                              onPressed: () async {
                                                safeSetState(() {
                                                  _model.isDataUploading3 =
                                                      false;
                                                  _model.uploadedLocalFile3 =
                                                      FFUploadedFile(
                                                          bytes: Uint8List
                                                              .fromList([]));
                                                });
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 16.0),
                                    child: smooth_page_indicator
                                        .SmoothPageIndicator(
                                      controller: _model.pageViewController ??=
                                          PageController(initialPage: 0),
                                      count: 3,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) async {
                                        await _model.pageViewController!
                                            .animateToPage(
                                          i,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        safeSetState(() {});
                                      },
                                      effect: smooth_page_indicator
                                          .ExpandingDotsEffect(
                                        expansionFactor: 3.0,
                                        spacing: 8.0,
                                        radius: 16.0,
                                        dotWidth: 10.0,
                                        dotHeight: 8.0,
                                        dotColor: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        activeDotColor:
                                            MyFlutterTheme.of(context).primary,
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 30.0, 15.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyFlutterIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 50.0,
                                  fillColor: MyFlutterTheme.of(context).primary,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0, 30.0, 5.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.5,
                                          child: TextFormField(
                                            controller: _model
                                                .tfEventNameTextController,
                                            focusNode:
                                                _model.tfEventNameFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Event Name',
                                              labelStyle: MyFlutterTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
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
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                            validator: _model
                                                .tfEventNameTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.6,
                                          child: TextFormField(
                                            controller: _model.textController2,
                                            focusNode:
                                                _model.textFieldFocusNode1,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Summery',
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
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                            maxLength: 25,
                                            maxLengthEnforcement:
                                                MaxLengthEnforcement.none,
                                            buildCounter: (context,
                                                    {required currentLength,
                                                    required isFocused,
                                                    maxLength}) =>
                                                null,
                                            validator: _model
                                                .textController2Validator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      AuthUserStreamWidget(
                                        builder: (context) => Container(
                                          width: 65.0,
                                          height: 65.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              currentUserPhoto,
                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => SelectionArea(
                                              child: AutoSizeText(
                                            currentUserDisplayName,
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 15.0, 20.0, 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyFlutterPlacePicker(
                                  iOSGoogleMapsApiKey:
                                      'AIzaSyBvpeT532Q0wP2hpLzhQAlRvcur54qxFzc',
                                  androidGoogleMapsApiKey:
                                      'AIzaSyDdXDOeRME99dKkfdiPguCEPdy0OPYpgUw',
                                  webGoogleMapsApiKey:
                                      'AIzaSyBP-zsU81F3RraQJmu9s9PqN6YUGk_tMmI',
                                  onSelect: (place) async {
                                    safeSetState(
                                        () => _model.placePickerValue = place);
                                  },
                                  defaultText: 'Select Location   ',
                                  icon: Icon(
                                    Icons.place,
                                    color: MyFlutterTheme.of(context).info,
                                    size: 16.0,
                                  ),
                                  buttonOptions: FFButtonOptions(
                                    height: 30.0,
                                    color: MyFlutterTheme.of(context).primary,
                                    textStyle: MyFlutterTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color:
                                              MyFlutterTheme.of(context).info,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 2.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('map');
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: MyFlutterTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              'Start',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            )),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                  dateTimeFormat("yMMMd",
                                                      _model.datePicked1),
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Icon(
                                                    Icons.access_time,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                SelectionArea(
                                                    child: Text(
                                                  dateTimeFormat(
                                                      "jm", _model.datePicked1),
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
                                                                FontWeight.w300,
                                                          ),
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final datePicked1Date =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: getCurrentTimestamp,
                                          firstDate: (getCurrentTimestamp ??
                                              DateTime(1900)),
                                          lastDate: DateTime(2050),
                                          builder: (context, child) {
                                            return wrapInMaterialDatePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  MyFlutterTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Noto Serif',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );

                                        TimeOfDay? datePicked1Time;
                                        if (datePicked1Date != null) {
                                          datePicked1Time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                getCurrentTimestamp),
                                            builder: (context, child) {
                                              return wrapInMaterialTimePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    MyFlutterTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                pickerBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );
                                        }

                                        if (datePicked1Date != null &&
                                            datePicked1Time != null) {
                                          safeSetState(() {
                                            _model.datePicked1 = DateTime(
                                              datePicked1Date.year,
                                              datePicked1Date.month,
                                              datePicked1Date.day,
                                              datePicked1Time!.hour,
                                              datePicked1Time.minute,
                                            );
                                          });
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 60.0,
                                child: VerticalDivider(
                                  thickness: 2.3,
                                  color: Color(0x6B57636C),
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              'End',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            )),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                  dateTimeFormat("yMMMd",
                                                      _model.datePicked2),
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 5.0, 0.0),
                                                  child: Icon(
                                                    Icons.access_time,
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                SelectionArea(
                                                    child: Text(
                                                  dateTimeFormat(
                                                      "jm", _model.datePicked2),
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
                                                                FontWeight.w300,
                                                          ),
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 12.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final datePicked2Date =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: getCurrentTimestamp,
                                          firstDate: (getCurrentTimestamp ??
                                              DateTime(1900)),
                                          lastDate: DateTime(2050),
                                          builder: (context, child) {
                                            return wrapInMaterialDatePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  MyFlutterTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Noto Serif',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  MyFlutterTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );

                                        TimeOfDay? datePicked2Time;
                                        if (datePicked2Date != null) {
                                          datePicked2Time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                getCurrentTimestamp),
                                            builder: (context, child) {
                                              return wrapInMaterialTimePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    MyFlutterTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          fontSize: 32.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                pickerBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24.0,
                                              );
                                            },
                                          );
                                        }

                                        if (datePicked2Date != null &&
                                            datePicked2Time != null) {
                                          safeSetState(() {
                                            _model.datePicked2 = DateTime(
                                              datePicked2Date.year,
                                              datePicked2Date.month,
                                              datePicked2Date.day,
                                              datePicked2Time!.hour,
                                              datePicked2Time.minute,
                                            );
                                          });
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0x004B0707),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Container(
                              width: 350.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 8.0, 0.0, 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SelectionArea(
                                            child: Text(
                                          'Speakers',
                                          style: MyFlutterTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                        SelectionArea(
                                            child: Text(
                                          _model.checkboxCheckedItems2.length
                                              .toString(),
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              _model.bottomAddMembersListSheet =
                                                  true;
                                              safeSetState(() {});
                                            },
                                            text: 'Add',
                                            options: FFButtonOptions(
                                              height: 26.0,
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      2.0, 0.0, 2.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              textStyle: MyFlutterTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    letterSpacing: 0.0,
                                                  ),
                                              elevation: 1.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_model.checkboxCheckedItems2.isNotEmpty)
                                    Expanded(
                                      child: FutureBuilder<List<UsersRecord>>(
                                        future: queryUsersRecordOnce(
                                          queryBuilder: (usersRecord) =>
                                              usersRecord.whereIn(
                                                  'uid',
                                                  _model.checkboxCheckedItems2
                                                              .map((e) => e.uid)
                                                              .toList() !=
                                                          ''
                                                      ? _model
                                                          .checkboxCheckedItems2
                                                          .map((e) => e.uid)
                                                          .toList()
                                                      : null),
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
                                          List<UsersRecord>
                                              listViewUsersRecordList =
                                              snapshot.data!;

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                listViewUsersRecordList.length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewUsersRecord =
                                                  listViewUsersRecordList[
                                                      listViewIndex];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 1.0,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: 80.0,
                                                    height: 90.0,
                                                    decoration: BoxDecoration(
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            width: 45.0,
                                                            height: 45.0,
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
                                                                listViewUsersRecord
                                                                    .photoUrl,
                                                                'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        AutoSizeText(
                                                          listViewUsersRecord
                                                              .displayName,
                                                          maxLines: 2,
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
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
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: Container(
                                width: 350.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SelectionArea(
                                              child: Text(
                                            'Rating',
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          )),
                                          SelectionArea(
                                              child: Text(
                                            '3.5',
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          )),
                                          RatingBar.builder(
                                            onRatingUpdate: (newValue) =>
                                                safeSetState(() => _model
                                                    .ratingBarValue = newValue),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star_rounded,
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                            ),
                                            direction: Axis.horizontal,
                                            initialRating:
                                                _model.ratingBarValue ??= 4.5,
                                            unratedColor:
                                                const Color(0xFF9E9E9E),
                                            itemCount: 5,
                                            itemSize: 10.0,
                                            glowColor:
                                                MyFlutterTheme.of(context)
                                                    .primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: SelectionArea(
                                              child: Text(
                                            'People Joined',
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          )),
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              width: 30.0,
                                              height: 30.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                'https://i.pravatar.cc/150?img=3',
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      20.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  'https://i.pravatar.cc/150?img=6',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      40.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  'https://i.pravatar.cc/150?img=10',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      60.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 6.0, 0.0, 0.0),
                                                  child: SelectionArea(
                                                      child: Text(
                                                    '+62',
                                                    textAlign: TextAlign.center,
                                                    style: MyFlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 10.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MyFlutterStaticMap(
                                            location: const LatLng(
                                                40.740121, -73.990593),
                                            apiKey:
                                                'pk.eyJ1IjoicHJpbGx5amVhbmFsZGk2NjYiLCJhIjoiY2xhMTlsMnFrMDVlejN1bHp1dXMwZ3V1cSJ9.KGVhgtNP1NIxnqnFP7B-4A',
                                            style: mapbox.MapBoxStyle.Streets,
                                            width: 80.0,
                                            height: 80.0,
                                            fit: BoxFit.contain,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            markerColor:
                                                MyFlutterTheme.of(context)
                                                    .primary,
                                            zoom: 6,
                                            tilt: 0,
                                            rotation: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 10.0),
                                child: SelectionArea(
                                    child: Text(
                                  'About Event',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                      ),
                                )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.tfDescriptionTextController,
                              focusNode: _model.tfDescriptionFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: MyFlutterTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      color: MyFlutterTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                hintStyle: MyFlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyFlutterTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyFlutterTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyFlutterTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyFlutterTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: MyFlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 8,
                              validator: _model
                                  .tfDescriptionTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 6.0, 0.0, 26.0),
                      child: Container(
                        height: 80.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 14.0),
                                child: SelectionArea(
                                    child: Text(
                                  'Event Categories',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                      ),
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  14.0, 0.0, 0.0, 0.0),
                              child: MyFlutterChoiceChips(
                                options: const [
                                  ChipData('Tech', Icons.terminal),
                                  ChipData(
                                      'Business', Icons.business_center_sharp),
                                  ChipData('Health', Icons.healing),
                                  ChipData(
                                      'Entertainment', Icons.live_tv_rounded),
                                  ChipData('Sports', Icons.sports_score),
                                  ChipData('Other', FontAwesomeIcons.hammer)
                                ],
                                onChanged: (val) => safeSetState(
                                    () => _model.choiceChipsValues = val),
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
                                  iconColor:
                                      MyFlutterTheme.of(context).secondaryText,
                                  iconSize: 22.0,
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                chipSpacing: 12.0,
                                rowSpacing: 12.0,
                                multiselect: true,
                                initialized: _model.choiceChipsValues != null,
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
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 0.0, 16.0),
                        child: SelectionArea(
                            child: Text(
                          'Ticket Price',
                          style: MyFlutterTheme.of(context).bodyMedium.override(
                                fontFamily: 'Noto Serif',
                                color: MyFlutterTheme.of(context).primaryText,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                              ),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 0.0, 20.0, 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyFlutterIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 50.0,
                                fillColor: MyFlutterTheme.of(context).primary,
                                icon: const FaIcon(
                                  FontAwesomeIcons.moneyBillAlt,
                                  color: Colors.white,
                                  size: 26.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ).animateOnPageLoad(animationsMap[
                                  'iconButtonOnPageLoadAnimation']!),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: SizedBox(
                                    width: 100.0,
                                    child: TextFormField(
                                      controller: _model.textController4,
                                      focusNode: _model.textFieldFocusNode2,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Price',
                                        labelStyle: MyFlutterTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: '20',
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyFlutterTheme.of(context)
                                                .accent1,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyFlutterTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyFlutterTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: MyFlutterTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      style: MyFlutterTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .success,
                                            letterSpacing: 2.0,
                                          ),
                                      minLines: 1,
                                      maxLength: 6,
                                      buildCounter: (context,
                                              {required currentLength,
                                              required isFocused,
                                              maxLength}) =>
                                          null,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      cursorColor: MyFlutterTheme.of(context)
                                          .primaryText,
                                      validator: _model.textController4Validator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ),
                              MyFlutterDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(null),
                                options: const ['Pkr', '\$', '£', '€', '¥'],
                                onChanged: (val) => safeSetState(
                                    () => _model.dropDownValue = val),
                                width: 100.0,
                                textStyle: MyFlutterTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      color: MyFlutterTheme.of(context).primary,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      lineHeight: 0.0,
                                    ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color:
                                      MyFlutterTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    MyFlutterTheme.of(context).alternate,
                                borderWidth: 2.0,
                                borderRadius: 8.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: true,
                                isSearchable: false,
                                isMultiSelect: false,
                                labelText: 'Currency',
                                labelTextStyle: MyFlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4.0, 10.0, 10.0, 10.0),
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        MyFlutterTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: _model.checkboxValue1 ??= true,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.checkboxValue1 = newValue!);
                                    },
                                    side: BorderSide(
                                      width: 2,
                                      color: MyFlutterTheme.of(context)
                                          .secondaryText,
                                    ),
                                    activeColor:
                                        MyFlutterTheme.of(context).primary,
                                    checkColor: MyFlutterTheme.of(context).info,
                                  ),
                                ),
                                Text(
                                  'Refundable, till week before of event start. ',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4.0, 10.0, 10.0, 10.0),
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        MyFlutterTheme.of(context)
                                            .secondaryText,
                                  ),
                                  child: Checkbox(
                                    value: _model.checkboxTCValue ??= false,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.checkboxTCValue = newValue!);
                                    },
                                    side: BorderSide(
                                      width: 2,
                                      color: MyFlutterTheme.of(context)
                                          .secondaryText,
                                    ),
                                    activeColor:
                                        MyFlutterTheme.of(context).primary,
                                    checkColor: MyFlutterTheme.of(context).info,
                                  ),
                                ),
                                Text(
                                  'I accept term\'s and conditions.',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Icon(
                                    Icons.open_in_new_sharp,
                                    color: MyFlutterTheme.of(context).secondary,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: ((_model.checkboxTCValue == false) ||
                                        (_model.tfEventNameTextController
                                                .text ==
                                            '') ||
                                        (_model.textController2.text == '') ||
                                        (_model.tfDescriptionTextController
                                                .text ==
                                            '') ||
                                        (_model.tfEventNameTextController
                                                .text ==
                                            '') ||
                                        (_model.placePickerValue == null))
                                    ? null
                                    : () async {
                                        if (_model.datePicked1! <
                                            _model.datePicked2!) {
                                          var confirmDialogResponse =
                                              await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Post Event'),
                                                        content: const Text(
                                                            'After confirming No changes can be apply!'),
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
                                            if ((_model.uploadedLocalFile1.bytes
                                                    ?.isNotEmpty ??
                                                false)) {
                                              {
                                                safeSetState(() => _model
                                                    .isDataUploading4 = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];
                                                var selectedMedia =
                                                    <SelectedFile>[];
                                                var downloadUrls = <String>[];
                                                try {
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
                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedMedia.map(
                                                      (m) async =>
                                                          await uploadData(
                                                              m.storagePath,
                                                              m.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading4 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile4 =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl4 =
                                                        downloadUrls.first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              var eventsRecordReference1 =
                                                  EventsRecord.collection.doc();
                                              await eventsRecordReference1.set({
                                                ...createEventsRecordData(
                                                  name: _model
                                                      .tfEventNameTextController
                                                      .text,
                                                  description: _model
                                                      .tfDescriptionTextController
                                                      .text,
                                                  location: _model
                                                      .placePickerValue.latLng,
                                                  timeStart: _model.datePicked1,
                                                  status: 'coming',
                                                  manager: currentUserReference,
                                                  price: valueOrDefault<int>(
                                                    int.tryParse(_model
                                                        .textController4.text),
                                                    0,
                                                  ),
                                                  refundable:
                                                      _model.checkboxValue1,
                                                  managerName:
                                                      currentUserDisplayName,
                                                  timeEnd: _model.datePicked2,
                                                  currency:
                                                      _model.dropDownValue,
                                                  summery: _model
                                                      .textController2.text,
                                                  address:
                                                      valueOrDefault<String>(
                                                    _model
                                                        .placePickerValue.name,
                                                    'Address',
                                                  ),
                                                  combinedCategories:
                                                      valueOrDefault<String>(
                                                    functions
                                                        .combineListToSingleString(
                                                            _model
                                                                .choiceChipsValues
                                                                ?.toList()),
                                                    'none',
                                                  ),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'speakers': _model
                                                        .checkboxCheckedItems2
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'media': [
                                                      _model.uploadedFileUrl4
                                                    ],
                                                    'categories': _model
                                                        .choiceChipsValues,
                                                    'peopleJoined': [
                                                      currentUserReference
                                                    ],
                                                  },
                                                ),
                                              });
                                              _model.createDocActionOutput1 =
                                                  EventsRecord
                                                      .getDocumentFromData({
                                                ...createEventsRecordData(
                                                  name: _model
                                                      .tfEventNameTextController
                                                      .text,
                                                  description: _model
                                                      .tfDescriptionTextController
                                                      .text,
                                                  location: _model
                                                      .placePickerValue.latLng,
                                                  timeStart: _model.datePicked1,
                                                  status: 'coming',
                                                  manager: currentUserReference,
                                                  price: valueOrDefault<int>(
                                                    int.tryParse(_model
                                                        .textController4.text),
                                                    0,
                                                  ),
                                                  refundable:
                                                      _model.checkboxValue1,
                                                  managerName:
                                                      currentUserDisplayName,
                                                  timeEnd: _model.datePicked2,
                                                  currency:
                                                      _model.dropDownValue,
                                                  summery: _model
                                                      .textController2.text,
                                                  address:
                                                      valueOrDefault<String>(
                                                    _model
                                                        .placePickerValue.name,
                                                    'Address',
                                                  ),
                                                  combinedCategories:
                                                      valueOrDefault<String>(
                                                    functions
                                                        .combineListToSingleString(
                                                            _model
                                                                .choiceChipsValues
                                                                ?.toList()),
                                                    'none',
                                                  ),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'speakers': _model
                                                        .checkboxCheckedItems2
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'media': [
                                                      _model.uploadedFileUrl4
                                                    ],
                                                    'categories': _model
                                                        .choiceChipsValues,
                                                    'peopleJoined': [
                                                      currentUserReference
                                                    ],
                                                  },
                                                ),
                                              }, eventsRecordReference1);

                                              await _model
                                                  .createDocActionOutput1!
                                                  .reference
                                                  .update(
                                                      createEventsRecordData(
                                                eventID: _model
                                                    .createDocActionOutput1
                                                    ?.reference
                                                    .id,
                                                eventRef: _model
                                                    .createDocActionOutput1
                                                    ?.reference,
                                              ));

                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'eventTickets':
                                                        FieldValue.arrayUnion([
                                                      _model
                                                          .createDocActionOutput1
                                                          ?.reference
                                                    ]),
                                                  },
                                                ),
                                              });
                                              _model.soundPlayer1 ??=
                                                  AudioPlayer();
                                              if (_model
                                                  .soundPlayer1!.playing) {
                                                await _model.soundPlayer1!
                                                    .stop();
                                              }
                                              _model.soundPlayer1!
                                                  .setVolume(1.0);
                                              _model.soundPlayer1!
                                                  .setAsset(
                                                      'assets/audios/level-up-191997.mp3')
                                                  .then((_) => _model
                                                      .soundPlayer1!
                                                      .play());
                                            } else {
                                              var eventsRecordReference2 =
                                                  EventsRecord.collection.doc();
                                              await eventsRecordReference2.set({
                                                ...createEventsRecordData(
                                                  name: _model
                                                      .tfEventNameTextController
                                                      .text,
                                                  description: _model
                                                      .tfDescriptionTextController
                                                      .text,
                                                  location: _model
                                                      .placePickerValue.latLng,
                                                  timeStart: _model.datePicked1,
                                                  status: 'coming',
                                                  manager: currentUserReference,
                                                  price: valueOrDefault<int>(
                                                    int.tryParse(_model
                                                        .textController4.text),
                                                    0,
                                                  ),
                                                  refundable:
                                                      _model.checkboxValue1,
                                                  managerName:
                                                      currentUserDisplayName,
                                                  timeEnd: _model.datePicked2,
                                                  currency:
                                                      _model.dropDownValue,
                                                  summery: _model
                                                      .textController2.text,
                                                  address:
                                                      valueOrDefault<String>(
                                                    _model
                                                        .placePickerValue.name,
                                                    'Address',
                                                  ),
                                                  combinedCategories:
                                                      valueOrDefault<String>(
                                                    functions
                                                        .combineListToSingleString(
                                                            _model
                                                                .choiceChipsValues
                                                                ?.toList()),
                                                    'none',
                                                  ),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'speakers': _model
                                                        .checkboxCheckedItems2
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'media': [
                                                      'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53'
                                                    ],
                                                    'categories': _model
                                                        .choiceChipsValues,
                                                    'peopleJoined': [
                                                      currentUserReference
                                                    ],
                                                  },
                                                ),
                                              });
                                              _model.createDocActionOutput2 =
                                                  EventsRecord
                                                      .getDocumentFromData({
                                                ...createEventsRecordData(
                                                  name: _model
                                                      .tfEventNameTextController
                                                      .text,
                                                  description: _model
                                                      .tfDescriptionTextController
                                                      .text,
                                                  location: _model
                                                      .placePickerValue.latLng,
                                                  timeStart: _model.datePicked1,
                                                  status: 'coming',
                                                  manager: currentUserReference,
                                                  price: valueOrDefault<int>(
                                                    int.tryParse(_model
                                                        .textController4.text),
                                                    0,
                                                  ),
                                                  refundable:
                                                      _model.checkboxValue1,
                                                  managerName:
                                                      currentUserDisplayName,
                                                  timeEnd: _model.datePicked2,
                                                  currency:
                                                      _model.dropDownValue,
                                                  summery: _model
                                                      .textController2.text,
                                                  address:
                                                      valueOrDefault<String>(
                                                    _model
                                                        .placePickerValue.name,
                                                    'Address',
                                                  ),
                                                  combinedCategories:
                                                      valueOrDefault<String>(
                                                    functions
                                                        .combineListToSingleString(
                                                            _model
                                                                .choiceChipsValues
                                                                ?.toList()),
                                                    'none',
                                                  ),
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'speakers': _model
                                                        .checkboxCheckedItems2
                                                        .map((e) => e.reference)
                                                        .toList(),
                                                    'media': [
                                                      'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53'
                                                    ],
                                                    'categories': _model
                                                        .choiceChipsValues,
                                                    'peopleJoined': [
                                                      currentUserReference
                                                    ],
                                                  },
                                                ),
                                              }, eventsRecordReference2);

                                              await _model
                                                  .createDocActionOutput2!
                                                  .reference
                                                  .update(
                                                      createEventsRecordData(
                                                eventID: _model
                                                    .createDocActionOutput2
                                                    ?.reference
                                                    .id,
                                                eventRef: _model
                                                    .createDocActionOutput2
                                                    ?.reference,
                                              ));

                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'eventTickets':
                                                        FieldValue.arrayUnion([
                                                      _model
                                                          .createDocActionOutput2
                                                          ?.reference
                                                    ]),
                                                  },
                                                ),
                                              });
                                              _model.soundPlayer2 ??=
                                                  AudioPlayer();
                                              if (_model
                                                  .soundPlayer2!.playing) {
                                                await _model.soundPlayer2!
                                                    .stop();
                                              }
                                              _model.soundPlayer2!
                                                  .setVolume(1.0);
                                              _model.soundPlayer2!
                                                  .setAsset(
                                                      'assets/audios/level-up-191997.mp3')
                                                  .then((_) => _model
                                                      .soundPlayer2!
                                                      .play());
                                            }

                                            context.pushNamed('home');
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Event Start Date Time should be less than End Date Time',
                                                style: TextStyle(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 4000),
                                              backgroundColor:
                                                  const Color(0xFFE8FF30),
                                            ),
                                          );
                                        }

                                        safeSetState(() {});
                                      },
                                text: 'Post Event',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                                  elevation: 3.0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                  disabledColor: const Color(0xFFABC5D7),
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
              if (valueOrDefault<bool>(
                _model.bottomAddMembersListSheet != false,
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
                            _model.bottomAddMembersListSheet = false;
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
                                              _model
                                                  .checkboxCheckedItems2.length
                                                  .toString(),
                                              '7',
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
                                            text: '  Speaker\'s',
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
                                                  _model.textFieldFocusNode3,
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
                                  child: StreamBuilder<List<UsersRecord>>(
                                    stream: queryUsersRecord(),
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
                                      List<UsersRecord>
                                          listViewUsersRecordList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewUsersRecordList.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewUsersRecord =
                                              listViewUsersRecordList[
                                                  listViewIndex];
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
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
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        valueOrDefault<String>(
                                                          listViewUsersRecord
                                                              .photoUrl,
                                                          'https://images.unsplash.com/photo-1542206395-9feb3edaa68d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8cGVyc29ufGVufDB8fHx8MTcxMTk5NjIxNHww&ixlib=rb-4.0.3&q=80&w=400',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                              0.0, 0.0, 0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            listViewUsersRecord
                                                                .displayName,
                                                            style: MyFlutterTheme
                                                                    .of(context)
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
                                                              listViewUsersRecord
                                                                  .email,
                                                              style: MyFlutterTheme
                                                                      .of(context)
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
                                                Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        const CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity
                                                              .standard,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .padded,
                                                      shape: CircleBorder(),
                                                    ),
                                                    unselectedWidgetColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .secondaryText,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValueMap2[
                                                        listViewUsersRecord] ??= false,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() => _model
                                                                  .checkboxValueMap2[
                                                              listViewUsersRecord] =
                                                          newValue!);
                                                    },
                                                    side: BorderSide(
                                                      width: 2,
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .secondaryText,
                                                    ),
                                                    activeColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor:
                                                        MyFlutterTheme.of(
                                                                context)
                                                            .info,
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
