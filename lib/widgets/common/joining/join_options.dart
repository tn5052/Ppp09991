import 'package:flutter/material.dart';
import 'package:talenties/backend/backend.dart';
import 'package:talenties/constants/colors.dart';
import 'package:talenties/utils/spacer.dart';
import 'package:talenties/widgets/common/joining_details/joining_details.dart';

class JoinOptions extends StatelessWidget {
  final bool? isJoinMeetingSelected;
  final bool? isCreateMeetingSelected;
  final double maxWidth;
  final Function(bool isCreateMeeting) onOptionSelected;
  final Function(String meetingId, String callType, String displayName)
      onClickMeetingJoin;

  const JoinOptions({
    Key? key,    
    required this.slot15min,
    required this.isJoinMeetingSelected,
    required this.isCreateMeetingSelected,
    required this.maxWidth,
    required this.onOptionSelected,
    required this.onClickMeetingJoin,
  }) : super(key: key);

  final DocumentReference? slot15min;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isJoinMeetingSelected == null && isCreateMeetingSelected == null)
          MaterialButton(
            minWidth: maxWidth * 0.8, // Hardcoded width (80% of maxWidth)
            height: 50, // Fixed height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: purple,
            child: const Text("Create Meeting", style: TextStyle(fontSize: 16)),
            onPressed: () => onOptionSelected(true),
          ),
        const VerticalSpacer(16),
        if (isJoinMeetingSelected == null && isCreateMeetingSelected == null)
          MaterialButton(
            minWidth: maxWidth * 0.8, // Hardcoded width (80% of maxWidth)
            height: 50, // Fixed height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: black750,
            child: const Text("Join Meeting",
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromRGBO(85, 104, 254, 1),
                )),
            onPressed: () => onOptionSelected(false),
          ),
        if (isJoinMeetingSelected != null && isCreateMeetingSelected != null)
          JoiningDetails(
            isCreateMeeting: isCreateMeetingSelected!,
            onClickMeetingJoin: onClickMeetingJoin, slot15min: slot15min,
          ),
      ],
    );
  }
}
