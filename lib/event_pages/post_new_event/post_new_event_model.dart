import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'post_new_event_widget.dart' show PostNewEventWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PostNewEventModel extends MyFlutterModel<PostNewEventWidget> {
  ///  Local state fields for this page.

  bool bottomAddMembersListSheet = false;

  List<DocumentReference> speakersList = [];
  void addToSpeakersList(DocumentReference item) => speakersList.add(item);
  void removeFromSpeakersList(DocumentReference item) =>
      speakersList.remove(item);
  void removeAtIndexFromSpeakersList(int index) => speakersList.removeAt(index);
  void insertAtIndexInSpeakersList(int index, DocumentReference item) =>
      speakersList.insert(index, item);
  void updateSpeakersListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      speakersList[index] = updateFn(speakersList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for tf_EventName widget.
  FocusNode? tfEventNameFocusNode;
  TextEditingController? tfEventNameTextController;
  String? Function(BuildContext, String?)? tfEventNameTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = const FFPlace();
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for tf_description widget.
  FocusNode? tfDescriptionFocusNode;
  TextEditingController? tfDescriptionTextController;
  String? Function(BuildContext, String?)? tfDescriptionTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox_TC widget.
  bool? checkboxTCValue;
  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl4 = '';

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  EventsRecord? createDocActionOutput1;
  AudioPlayer? soundPlayer1;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  EventsRecord? createDocActionOutput2;
  AudioPlayer? soundPlayer2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for Checkbox widget.
  Map<UsersRecord, bool> checkboxValueMap2 = {};
  List<UsersRecord> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfEventNameFocusNode?.dispose();
    tfEventNameTextController?.dispose();

    textFieldFocusNode1?.dispose();
    textController2?.dispose();

    tfDescriptionFocusNode?.dispose();
    tfDescriptionTextController?.dispose();

    textFieldFocusNode2?.dispose();
    textController4?.dispose();

    textFieldFocusNode3?.dispose();
    textController5?.dispose();
  }
}
