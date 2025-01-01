import '/components/text_filed_component/text_filed_component_widget.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'try_page_widget.dart' show TryPageWidget;
import 'package:flutter/material.dart';

class TryPageModel extends MyFlutterModel<TryPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for textFiledComponent component.
  late TextFiledComponentModel textFiledComponentModel;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;

  @override
  void initState(BuildContext context) {
    textFiledComponentModel =
        createModel(context, () => TextFiledComponentModel());
  }

  @override
  void dispose() {
    textFiledComponentModel.dispose();
  }
}
