import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class MenteeRecord extends FirestoreRecord {
  MenteeRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "myMentor" field.
  DocumentReference? _myMentor;
  DocumentReference? get myMentor => _myMentor;
  bool hasMyMentor() => _myMentor != null;

  // "userMentee" field.
  DocumentReference? _userMentee;
  DocumentReference? get userMentee => _userMentee;
  bool hasUserMentee() => _userMentee != null;

  // "myBookedMeetings" field.
  List<DocumentReference>? _myBookedMeetings;
  List<DocumentReference> get myBookedMeetings => _myBookedMeetings ?? const [];
  bool hasMyBookedMeetings() => _myBookedMeetings != null;

  void _initializeFields() {
    _myMentor = snapshotData['myMentor'] as DocumentReference?;
    _userMentee = snapshotData['userMentee'] as DocumentReference?;
    _myBookedMeetings = getDataList(snapshotData['myBookedMeetings']);
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('mentee');

  static Stream<MenteeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MenteeRecord.fromSnapshot(s));

  static Future<MenteeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MenteeRecord.fromSnapshot(s));

  static MenteeRecord fromSnapshot(DocumentSnapshot snapshot) => MenteeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MenteeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MenteeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MenteeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MenteeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMenteeRecordData({
  DocumentReference? myMentor,
  DocumentReference? userMentee,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'myMentor': myMentor,
      'userMentee': userMentee,
    }.withoutNulls,
  );

  return firestoreData;
}

class MenteeRecordDocumentEquality implements Equality<MenteeRecord> {
  const MenteeRecordDocumentEquality();

  @override
  bool equals(MenteeRecord? e1, MenteeRecord? e2) {
    const listEquality = ListEquality();
    return e1?.myMentor == e2?.myMentor &&
        e1?.userMentee == e2?.userMentee &&
        listEquality.equals(e1?.myBookedMeetings, e2?.myBookedMeetings);
  }

  @override
  int hash(MenteeRecord? e) => const ListEquality()
      .hash([e?.myMentor, e?.userMentee, e?.myBookedMeetings]);

  @override
  bool isValidKey(Object? o) => o is MenteeRecord;
}
