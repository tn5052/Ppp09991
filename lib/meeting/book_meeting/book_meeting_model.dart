import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'book_meeting_widget.dart' show BookMeetingWidget;
import 'package:flutter/material.dart';

class BookMeetingModel extends MyFlutterModel<BookMeetingWidget> {
  ///  Local state fields for this page.

  List<MentorMeetingSlotsRecord> copyMeetingCards = [];
  void addToCopyMeetingCards(MentorMeetingSlotsRecord item) =>
      copyMeetingCards.add(item);
  void removeFromCopyMeetingCards(MentorMeetingSlotsRecord item) =>
      copyMeetingCards.remove(item);
  void removeAtIndexFromCopyMeetingCards(int index) =>
      copyMeetingCards.removeAt(index);
  void insertAtIndexInCopyMeetingCards(
          int index, MentorMeetingSlotsRecord item) =>
      copyMeetingCards.insert(index, item);
  void updateCopyMeetingCardsAtIndex(
          int index, Function(MentorMeetingSlotsRecord) updateFn) =>
      copyMeetingCards[index] = updateFn(copyMeetingCards[index]);

  List<Mentor15minsSlotsRecord> copyMentor15Slots = [];
  void addToCopyMentor15Slots(Mentor15minsSlotsRecord item) =>
      copyMentor15Slots.add(item);
  void removeFromCopyMentor15Slots(Mentor15minsSlotsRecord item) =>
      copyMentor15Slots.remove(item);
  void removeAtIndexFromCopyMentor15Slots(int index) =>
      copyMentor15Slots.removeAt(index);
  void insertAtIndexInCopyMentor15Slots(
          int index, Mentor15minsSlotsRecord item) =>
      copyMentor15Slots.insert(index, item);
  void updateCopyMentor15SlotsAtIndex(
          int index, Function(Mentor15minsSlotsRecord) updateFn) =>
      copyMentor15Slots[index] = updateFn(copyMentor15Slots[index]);

  Mentor15minsSlotsRecord? selected15Slot;

  DateTime? newSelectedSlot;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Stripe Payment] action in Button widget.
  String? paymentId;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
