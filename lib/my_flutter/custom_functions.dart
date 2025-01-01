import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<String>? newCustomFunction(
  DateTime? startTime,
  DateTime? endTime,
) {
  if (startTime == null || endTime == null) {
    return null;
  }

  // Swap start and end times if end time is before start time
  if (endTime.isBefore(startTime)) {
    final temp = endTime;
    endTime = startTime;
    startTime = temp;
  }

  List<String> slots = [];

  DateTime slotStartTime = DateTime(startTime.year, startTime.month,
      startTime.day, startTime.hour, startTime.minute);
  DateTime slotEndTime;

  while (slotStartTime.isBefore(endTime)) {
    slotEndTime = slotStartTime.add(Duration(minutes: 15));

    // Check if the slot end time is after the end time
    if (slotEndTime.isAfter(endTime)) {
      break;
    }

    String slotString = DateFormat.jm().format(slotStartTime) +
        ' - ' +
        DateFormat.jm().format(slotEndTime);
    slots.add(slotString);

    slotStartTime = slotEndTime;
  }

  return slots;
}

DateTime? cFDate1Time2(
  DateTime? dateSelected,
  DateTime? timeSelected,
) {
  /// Ensure both dateSelected and timeSelected are not null
  if (dateSelected == null || timeSelected == null) {
    return null;
  }

  /// Combine the date from dateSelected with the time from timeSelected
  return DateTime(
    dateSelected.year,
    dateSelected.month,
    dateSelected.day,
    timeSelected.hour,
    timeSelected.minute,
  );
}

DateTime? cfAddSlots15MinTime(
  DateTime? startTime15,
  int? indexTime,
) {
  if (startTime15 == null || indexTime == null) return null;

  return startTime15.add(Duration(minutes: indexTime * 15));
}

DateTime? cfAddSlots15MinTime2(
  DateTime? startTime15,
  int? indexTime,
) {
  if (startTime15 == null || indexTime == null) return null;

  return startTime15.add(Duration(minutes: (indexTime + 1) * 15));
}

double? calRatingAverage(UsersRecord? userDoc) {
  if (userDoc == null) return 0.0;

  // Directly access the fields from the userDoc, since it's now the document itself
  int? mentorTimesRated = userDoc.mentorTimesRated as int?;
  int? mentorRating = userDoc.mentorRating as int?;

  // Check if mentorTimesRated or mentorRating are null or zero
  if (mentorTimesRated == null ||
      mentorRating == null ||
      mentorTimesRated == 0) {
    return 0.0;
  }

  // Perform division and format to 1 decimal place
  double result = mentorRating / mentorTimesRated;
  return double.parse(result.toStringAsFixed(1));
}

String? combineListToSingleString(List<String>? categoriesList) {
  if (categoriesList == null || categoriesList.isEmpty) {
    return null;
  }

  return 'All ${categoriesList.join(' ')}';
}

String? getUserFromScan(String? scanResult) {
  if (scanResult == null || !scanResult.contains('++')) {
    return null; // Return null if scanResult is null or does not contain '++'
  }

  // Extract the part before '++' (though returning as DocumentReference)
  String userId = scanResult.split('++').last;

  // Returning userId as DocumentReference would require customization or adaptation to your needs.
  return userId;
}

String? getEventFromScan(String? scanResult) {
  if (scanResult == null || !scanResult.contains('++')) {
    return null; // Return null if scanResult is null or does not contain '++'
  }

  // Extract the part before '++' (though returning as DocumentReference)
  String eventID = scanResult.split('++').first;

  // Returning userId as DocumentReference would require customization or adaptation to your needs.
  return eventID;
}
