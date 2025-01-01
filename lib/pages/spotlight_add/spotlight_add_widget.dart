import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_video_player.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/upload_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'spotlight_add_model.dart';
export 'spotlight_add_model.dart';

class SpotlightAddWidget extends StatefulWidget {
  /// Create New Spotlight to Upload
  const SpotlightAddWidget({super.key});

  @override
  State<SpotlightAddWidget> createState() => _SpotlightAddWidgetState();
}

class _SpotlightAddWidgetState extends State<SpotlightAddWidget> {
  late SpotlightAddModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpotlightAddModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: MyFlutterTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: MyFlutterTheme.of(context).primary,
            automaticallyImplyLeading: false,
            leading: MyFlutterIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: MyFlutterTheme.of(context).secondaryBackground,
                size: 30.0,
              ),
              onPressed: () async {
                if (_model.uploadedFileUrl != '') {
                  await FirebaseStorage.instance
                      .refFromURL(_model.uploadedFileUrl)
                      .delete();
                  safeSetState(() {
                    _model.isDataUploading = false;
                    _model.uploadedLocalFile =
                        FFUploadedFile(bytes: Uint8List.fromList([]));
                    _model.uploadedFileUrl = '';
                  });
                }
                context.safePop();
              },
            ),
            title: Text(
              'Upload Spotlight',
              style: MyFlutterTheme.of(context).headlineMedium.override(
                    fontFamily: 'Noto Serif',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: const [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              height: MediaQuery.sizeOf(context).height * 0.52,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                children: [
                                  MyFlutterVideoPlayer(
                                    path: _model.uploadedFileUrl,
                                    videoType: VideoType.network,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.74,
                                    autoPlay: false,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                  if (!((_model.uploadedFileUrl != '') ||
                                      _model.isDataUploading))
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          allowPhoto: false,
                                          allowVideo: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() =>
                                              _model.isDataUploading = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          var downloadUrls = <String>[];
                                          try {
                                            showUploadMessage(
                                              context,
                                              'Uploading file...',
                                              showLoading: true,
                                            );
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

                                            downloadUrls = (await Future.wait(
                                              selectedMedia.map(
                                                (m) async => await uploadData(
                                                    m.storagePath, m.bytes),
                                              ),
                                            ))
                                                .where((u) => u != null)
                                                .map((u) => u!)
                                                .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl =
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
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.7,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.52,
                                        decoration: BoxDecoration(
                                          color: MyFlutterTheme.of(context)
                                              .alternate,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/add_Video_vertical_poster_-_with_white_BG.png',
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: TextFormField(
                            controller: _model.textController1,
                            focusNode: _model.textFieldFocusNode1,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Title',
                              labelStyle: MyFlutterTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context).primary,
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
                                  color:
                                      MyFlutterTheme.of(context).secondaryText,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              filled: true,
                            ),
                            style:
                                MyFlutterTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                            maxLength: 35,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) =>
                                null,
                            cursorColor: MyFlutterTheme.of(context).primaryText,
                            validator: _model.textController1Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: TextFormField(
                            controller: _model.textController2,
                            focusNode: _model.textFieldFocusNode2,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Description',
                              labelStyle: MyFlutterTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context).primary,
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
                                  color:
                                      MyFlutterTheme.of(context).secondaryText,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              filled: true,
                            ),
                            style:
                                MyFlutterTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                            maxLines: 5,
                            maxLength: 170,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) =>
                                null,
                            cursorColor: MyFlutterTheme.of(context).primaryText,
                            validator: _model.textController2Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 8.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: ((_model.uploadedFileUrl == '') ||
                                  (_model.textController1.text == '') ||
                                  (_model.textController2.text == '') ||
                                  _model.isDataUploading)
                              ? null
                              : () async {
                                  await ReelsRecord.collection
                                      .doc()
                                      .set(createReelsRecordData(
                                        postedBy: currentUserReference,
                                        postDateTime: getCurrentTimestamp,
                                        reelDescription:
                                            _model.textController2.text,
                                        title: _model.textController1.text,
                                        reelMediaPath: _model.uploadedFileUrl,
                                      ));
                                  context.safePop();
                                },
                          text: 'Upload',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: MyFlutterTheme.of(context).primary,
                            textStyle:
                                MyFlutterTheme.of(context).titleSmall.override(
                                      fontFamily: 'Noto Serif',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                            disabledColor: const Color(0x6E57636C),
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
      ),
    );
  }
}
