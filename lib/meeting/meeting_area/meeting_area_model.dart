import '/my_flutter/my_flutter_util.dart';
import 'meeting_area_widget.dart' show MeetingAreaWidget;
import 'package:flutter/material.dart';

class MeetingAreaModel extends MyFlutterModel<MeetingAreaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
