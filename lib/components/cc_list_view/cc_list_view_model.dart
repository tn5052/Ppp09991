import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'cc_list_view_widget.dart' show CcListViewWidget;
import 'package:flutter/material.dart';

class CcListViewModel extends MyFlutterModel<CcListViewWidget> {
  ///  Local state fields for this component.

  DateTime? startTime;

  DateTime? endTme;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
