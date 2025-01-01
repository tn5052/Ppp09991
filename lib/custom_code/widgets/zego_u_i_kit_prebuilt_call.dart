// Automatic MyFlutter imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/my_flutter/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//​​​​​​​​​​​​​​​​import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoUIKitPrebuiltCall extends StatefulWidget {
  const ZegoUIKitPrebuiltCall({
    super.key,
    this.width,
    this.height,
    this.userid,
    this.username,
    this.callID,
  });

  final double? width;
  final double? height;
  final String? userid;
  final String? username;
  final String? callID;

  @override
  State<ZegoUIKitPrebuiltCall> createState() => _ZegoUIKitPrebuiltCallState();
}

class _ZegoUIKitPrebuiltCallState extends State<ZegoUIKitPrebuiltCall> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          1634706253, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "4c9bbf13834e479d036d47c2c17a146bb4eef5ce06f9e253c6fd8763d84d278e", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: 'user_id',
      userName: 'user_name',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
