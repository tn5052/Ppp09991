import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'create_meetings_slots_widget.dart' show CreateMeetingsSlotsWidget;
import 'package:flutter/material.dart';

class CreateMeetingsSlotsModel
    extends MyFlutterModel<CreateMeetingsSlotsWidget> {
  ///  Local state fields for this page.

  DateTime? timeStartLocal;

  DateTime? timeEndLocal;

  bool liveSlotsEdit = true;

  bool addMeetSlots = true;

  DateTime? dateLocal;

  MentorMeetingSlotsRecord? selectedSlot;

  DateTime? eTimeStartLocal;

  DateTime? eTimeEndLocal;

  DateTime? eDateLocal;

  bool viewMeetSlots = true;

  int? loopIndexAddSlots = 0;

  bool isMenteeCardVisible = true;

  DocumentReference? menteeRef;

  Mentor15minsSlotsRecord? selectedSlot15min;

  bool editPrice = false;

  List<String> selectedSlotsIndexes = [];
  void addToSelectedSlotsIndexes(String item) => selectedSlotsIndexes.add(item);
  void removeFromSelectedSlotsIndexes(String item) =>
      selectedSlotsIndexes.remove(item);
  void removeAtIndexFromSelectedSlotsIndexes(int index) =>
      selectedSlotsIndexes.removeAt(index);
  void insertAtIndexInSelectedSlotsIndexes(int index, String item) =>
      selectedSlotsIndexes.insert(index, item);
  void updateSelectedSlotsIndexesAtIndex(
          int index, Function(String) updateFn) =>
      selectedSlotsIndexes[index] = updateFn(selectedSlotsIndexes[index]);

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for cc_selectSlots widget.
  FormFieldController<List<String>>? ccSelectSlotsValueController;
  List<String>? get ccSelectSlotsValues => ccSelectSlotsValueController?.value;
  set ccSelectSlotsValues(List<String>? val) =>
      ccSelectSlotsValueController?.value = val;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  MentorMeetingSlotsRecord? aoMentorMeetingSlots;
  DateTime? datePicked4;
  DateTime? datePicked5;
  DateTime? datePicked6;
  // State field(s) for TF_PriceMeetingSlot widget.
  FocusNode? tFPriceMeetingSlotFocusNode;
  TextEditingController? tFPriceMeetingSlotTextController;
  String? Function(BuildContext, String?)?
      tFPriceMeetingSlotTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tFPriceMeetingSlotFocusNode?.dispose();
    tFPriceMeetingSlotTextController?.dispose();
  }
}
