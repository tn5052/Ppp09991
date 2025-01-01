import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class InAppNotificationsRecord extends FirestoreRecord {
  InAppNotificationsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "info" field.
  String? _info;
  String get info => _info ?? '';
  bool hasInfo() => _info != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "meetingTime" field.
  DateTime? _meetingTime;
  DateTime? get meetingTime => _meetingTime;
  bool hasMeetingTime() => _meetingTime != null;

  // "mentor" field.
  DocumentReference? _mentor;
  DocumentReference? get mentor => _mentor;
  bool hasMentor() => _mentor != null;

  // "mentee" field.
  DocumentReference? _mentee;
  DocumentReference? get mentee => _mentee;
  bool hasMentee() => _mentee != null;

  void _initializeFields() {
    _info = snapshotData['info'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _meetingTime = snapshotData['meetingTime'] as DateTime?;
    _mentor = snapshotData['mentor'] as DocumentReference?;
    _mentee = snapshotData['mentee'] as DocumentReference?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('inAppNotifications');

  static Stream<InAppNotificationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InAppNotificationsRecord.fromSnapshot(s));

  static Future<InAppNotificationsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => InAppNotificationsRecord.fromSnapshot(s));

  static InAppNotificationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InAppNotificationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InAppNotificationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InAppNotificationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InAppNotificationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InAppNotificationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInAppNotificationsRecordData({
  String? info,
  DateTime? dateTime,
  DateTime? meetingTime,
  DocumentReference? mentor,
  DocumentReference? mentee,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'info': info,
      'dateTime': dateTime,
      'meetingTime': meetingTime,
      'mentor': mentor,
      'mentee': mentee,
    }.withoutNulls,
  );

  return firestoreData;
}

class InAppNotificationsRecordDocumentEquality
    implements Equality<InAppNotificationsRecord> {
  const InAppNotificationsRecordDocumentEquality();

  @override
  bool equals(InAppNotificationsRecord? e1, InAppNotificationsRecord? e2) {
    return e1?.info == e2?.info &&
        e1?.dateTime == e2?.dateTime &&
        e1?.meetingTime == e2?.meetingTime &&
        e1?.mentor == e2?.mentor &&
        e1?.mentee == e2?.mentee;
  }

  @override
  int hash(InAppNotificationsRecord? e) => const ListEquality()
      .hash([e?.info, e?.dateTime, e?.meetingTime, e?.mentor, e?.mentee]);

  @override
  bool isValidKey(Object? o) => o is InAppNotificationsRecord;
}
