import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class EventRatingRecord extends FirestoreRecord {
  EventRatingRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "event" field.
  DocumentReference? _event;
  DocumentReference? get event => _event;
  bool hasEvent() => _event != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "stars" field.
  int? _stars;
  int get stars => _stars ?? 0;
  bool hasStars() => _stars != null;

  // "review" field.
  String? _review;
  String get review => _review ?? '';
  bool hasReview() => _review != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  void _initializeFields() {
    _event = snapshotData['event'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _stars = castToType<int>(snapshotData['stars']);
    _review = snapshotData['review'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('eventRating');

  static Stream<EventRatingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventRatingRecord.fromSnapshot(s));

  static Future<EventRatingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventRatingRecord.fromSnapshot(s));

  static EventRatingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EventRatingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventRatingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventRatingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventRatingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventRatingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventRatingRecordData({
  DocumentReference? event,
  DocumentReference? user,
  int? stars,
  String? review,
  DateTime? dateTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'event': event,
      'user': user,
      'stars': stars,
      'review': review,
      'dateTime': dateTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventRatingRecordDocumentEquality implements Equality<EventRatingRecord> {
  const EventRatingRecordDocumentEquality();

  @override
  bool equals(EventRatingRecord? e1, EventRatingRecord? e2) {
    return e1?.event == e2?.event &&
        e1?.user == e2?.user &&
        e1?.stars == e2?.stars &&
        e1?.review == e2?.review &&
        e1?.dateTime == e2?.dateTime;
  }

  @override
  int hash(EventRatingRecord? e) => const ListEquality()
      .hash([e?.event, e?.user, e?.stars, e?.review, e?.dateTime]);

  @override
  bool isValidKey(Object? o) => o is EventRatingRecord;
}
