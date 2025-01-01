import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:talenties/backend/backend.dart';
import 'package:talenties/backend/schema/mentor15mins_slots_record.dart';
import 'package:talenties/constants/colors.dart';
import 'package:talenties/my_flutter/my_flutter_theme.dart';
import 'package:talenties/utils/spacer.dart';
import 'package:talenties/utils/toast.dart';

class JoiningDetails extends StatefulWidget {
  final bool isCreateMeeting;
  final Function onClickMeetingJoin;

  const JoiningDetails(
      {Key? key,
      required this.slot15min,
      required this.isCreateMeeting,
      required this.onClickMeetingJoin})
      : super(key: key);

  final DocumentReference? slot15min;

  @override
  State<JoiningDetails> createState() => _JoiningDetailsState();
}

class _JoiningDetailsState extends State<JoiningDetails> {
  String _meetingId = "";
  String _displayName = "";
  String meetingMode = "GROUP";
  List<String> meetingModes = ["ONE_TO_ONE", "GROUP"];
  TextEditingController? _meetingIdController;

  @override
  void dispose() {
    _meetingIdController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: black750),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: meetingMode,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              onChanged: (String? value) {
                setState(() {
                  meetingMode = value!;
                });
              },
              borderRadius: BorderRadius.circular(12),
              dropdownColor: black750,
              alignment: AlignmentDirectional.centerStart,
              items: meetingModes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: maxWidth / 2, // Hardcoded value for min width
                    ),
                    child: Text(
                      value == "GROUP" ? "Group Call" : "One to One Call",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const VerticalSpacer(16),
        if (!widget.isCreateMeeting)
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

              // Initialize the controller with the fetched data
              _meetingIdController ??= TextEditingController(
                text: containerMentor15minsSlotsRecord.linkShared,
              );

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: black750),
                child: TextField(
                  controller: _meetingIdController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 99, 102, 255),
                  ),
                  onChanged: (value) => _meetingId = value,
                  decoration: InputDecoration(
                      constraints: BoxConstraints.tightFor(
                        width: maxWidth / 1.3, // Hardcoded value for width
                      ),
                      hintText: "Enter meeting code",
                      hintStyle: const TextStyle(
                        color: textGray,
                      ),
                      border: InputBorder.none),
                ),
              );
            },
          ),
        if (!widget.isCreateMeeting) const VerticalSpacer(16),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: black750),
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 99, 102, 255),
            ),
            onChanged: ((value) => _displayName = value),
            decoration: InputDecoration(
                constraints: BoxConstraints.tightFor(
                  width: maxWidth / 1.3, // Hardcoded value for width
                ),
                hintText: "Enter your name",
                hintStyle: const TextStyle(
                  color: textGray,
                ),
                border: InputBorder.none),
          ),
        ),
        const VerticalSpacer(16),
        MaterialButton(
            minWidth: maxWidth / 1.3, // Hardcoded value for min width
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: purple,
            child: const Text("Join Meeting", style: TextStyle(fontSize: 16)),
            onPressed: () {
              if (_displayName.trim().isEmpty) {
                showSnackBarMessage(
                    message: "Please enter name", context: context);
                return;
              }
              if (!widget.isCreateMeeting && _meetingId.trim().isEmpty) {
                showSnackBarMessage(
                    message: "Please enter meeting id", context: context);
                return;
              }
              widget.onClickMeetingJoin(
                  _meetingId.trim(), meetingMode, _displayName.trim());
            }),
      ],
    );
  }
}
