import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'book_meeting_copy_widget.dart' show BookMeetingCopyWidget;
import 'package:flutter/material.dart';

class BookMeetingCopyModel extends MyFlutterModel<BookMeetingCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
