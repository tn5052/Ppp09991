import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends MyFlutterModel<ProfileWidget> {
  ///  Local state fields for this page.

  bool isRating = true;

  bool? visibleFollowers = false;

  bool? visibleFollowing = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TF_DisplayName widget.
  FocusNode? tFDisplayNameFocusNode;
  TextEditingController? tFDisplayNameTextController;
  String? Function(BuildContext, String?)? tFDisplayNameTextControllerValidator;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for TF_About widget.
  FocusNode? tFAboutFocusNode;
  TextEditingController? tFAboutTextController;
  String? Function(BuildContext, String?)? tFAboutTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? queryUserDoc;
  // State field(s) for bRatingEdit widget.
  double? bRatingEditValue;
  // State field(s) for bReviewEdit widget.
  FocusNode? bReviewEditFocusNode;
  TextEditingController? bReviewEditTextController;
  String? Function(BuildContext, String?)? bReviewEditTextControllerValidator;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  UsersRecord? queryUserDoc1;
  // State field(s) for RatingEdit widget.
  double? ratingEditValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tFDisplayNameFocusNode?.dispose();
    tFDisplayNameTextController?.dispose();

    tabBarController?.dispose();
    tFAboutFocusNode?.dispose();
    tFAboutTextController?.dispose();

    bReviewEditFocusNode?.dispose();
    bReviewEditTextController?.dispose();

    textFieldFocusNode1?.dispose();
    textController4?.dispose();

    textFieldFocusNode2?.dispose();
    textController5?.dispose();

    textFieldFocusNode3?.dispose();
    textController6?.dispose();
  }
}
