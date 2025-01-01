import '/my_flutter/my_flutter_util.dart';
import 'adding_members_to_list_widget.dart' show AddingMembersToListWidget;
import 'package:flutter/material.dart';

class AddingMembersToListModel
    extends MyFlutterModel<AddingMembersToListWidget> {
  ///  State fields for stateful widgets in this component.

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
