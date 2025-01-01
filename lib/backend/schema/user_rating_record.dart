import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class UserRatingRecord extends FirestoreRecord {
  UserRatingRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "mentor" field.
  DocumentReference? _mentor;
  DocumentReference? get mentor => _mentor;
  bool hasMentor() => _mentor != null;

  // "mentee" field.
  DocumentReference? _mentee;
  DocumentReference? get mentee => _mentee;
  bool hasMentee() => _mentee != null;

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

  // "menteeName" field.
  String? _menteeName;
  String get menteeName => _menteeName ?? '';
  bool hasMenteeName() => _menteeName != null;

  // "menteeImage" field.
  String? _menteeImage;
  String get menteeImage => _menteeImage ?? '';
  bool hasMenteeImage() => _menteeImage != null;

  void _initializeFields() {
    _mentor = snapshotData['mentor'] as DocumentReference?;
    _mentee = snapshotData['mentee'] as DocumentReference?;
    _stars = castToType<int>(snapshotData['stars']);
    _review = snapshotData['review'] as String?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _menteeName = snapshotData['menteeName'] as String?;
    _menteeImage = snapshotData['menteeImage'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('userRating');

  static Stream<UserRatingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserRatingRecord.fromSnapshot(s));

  static Future<UserRatingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserRatingRecord.fromSnapshot(s));

  static UserRatingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserRatingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserRatingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserRatingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserRatingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserRatingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserRatingRecordData({
  DocumentReference? mentor,
  DocumentReference? mentee,
  int? stars,
  String? review,
  DateTime? dateTime,
  String? menteeName,
  String? menteeImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'mentor': mentor,
      'mentee': mentee,
      'stars': stars,
      'review': review,
      'dateTime': dateTime,
      'menteeName': menteeName,
      'menteeImage': menteeImage,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserRatingRecordDocumentEquality implements Equality<UserRatingRecord> {
  const UserRatingRecordDocumentEquality();

  @override
  bool equals(UserRatingRecord? e1, UserRatingRecord? e2) {
    return e1?.mentor == e2?.mentor &&
        e1?.mentee == e2?.mentee &&
        e1?.stars == e2?.stars &&
        e1?.review == e2?.review &&
        e1?.dateTime == e2?.dateTime &&
        e1?.menteeName == e2?.menteeName &&
        e1?.menteeImage == e2?.menteeImage;
  }

  @override
  int hash(UserRatingRecord? e) => const ListEquality().hash([
        e?.mentor,
        e?.mentee,
        e?.stars,
        e?.review,
        e?.dateTime,
        e?.menteeName,
        e?.menteeImage
      ]);

  @override
  bool isValidKey(Object? o) => o is UserRatingRecord;
}
