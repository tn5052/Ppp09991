import '/components/text_filed_component/text_filed_component_widget.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'my_profile_widget.dart' show MyProfileWidget;
import 'package:flutter/material.dart';

class MyProfileModel extends MyFlutterModel<MyProfileWidget> {
  ///  Local state fields for this page.

  bool profileEdit = false;

  bool aboutEdit = false;

  bool linksEdit = false;

  List<String> linksGit = [];
  void addToLinksGit(String item) => linksGit.add(item);
  void removeFromLinksGit(String item) => linksGit.remove(item);
  void removeAtIndexFromLinksGit(int index) => linksGit.removeAt(index);
  void insertAtIndexInLinksGit(int index, String item) =>
      linksGit.insert(index, item);
  void updateLinksGitAtIndex(int index, Function(String) updateFn) =>
      linksGit[index] = updateFn(linksGit[index]);

  bool postNewPopup = false;

  bool? visibleFollowers = false;

  bool? visibleFollowing = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

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
  // State field(s) for TF_AddLinkText widget.
  FocusNode? tFAddLinkTextFocusNode;
  TextEditingController? tFAddLinkTextTextController;
  String? Function(BuildContext, String?)? tFAddLinkTextTextControllerValidator;
  // Models for textFiledComponent dynamic component.
  late MyFlutterDynamicModels<TextFiledComponentModel> textFiledComponentModels;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;

  @override
  void initState(BuildContext context) {
    textFiledComponentModels =
        MyFlutterDynamicModels(() => TextFiledComponentModel());
  }

  @override
  void dispose() {
    tFDisplayNameFocusNode?.dispose();
    tFDisplayNameTextController?.dispose();

    tabBarController?.dispose();
    tFAboutFocusNode?.dispose();
    tFAboutTextController?.dispose();

    tFAddLinkTextFocusNode?.dispose();
    tFAddLinkTextTextController?.dispose();

    textFiledComponentModels.dispose();
    textFieldFocusNode1?.dispose();
    textController4?.dispose();

    textFieldFocusNode2?.dispose();
    textController5?.dispose();
  }
}
