import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'spotlights_model.dart';
export 'spotlights_model.dart';

class SpotlightsWidget extends StatefulWidget {
  /// here is all feed will be shown of a person.
  const SpotlightsWidget({
    super.key,
    this.postedBy,
  });

  final DocumentReference? postedBy;

  @override
  State<SpotlightsWidget> createState() => _SpotlightsWidgetState();
}

class _SpotlightsWidgetState extends State<SpotlightsWidget> {
  late SpotlightsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpotlightsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.postedBy!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: MyFlutterTheme.of(context).primaryBackground,
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

        final spotlightsUsersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: MyFlutterTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: MyFlutterTheme.of(context).primary,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyFlutterIconButton(
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
                      context.pop();
                    },
                  ),
                  Text(
                    'Spotlights',
                    style: MyFlutterTheme.of(context).headlineMedium.override(
                          fontFamily: 'Noto Serif',
                          color: Colors.white,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  if ((spotlightsUsersRecord.reference ==
                          currentUserReference) &&
                      (_model.edit == false))
                    MyFlutterIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.edit_note_rounded,
                        color: MyFlutterTheme.of(context).secondaryBackground,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        _model.edit = !(_model.edit ?? true);
                        safeSetState(() {});
                      },
                    ),
                  if ((spotlightsUsersRecord.reference ==
                          currentUserReference) &&
                      _model.edit!)
                    MyFlutterIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.edit_off_rounded,
                        color: MyFlutterTheme.of(context).secondaryBackground,
                        size: 26.0,
                      ),
                      onPressed: () async {
                        _model.edit = !(_model.edit ?? true);
                        safeSetState(() {});
                      },
                    ),
                  if (spotlightsUsersRecord.reference != currentUserReference)
                    MyFlutterIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: Colors.transparent,
                        size: 30.0,
                      ),
                      onPressed: () async {},
                    ),
                ],
              ),
              actions: const [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'profile',
                                queryParameters: {
                                  'profileDoc': serializeParam(
                                    spotlightsUsersRecord,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'profileDoc': spotlightsUsersRecord,
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 56.0,
                                  height: 56.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      spotlightsUsersRecord.photoUrl,
                                      'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      spotlightsUsersRecord.displayName,
                                      'No Name',
                                    ),
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder<List<ReelsRecord>>(
                          stream: queryReelsRecord(
                            queryBuilder: (reelsRecord) => reelsRecord
                                .where(
                                  'postedBy',
                                  isEqualTo: widget.postedBy,
                                )
                                .orderBy('postDateTime', descending: true),
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
                            List<ReelsRecord> gridViewReelsRecordList =
                                snapshot.data!;
                            if (gridViewReelsRecordList.isEmpty) {
                              return Image.asset(
                                'assets/images/empty_Box_in_girl_hand_animation.gif',
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.56,
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: gridViewReelsRecordList.length,
                              itemBuilder: (context, gridViewIndex) {
                                final gridViewReelsRecord =
                                    gridViewReelsRecordList[gridViewIndex];
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        color: MyFlutterTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Stack(
                                        children: [
                                          MyFlutterVideoPlayer(
                                            path: gridViewReelsRecord
                                                .reelMediaPath,
                                            videoType: VideoType.network,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.84,
                                            autoPlay: false,
                                            looping: true,
                                            showControls: true,
                                            allowFullScreen: true,
                                            allowPlaybackSpeedMenu: true,
                                          ),
                                          if ((widget.postedBy ==
                                                  currentUserReference) &&
                                              valueOrDefault<bool>(
                                                _model.edit == true,
                                                true,
                                              ))
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      -0.98, -0.99),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (widget.postedBy ==
                                                      currentUserReference) {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Delete Spotlight'),
                                                                  content:
                                                                      const Text(
                                                                          'Spotlight will be deleted permanently!'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
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
                                                      await FirebaseStorage
                                                          .instance
                                                          .refFromURL(
                                                              gridViewReelsRecord
                                                                  .reelMediaPath)
                                                          .delete();
                                                      await gridViewReelsRecord
                                                          .reference
                                                          .delete();
                                                    }
                                                  }
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.trashAlt,
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
                                  ),
                                );
                              },
                            );
                          },
                        ),
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
            ),
          ),
        );
      },
    );
  }
}
