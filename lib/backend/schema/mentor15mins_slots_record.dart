import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class Mentor15minsSlotsRecord extends FirestoreRecord {
  Mentor15minsSlotsRecord._(
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

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  bool hasCurrency() => _currency != null;

  // "linkShared" field.
  String? _linkShared;
  String get linkShared => _linkShared ?? '';
  bool hasLinkShared() => _linkShared != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _mentor = snapshotData['mentor'] as DocumentReference?;
    _mentee = snapshotData['mentee'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _price = castToType<double>(snapshotData['price']);
    _currency = snapshotData['currency'] as String?;
    _linkShared = snapshotData['linkShared'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('mentor15minsSlots')
          : FirebaseFirestore.instanceFor(
                  app: Firebase.app(), databaseId: 'talenties-5f525')
              .collectionGroup('mentor15minsSlots');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('mentor15minsSlots').doc(id);

  static Stream<Mentor15minsSlotsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Mentor15minsSlotsRecord.fromSnapshot(s));

  static Future<Mentor15minsSlotsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => Mentor15minsSlotsRecord.fromSnapshot(s));

  static Mentor15minsSlotsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      Mentor15minsSlotsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Mentor15minsSlotsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Mentor15minsSlotsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Mentor15minsSlotsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Mentor15minsSlotsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMentor15minsSlotsRecordData({
  DocumentReference? mentor,
  DocumentReference? mentee,
  DateTime? date,
  DateTime? startTime,
  DateTime? endTime,
  double? price,
  String? currency,
  String? linkShared,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'mentor': mentor,
      'mentee': mentee,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'currency': currency,
      'linkShared': linkShared,
    }.withoutNulls,
  );

  return firestoreData;
}

class Mentor15minsSlotsRecordDocumentEquality
    implements Equality<Mentor15minsSlotsRecord> {
  const Mentor15minsSlotsRecordDocumentEquality();

  @override
  bool equals(Mentor15minsSlotsRecord? e1, Mentor15minsSlotsRecord? e2) {
    return e1?.mentor == e2?.mentor &&
        e1?.mentee == e2?.mentee &&
        e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.price == e2?.price &&
        e1?.currency == e2?.currency &&
        e1?.linkShared == e2?.linkShared;
  }

  @override
  int hash(Mentor15minsSlotsRecord? e) => const ListEquality().hash([
        e?.mentor,
        e?.mentee,
        e?.date,
        e?.startTime,
        e?.endTime,
        e?.price,
        e?.currency,
        e?.linkShared
      ]);

  @override
  bool isValidKey(Object? o) => o is Mentor15minsSlotsRecord;
}
