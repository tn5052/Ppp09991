import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

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

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "about" field.
  String? _about;
  String get about => _about ?? '';
  bool hasAbout() => _about != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "links" field.
  List<String>? _links;
  List<String> get links => _links ?? const [];
  bool hasLinks() => _links != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "interests" field.
  List<String>? _interests;
  List<String> get interests => _interests ?? const [];
  bool hasInterests() => _interests != null;

  // "mentorRating" field.
  double? _mentorRating;
  double get mentorRating => _mentorRating ?? 0.0;
  bool hasMentorRating() => _mentorRating != null;

  // "mentorTimesRated" field.
  double? _mentorTimesRated;
  double get mentorTimesRated => _mentorTimesRated ?? 0.0;
  bool hasMentorTimesRated() => _mentorTimesRated != null;

  // "followings" field.
  List<DocumentReference>? _followings;
  List<DocumentReference> get followings => _followings ?? const [];
  bool hasFollowings() => _followings != null;

  // "followers" field.
  List<DocumentReference>? _followers;
  List<DocumentReference> get followers => _followers ?? const [];
  bool hasFollowers() => _followers != null;

  // "spotlight1" field.
  String? _spotlight1;
  String get spotlight1 => _spotlight1 ?? '';
  bool hasSpotlight1() => _spotlight1 != null;

  // "spotlight2" field.
  String? _spotlight2;
  String get spotlight2 => _spotlight2 ?? '';
  bool hasSpotlight2() => _spotlight2 != null;

  // "spotlight3" field.
  String? _spotlight3;
  String get spotlight3 => _spotlight3 ?? '';
  bool hasSpotlight3() => _spotlight3 != null;

  // "priceMeetingSlot" field.
  double? _priceMeetingSlot;
  double get priceMeetingSlot => _priceMeetingSlot ?? 0.0;
  bool hasPriceMeetingSlot() => _priceMeetingSlot != null;

  // "eventTickets" field.
  List<DocumentReference>? _eventTickets;
  List<DocumentReference> get eventTickets => _eventTickets ?? const [];
  bool hasEventTickets() => _eventTickets != null;

  // "eventPayment" field.
  List<String>? _eventPayment;
  List<String> get eventPayment => _eventPayment ?? const [];
  bool hasEventPayment() => _eventPayment != null;

  // "mentorPayment" field.
  List<String>? _mentorPayment;
  List<String> get mentorPayment => _mentorPayment ?? const [];
  bool hasMentorPayment() => _mentorPayment != null;

  // "interestsCombined" field.
  String? _interestsCombined;
  String get interestsCombined => _interestsCombined ?? '';
  bool hasInterestsCombined() => _interestsCombined != null;

  // "mentors" field.
  List<DocumentReference>? _mentors;
  List<DocumentReference> get mentors => _mentors ?? const [];
  bool hasMentors() => _mentors != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _password = snapshotData['password'] as String?;
    _about = snapshotData['about'] as String?;
    _status = snapshotData['status'] as String?;
    _links = getDataList(snapshotData['links']);
    _rating = castToType<double>(snapshotData['rating']);
    _interests = getDataList(snapshotData['interests']);
    _mentorRating = castToType<double>(snapshotData['mentorRating']);
    _mentorTimesRated = castToType<double>(snapshotData['mentorTimesRated']);
    _followings = getDataList(snapshotData['followings']);
    _followers = getDataList(snapshotData['followers']);
    _spotlight1 = snapshotData['spotlight1'] as String?;
    _spotlight2 = snapshotData['spotlight2'] as String?;
    _spotlight3 = snapshotData['spotlight3'] as String?;
    _priceMeetingSlot = castToType<double>(snapshotData['priceMeetingSlot']);
    _eventTickets = getDataList(snapshotData['eventTickets']);
    _eventPayment = getDataList(snapshotData['eventPayment']);
    _mentorPayment = getDataList(snapshotData['mentorPayment']);
    _interestsCombined = snapshotData['interestsCombined'] as String?;
    _mentors = getDataList(snapshotData['mentors']);
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? password,
  String? about,
  String? status,
  double? rating,
  double? mentorRating,
  double? mentorTimesRated,
  String? spotlight1,
  String? spotlight2,
  String? spotlight3,
  double? priceMeetingSlot,
  String? interestsCombined,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'password': password,
      'about': about,
      'status': status,
      'rating': rating,
      'mentorRating': mentorRating,
      'mentorTimesRated': mentorTimesRated,
      'spotlight1': spotlight1,
      'spotlight2': spotlight2,
      'spotlight3': spotlight3,
      'priceMeetingSlot': priceMeetingSlot,
      'interestsCombined': interestsCombined,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.password == e2?.password &&
        e1?.about == e2?.about &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.links, e2?.links) &&
        e1?.rating == e2?.rating &&
        listEquality.equals(e1?.interests, e2?.interests) &&
        e1?.mentorRating == e2?.mentorRating &&
        e1?.mentorTimesRated == e2?.mentorTimesRated &&
        listEquality.equals(e1?.followings, e2?.followings) &&
        listEquality.equals(e1?.followers, e2?.followers) &&
        e1?.spotlight1 == e2?.spotlight1 &&
        e1?.spotlight2 == e2?.spotlight2 &&
        e1?.spotlight3 == e2?.spotlight3 &&
        e1?.priceMeetingSlot == e2?.priceMeetingSlot &&
        listEquality.equals(e1?.eventTickets, e2?.eventTickets) &&
        listEquality.equals(e1?.eventPayment, e2?.eventPayment) &&
        listEquality.equals(e1?.mentorPayment, e2?.mentorPayment) &&
        e1?.interestsCombined == e2?.interestsCombined &&
        listEquality.equals(e1?.mentors, e2?.mentors);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.password,
        e?.about,
        e?.status,
        e?.links,
        e?.rating,
        e?.interests,
        e?.mentorRating,
        e?.mentorTimesRated,
        e?.followings,
        e?.followers,
        e?.spotlight1,
        e?.spotlight2,
        e?.spotlight3,
        e?.priceMeetingSlot,
        e?.eventTickets,
        e?.eventPayment,
        e?.mentorPayment,
        e?.interestsCombined,
        e?.mentors
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
