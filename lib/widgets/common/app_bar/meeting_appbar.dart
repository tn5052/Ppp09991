import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:talenties/backend/backend.dart';
import 'package:talenties/my_flutter/my_flutter_theme.dart';
import 'package:videosdk/videosdk.dart';
import 'package:talenties/constants/colors.dart';
import 'package:talenties/utils/api.dart';
import 'package:talenties/utils/spacer.dart';
import 'package:talenties/utils/toast.dart';
import 'package:talenties/widgets/common/app_bar/recording_indicator.dart';

class MeetingAppBar extends StatefulWidget {
  final String token;
  final Room meeting;
  final String recordingState;
  final bool isFullScreen;
  const MeetingAppBar(
      {Key? key,
      required this.slot15min,
      required this.meeting,
      required this.token,
      required this.isFullScreen,
      required this.recordingState})
      : super(key: key);

  final DocumentReference? slot15min;

  @override
  State<MeetingAppBar> createState() => MeetingAppBarState();
}

class MeetingAppBarState extends State<MeetingAppBar> {
  Duration? elapsedTime;
  Timer? sessionTimer;

  List<VideoDeviceInfo>? cameras = [];

  @override
  void initState() {
    startTimer();
    fetchCameras();
    super.initState();
  }

  void fetchCameras() async {
    cameras = await VideoSDK.getVideoDevices();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: !widget.isFullScreen
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        secondChild: const SizedBox.shrink(),
        firstChild: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 8.0, 0.0),
          child: Row(
            children: [
              if (widget.recordingState == "RECORDING_STARTING" ||
                  widget.recordingState == "RECORDING_STOPPING" ||
                  widget.recordingState == "RECORDING_STARTED")
                RecordingIndicator(recordingState: widget.recordingState),
              if (widget.recordingState == "RECORDING_STARTING" ||
                  widget.recordingState == "RECORDING_STOPPING" ||
                  widget.recordingState == "RECORDING_STARTED")
                const HorizontalSpacer(),
              StreamBuilder<Mentor15minsSlotsRecord>(
                stream: Mentor15minsSlotsRecord.getDocument(widget.slot15min!),
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

                  final containerMentor15minsSlotsRecord = snapshot.data!;

                  return Container(
                    decoration: const BoxDecoration(),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.meeting.id,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: Icon(
                                    Icons.copy,
                                    size: 16,
                                  ),
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.meeting.id));
                                  showSnackBarMessage(
                                      message: "Meeting ID has been copied.",
                                      context: context);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await widget.slot15min!.update(
                                        createMentor15minsSlotsRecordData(
                                      linkShared: widget.meeting.id,
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Meeting ID has been Shared",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        backgroundColor: Colors
                                            .white, // Optional: Set background color for better visibility
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.ios_share,
                                    color: Colors.red,
                                    size: 26.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // VerticalSpacer(),
                          Text(
                            elapsedTime == null
                                ? "00:00:00"
                                : elapsedTime.toString().split(".").first,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/ic_switch_camera.svg",
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  VideoDeviceInfo? newCam = cameras?.firstWhere((camera) =>
                      camera.deviceId != widget.meeting.selectedCam?.deviceId);
                  if (newCam != null) {
                    widget.meeting.changeCam(newCam);
                  }
                },
              ),
            ],
          ),
        ));
  }

  Future<void> startTimer() async {
    dynamic session = await fetchSession(widget.token, widget.meeting.id);
    DateTime sessionStartTime = DateTime.parse(session['start']);
    final difference = DateTime.now().difference(sessionStartTime);

    setState(() {
      elapsedTime = difference;
      sessionTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            elapsedTime = Duration(
                seconds: elapsedTime != null ? elapsedTime!.inSeconds + 1 : 0);
          });
        },
      );
    });
    // log("session start time" + session.data[0].start.toString());
  }

  @override
  void dispose() {
    if (sessionTimer != null) {
      sessionTimer!.cancel();
    }
    super.dispose();
  }
}
