import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class MentorMeetingSlotsRecord extends FirestoreRecord {
  MentorMeetingSlotsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "mentor" field.
  DocumentReference? _mentor;
  DocumentReference? get mentor => _mentor;
  bool hasMentor() => _mentor != null;

  // "slotsMeetingAvailabe" field.
  List<String>? _slotsMeetingAvailabe;
  List<String> get slotsMeetingAvailabe => _slotsMeetingAvailabe ?? const [];
  bool hasSlotsMeetingAvailabe() => _slotsMeetingAvailabe != null;

  // "bookedMeetingSlots" field.
  List<String>? _bookedMeetingSlots;
  List<String> get bookedMeetingSlots => _bookedMeetingSlots ?? const [];
  bool hasBookedMeetingSlots() => _bookedMeetingSlots != null;

  // "remainingMeetingSlots" field.
  List<String>? _remainingMeetingSlots;
  List<String> get remainingMeetingSlots => _remainingMeetingSlots ?? const [];
  bool hasRemainingMeetingSlots() => _remainingMeetingSlots != null;

  // "bookedByMeetingSlots" field.
  List<DocumentReference>? _bookedByMeetingSlots;
  List<DocumentReference> get bookedByMeetingSlots =>
      _bookedByMeetingSlots ?? const [];
  bool hasBookedByMeetingSlots() => _bookedByMeetingSlots != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _mentor = snapshotData['mentor'] as DocumentReference?;
    _slotsMeetingAvailabe = getDataList(snapshotData['slotsMeetingAvailabe']);
    _bookedMeetingSlots = getDataList(snapshotData['bookedMeetingSlots']);
    _remainingMeetingSlots = getDataList(snapshotData['remainingMeetingSlots']);
    _bookedByMeetingSlots = getDataList(snapshotData['bookedByMeetingSlots']);
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('mentorMeetingSlots');

  static Stream<MentorMeetingSlotsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MentorMeetingSlotsRecord.fromSnapshot(s));

  static Future<MentorMeetingSlotsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => MentorMeetingSlotsRecord.fromSnapshot(s));

  static MentorMeetingSlotsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MentorMeetingSlotsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MentorMeetingSlotsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MentorMeetingSlotsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MentorMeetingSlotsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MentorMeetingSlotsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMentorMeetingSlotsRecordData({
  DateTime? date,
  DateTime? startTime,
  DateTime? endTime,
  DocumentReference? mentor,
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'mentor': mentor,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class MentorMeetingSlotsRecordDocumentEquality
    implements Equality<MentorMeetingSlotsRecord> {
  const MentorMeetingSlotsRecordDocumentEquality();

  @override
  bool equals(MentorMeetingSlotsRecord? e1, MentorMeetingSlotsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.mentor == e2?.mentor &&
        listEquality.equals(
            e1?.slotsMeetingAvailabe, e2?.slotsMeetingAvailabe) &&
        listEquality.equals(e1?.bookedMeetingSlots, e2?.bookedMeetingSlots) &&
        listEquality.equals(
            e1?.remainingMeetingSlots, e2?.remainingMeetingSlots) &&
        listEquality.equals(
            e1?.bookedByMeetingSlots, e2?.bookedByMeetingSlots) &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(MentorMeetingSlotsRecord? e) => const ListEquality().hash([
        e?.date,
        e?.startTime,
        e?.endTime,
        e?.mentor,
        e?.slotsMeetingAvailabe,
        e?.bookedMeetingSlots,
        e?.remainingMeetingSlots,
        e?.bookedByMeetingSlots,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is MentorMeetingSlotsRecord;
}
