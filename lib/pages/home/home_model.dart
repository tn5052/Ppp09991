import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class HomeModel extends MyFlutterModel<HomeWidget> {
  ///  Local state fields for this page.

  bool postNewbottomPopup = false;

  bool showNotification = true;

  String? categorySearch;

  ///  State fields for stateful widgets in this page.

  // State field(s) for tf_simpleSearch widget.
  FocusNode? tfSimpleSearchFocusNode;
  TextEditingController? tfSimpleSearchTextController;
  String? Function(BuildContext, String?)?
      tfSimpleSearchTextControllerValidator;
  List<EventsRecord> simpleSearchResults1 = [];
  List<UsersRecord> simpleSearchResults2 = [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Firestore Query - Query a collection] action in ListTile widget.
  UsersRecord? menteeDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfSimpleSearchFocusNode?.dispose();
    tfSimpleSearchTextController?.dispose();
  }
}
