// Automatic MyFlutter imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'index.dart'; // Imports other custom actions
import '/my_flutter/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

// Assuming bookedByMeetingSlots is a public variable in MentorMeetingSlotsRecord
// Assuming MentorMeetingSlotsRecord is a class representing the structure of a mentor meeting slot document
class MentorMeetingSlotsRecord {
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final DocumentReference<Object?> mentor;
  final List<String> slotsMeetingAvailable;
  final List<String> bookedMeetingSlots;
  final List<String> remainingMeetingSlots;
  final List<DocumentReference<Object?>> bookedByMeetingSlots;

  MentorMeetingSlotsRecord({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.mentor,
    required this.slotsMeetingAvailable,
    required this.bookedMeetingSlots,
    required this.remainingMeetingSlots,
    required this.bookedByMeetingSlots,
  });
}

// Function to update bookedByMeetingSlots in MentorMeetingSlotsRecord
MentorMeetingSlotsRecord updateBookedByMeetingSlots(
  MentorMeetingSlotsRecord originalRecord,
  List<DocumentReference<Object?>> newBookedByMeetingSlots,
) {
  return MentorMeetingSlotsRecord(
    date: originalRecord.date,
    startTime: originalRecord.startTime,
    endTime: originalRecord.endTime,
    mentor: originalRecord.mentor,
    slotsMeetingAvailable: originalRecord.slotsMeetingAvailable,
    bookedMeetingSlots: originalRecord.bookedMeetingSlots,
    remainingMeetingSlots: originalRecord.remainingMeetingSlots,
    bookedByMeetingSlots: newBookedByMeetingSlots,
  );
}

// Function to update bookedByMeetingSlots in the document
Future<void> cfBookedByInCardDoc(
  DocumentReference<Object?>? userID,
  MentorMeetingSlotsRecord? meetingDocCard,
  int? slotIndex,
) async {
  if (userID != null && meetingDocCard != null && slotIndex != null) {
    // Get the current bookedByMeetingSlots array
    List<DocumentReference<Object?>> currentBookedByMeetingSlots =
        List.from(meetingDocCard.bookedByMeetingSlots);

    // Update or add the userID at the specified slotIndex
    if (slotIndex >= 0 && slotIndex < currentBookedByMeetingSlots.length) {
      // If the slotIndex already exists, update the value
      currentBookedByMeetingSlots[slotIndex] = userID;
    } else if (slotIndex == currentBookedByMeetingSlots.length) {
      // If the slotIndex is the next available index, add the userID
      currentBookedByMeetingSlots.add(userID);
    } else {
      // Handle invalid slotIndex
      throw Exception("Invalid slot index");
    }

    // Create a new instance of MentorMeetingSlotsRecord with the updated bookedByMeetingSlots
    MentorMeetingSlotsRecord updatedRecord = updateBookedByMeetingSlots(
      meetingDocCard,
      currentBookedByMeetingSlots,
    );

    // Optionally, you might want to perform further actions here

    // You may want to update the UI or trigger some other logic

    // For now, let's print the updated meetingDocCard
    print(updatedRecord);
  } else {
    throw Exception("Invalid arguments");
  }
}
