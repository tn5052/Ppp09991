// ignore_for_file: unnecessary_getters_setters
import '/backend/algolia/serialization_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/my_flutter/my_flutter_util.dart';

class EventScanResultStruct extends FFFirebaseStruct {
  EventScanResultStruct({
    DocumentReference? userRef,
    DocumentReference? eventRef,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _eventRef = eventRef,
        super(firestoreUtilData);

  // "User_Ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "Event_Ref" field.
  DocumentReference? _eventRef;
  DocumentReference? get eventRef => _eventRef;
  set eventRef(DocumentReference? val) => _eventRef = val;

  bool hasEventRef() => _eventRef != null;

  static EventScanResultStruct fromMap(Map<String, dynamic> data) =>
      EventScanResultStruct(
        userRef: data['User_Ref'] as DocumentReference?,
        eventRef: data['Event_Ref'] as DocumentReference?,
      );

  static EventScanResultStruct? maybeFromMap(dynamic data) => data is Map
      ? EventScanResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'User_Ref': _userRef,
        'Event_Ref': _eventRef,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'User_Ref': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'Event_Ref': serializeParam(
          _eventRef,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static EventScanResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventScanResultStruct(
        userRef: deserializeParam(
          data['User_Ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        eventRef: deserializeParam(
          data['Event_Ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['events'],
        ),
      );

  static EventScanResultStruct fromAlgoliaData(Map<String, dynamic> data) =>
      EventScanResultStruct(
        userRef: convertAlgoliaParam(
          data['User_Ref'],
          ParamType.DocumentReference,
          false,
        ),
        eventRef: convertAlgoliaParam(
          data['Event_Ref'],
          ParamType.DocumentReference,
          false,
        ),
        firestoreUtilData: const FirestoreUtilData(
          clearUnsetFields: false,
          create: true,
        ),
      );

  @override
  String toString() => 'EventScanResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventScanResultStruct &&
        userRef == other.userRef &&
        eventRef == other.eventRef;
  }

  @override
  int get hashCode => const ListEquality().hash([userRef, eventRef]);
}

EventScanResultStruct createEventScanResultStruct({
  DocumentReference? userRef,
  DocumentReference? eventRef,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventScanResultStruct(
      userRef: userRef,
      eventRef: eventRef,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventScanResultStruct? updateEventScanResultStruct(
  EventScanResultStruct? eventScanResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventScanResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventScanResultStructData(
  Map<String, dynamic> firestoreData,
  EventScanResultStruct? eventScanResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventScanResult == null) {
    return;
  }
  if (eventScanResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventScanResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventScanResultData =
      getEventScanResultFirestoreData(eventScanResult, forFieldValue);
  final nestedData =
      eventScanResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventScanResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventScanResultFirestoreData(
  EventScanResultStruct? eventScanResult, [
  bool forFieldValue = false,
]) {
  if (eventScanResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventScanResult.toMap());

  // Add any Firestore field values
  eventScanResult.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventScanResultListFirestoreData(
  List<EventScanResultStruct>? eventScanResults,
) =>
    eventScanResults
        ?.map((e) => getEventScanResultFirestoreData(e, true))
        .toList() ??
    [];
