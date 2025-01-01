import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'package:../../talenties/constants/colors.dart';

class JoinView extends StatelessWidget {
  final RTCVideoRenderer? cameraRenderer;
  final bool isMicOn;
  final bool isCameraOn;
  final VoidCallback onMicToggle;
  final VoidCallback onCameraToggle;

  const JoinView({
    Key? key,
    required this.cameraRenderer,
    required this.isMicOn,
    required this.isCameraOn,
    required this.onMicToggle,
    required this.onCameraToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double aspectRatio = 1 / 2; // Fixed aspect ratio for larger screens
    double height = 400; // Fixed height for camera view
    double width = MediaQuery.of(context).size.width *
        0.7; // Fixed width (70% of screen width)

    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: cameraRenderer != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: RTCVideoView(
                          cameraRenderer as RTCVideoRenderer,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: black800,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            "Camera is turned off",
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: 20,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onMicToggle,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15), // Fixed padding
                          backgroundColor: isMicOn ? Colors.white : red,
                          foregroundColor: Colors.black,
                        ),
                        child: Icon(isMicOn ? Icons.mic : Icons.mic_off,
                            color: isMicOn ? grey : Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: onCameraToggle,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15), // Fixed padding
                          backgroundColor: isCameraOn
                              ? const Color.fromARGB(255, 48, 47, 47)
                              : red,
                        ),
                        child: Icon(
                          isCameraOn ? Icons.videocam : Icons.videocam_off,
                          color: isCameraOn
                              ? const Color.fromARGB(255, 248, 249, 250)
                              : Colors.white,
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
    );
  }
}
