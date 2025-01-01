import 'dart:async';

import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "attendees" field.
  List<DocumentReference>? _attendees;
  List<DocumentReference> get attendees => _attendees ?? const [];
  bool hasAttendees() => _attendees != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "time_start" field.
  DateTime? _timeStart;
  DateTime? get timeStart => _timeStart;
  bool hasTimeStart() => _timeStart != null;

  // "time_end" field.
  DateTime? _timeEnd;
  DateTime? get timeEnd => _timeEnd;
  bool hasTimeEnd() => _timeEnd != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "manager" field.
  DocumentReference? _manager;
  DocumentReference? get manager => _manager;
  bool hasManager() => _manager != null;

  // "organizers" field.
  List<DocumentReference>? _organizers;
  List<DocumentReference> get organizers => _organizers ?? const [];
  bool hasOrganizers() => _organizers != null;

  // "chief_guests" field.
  List<DocumentReference>? _chiefGuests;
  List<DocumentReference> get chiefGuests => _chiefGuests ?? const [];
  bool hasChiefGuests() => _chiefGuests != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "refundable" field.
  bool? _refundable;
  bool get refundable => _refundable ?? false;
  bool hasRefundable() => _refundable != null;

  // "managerName" field.
  String? _managerName;
  String get managerName => _managerName ?? '';
  bool hasManagerName() => _managerName != null;

  // "speakers" field.
  List<DocumentReference>? _speakers;
  List<DocumentReference> get speakers => _speakers ?? const [];
  bool hasSpeakers() => _speakers != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  bool hasCurrency() => _currency != null;

  // "media" field.
  List<String>? _media;
  List<String> get media => _media ?? const [];
  bool hasMedia() => _media != null;

  // "peopleJoined" field.
  List<DocumentReference>? _peopleJoined;
  List<DocumentReference> get peopleJoined => _peopleJoined ?? const [];
  bool hasPeopleJoined() => _peopleJoined != null;

  // "summery" field.
  String? _summery;
  String get summery => _summery ?? '';
  bool hasSummery() => _summery != null;

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

  // "timesRated" field.
  int? _timesRated;
  int get timesRated => _timesRated ?? 0;
  bool hasTimesRated() => _timesRated != null;

  // "total_Rating" field.
  double? _totalRating;
  double get totalRating => _totalRating ?? 0.0;
  bool hasTotalRating() => _totalRating != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "categories" field.
  List<String>? _categories;
  List<String> get categories => _categories ?? const [];
  bool hasCategories() => _categories != null;

  // "combined_Categories" field.
  String? _combinedCategories;
  String get combinedCategories => _combinedCategories ?? '';
  bool hasCombinedCategories() => _combinedCategories != null;

  // "eventID" field.
  String? _eventID;
  String get eventID => _eventID ?? '';
  bool hasEventID() => _eventID != null;

  // "eventRef" field.
  DocumentReference? _eventRef;
  DocumentReference? get eventRef => _eventRef;
  bool hasEventRef() => _eventRef != null;

  void _initializeFields() {
    _attendees = getDataList(snapshotData['attendees']);
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _timeStart = snapshotData['time_start'] as DateTime?;
    _timeEnd = snapshotData['time_end'] as DateTime?;
    _rating = castToType<double>(snapshotData['rating']);
    _status = snapshotData['status'] as String?;
    _manager = snapshotData['manager'] as DocumentReference?;
    _organizers = getDataList(snapshotData['organizers']);
    _chiefGuests = getDataList(snapshotData['chief_guests']);
    _price = castToType<int>(snapshotData['price']);
    _refundable = snapshotData['refundable'] as bool?;
    _managerName = snapshotData['managerName'] as String?;
    _speakers = getDataList(snapshotData['speakers']);
    _currency = snapshotData['currency'] as String?;
    _media = getDataList(snapshotData['media']);
    _peopleJoined = getDataList(snapshotData['peopleJoined']);
    _summery = snapshotData['summery'] as String?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _timesRated = castToType<int>(snapshotData['timesRated']);
    _totalRating = castToType<double>(snapshotData['total_Rating']);
    _address = snapshotData['address'] as String?;
    _categories = getDataList(snapshotData['categories']);
    _combinedCategories = snapshotData['combined_Categories'] as String?;
    _eventID = snapshotData['eventID'] as String?;
    _eventRef = snapshotData['eventRef'] as DocumentReference?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  static EventsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      EventsRecord.getDocumentFromData(
        {
          'attendees': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['attendees'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'name': snapshot.data['name'],
          'description': snapshot.data['description'],
          'location': convertAlgoliaParam(
            snapshot.data,
            ParamType.LatLng,
            false,
          ),
          'time_start': convertAlgoliaParam(
            snapshot.data['time_start'],
            ParamType.DateTime,
            false,
          ),
          'time_end': convertAlgoliaParam(
            snapshot.data['time_end'],
            ParamType.DateTime,
            false,
          ),
          'rating': convertAlgoliaParam(
            snapshot.data['rating'],
            ParamType.double,
            false,
          ),
          'status': snapshot.data['status'],
          'manager': convertAlgoliaParam(
            snapshot.data['manager'],
            ParamType.DocumentReference,
            false,
          ),
          'organizers': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['organizers'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'chief_guests': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['chief_guests'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'price': convertAlgoliaParam(
            snapshot.data['price'],
            ParamType.int,
            false,
          ),
          'refundable': snapshot.data['refundable'],
          'managerName': snapshot.data['managerName'],
          'speakers': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['speakers'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'currency': snapshot.data['currency'],
          'media': safeGet(
            () => snapshot.data['media'].toList(),
          ),
          'peopleJoined': safeGet(
            () => convertAlgoliaParam<DocumentReference>(
              snapshot.data['peopleJoined'],
              ParamType.DocumentReference,
              true,
            ).toList(),
          ),
          'summery': snapshot.data['summery'],
          'email': snapshot.data['email'],
          'display_name': snapshot.data['display_name'],
          'photo_url': snapshot.data['photo_url'],
          'uid': snapshot.data['uid'],
          'created_time': convertAlgoliaParam(
            snapshot.data['created_time'],
            ParamType.DateTime,
            false,
          ),
          'phone_number': snapshot.data['phone_number'],
          'timesRated': convertAlgoliaParam(
            snapshot.data['timesRated'],
            ParamType.int,
            false,
          ),
          'total_Rating': convertAlgoliaParam(
            snapshot.data['total_Rating'],
            ParamType.double,
            false,
          ),
          'address': snapshot.data['address'],
          'categories': safeGet(
            () => snapshot.data['categories'].toList(),
          ),
          'combined_Categories': snapshot.data['combined_Categories'],
          'eventID': snapshot.data['eventID'],
          'eventRef': convertAlgoliaParam(
            snapshot.data['eventRef'],
            ParamType.DocumentReference,
            false,
          ),
        },
        EventsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<EventsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'events',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? name,
  String? description,
  LatLng? location,
  DateTime? timeStart,
  DateTime? timeEnd,
  double? rating,
  String? status,
  DocumentReference? manager,
  int? price,
  bool? refundable,
  String? managerName,
  String? currency,
  String? summery,
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? timesRated,
  double? totalRating,
  String? address,
  String? combinedCategories,
  String? eventID,
  DocumentReference? eventRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'location': location,
      'time_start': timeStart,
      'time_end': timeEnd,
      'rating': rating,
      'status': status,
      'manager': manager,
      'price': price,
      'refundable': refundable,
      'managerName': managerName,
      'currency': currency,
      'summery': summery,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'timesRated': timesRated,
      'total_Rating': totalRating,
      'address': address,
      'combined_Categories': combinedCategories,
      'eventID': eventID,
      'eventRef': eventRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.attendees, e2?.attendees) &&
        e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.location == e2?.location &&
        e1?.timeStart == e2?.timeStart &&
        e1?.timeEnd == e2?.timeEnd &&
        e1?.rating == e2?.rating &&
        e1?.status == e2?.status &&
        e1?.manager == e2?.manager &&
        listEquality.equals(e1?.organizers, e2?.organizers) &&
        listEquality.equals(e1?.chiefGuests, e2?.chiefGuests) &&
        e1?.price == e2?.price &&
        e1?.refundable == e2?.refundable &&
        e1?.managerName == e2?.managerName &&
        listEquality.equals(e1?.speakers, e2?.speakers) &&
        e1?.currency == e2?.currency &&
        listEquality.equals(e1?.media, e2?.media) &&
        listEquality.equals(e1?.peopleJoined, e2?.peopleJoined) &&
        e1?.summery == e2?.summery &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.timesRated == e2?.timesRated &&
        e1?.totalRating == e2?.totalRating &&
        e1?.address == e2?.address &&
        listEquality.equals(e1?.categories, e2?.categories) &&
        e1?.combinedCategories == e2?.combinedCategories &&
        e1?.eventID == e2?.eventID &&
        e1?.eventRef == e2?.eventRef;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.attendees,
        e?.name,
        e?.description,
        e?.location,
        e?.timeStart,
        e?.timeEnd,
        e?.rating,
        e?.status,
        e?.manager,
        e?.organizers,
        e?.chiefGuests,
        e?.price,
        e?.refundable,
        e?.managerName,
        e?.speakers,
        e?.currency,
        e?.media,
        e?.peopleJoined,
        e?.summery,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.timesRated,
        e?.totalRating,
        e?.address,
        e?.categories,
        e?.combinedCategories,
        e?.eventID,
        e?.eventRef
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
