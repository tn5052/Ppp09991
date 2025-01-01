import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import 'bottom_add_membors_list_sheet_widget.dart'
    show BottomAddMemborsListSheetWidget;
import 'package:flutter/material.dart';

class BottomAddMemborsListSheetModel
    extends MyFlutterModel<BottomAddMemborsListSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Checkbox widget.
  Map<UsersRecord, bool> checkboxValueMap = {};
  List<UsersRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
