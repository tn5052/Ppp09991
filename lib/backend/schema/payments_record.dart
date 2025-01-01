import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class PaymentsRecord extends FirestoreRecord {
  PaymentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "PaymentBy" field.
  DocumentReference? _paymentBy;
  DocumentReference? get paymentBy => _paymentBy;
  bool hasPaymentBy() => _paymentBy != null;

  // "PayedTo" field.
  DocumentReference? _payedTo;
  DocumentReference? get payedTo => _payedTo;
  bool hasPayedTo() => _payedTo != null;

  // "PaymentDateTime" field.
  DateTime? _paymentDateTime;
  DateTime? get paymentDateTime => _paymentDateTime;
  bool hasPaymentDateTime() => _paymentDateTime != null;

  // "ViaBankAccount" field.
  String? _viaBankAccount;
  String get viaBankAccount => _viaBankAccount ?? '';
  bool hasViaBankAccount() => _viaBankAccount != null;

  // "ToBankAccount" field.
  String? _toBankAccount;
  String get toBankAccount => _toBankAccount ?? '';
  bool hasToBankAccount() => _toBankAccount != null;

  // "ReasonOfPayment" field.
  String? _reasonOfPayment;
  String get reasonOfPayment => _reasonOfPayment ?? '';
  bool hasReasonOfPayment() => _reasonOfPayment != null;

  // "EventTicks" field.
  List<DocumentReference>? _eventTicks;
  List<DocumentReference> get eventTicks => _eventTicks ?? const [];
  bool hasEventTicks() => _eventTicks != null;

  // "MeetingTickets" field.
  List<DocumentReference>? _meetingTickets;
  List<DocumentReference> get meetingTickets => _meetingTickets ?? const [];
  bool hasMeetingTickets() => _meetingTickets != null;

  void _initializeFields() {
    _paymentBy = snapshotData['PaymentBy'] as DocumentReference?;
    _payedTo = snapshotData['PayedTo'] as DocumentReference?;
    _paymentDateTime = snapshotData['PaymentDateTime'] as DateTime?;
    _viaBankAccount = snapshotData['ViaBankAccount'] as String?;
    _toBankAccount = snapshotData['ToBankAccount'] as String?;
    _reasonOfPayment = snapshotData['ReasonOfPayment'] as String?;
    _eventTicks = getDataList(snapshotData['EventTicks']);
    _meetingTickets = getDataList(snapshotData['MeetingTickets']);
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('payments');

  static Stream<PaymentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentsRecord.fromSnapshot(s));

  static Future<PaymentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentsRecord.fromSnapshot(s));

  static PaymentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentsRecordData({
  DocumentReference? paymentBy,
  DocumentReference? payedTo,
  DateTime? paymentDateTime,
  String? viaBankAccount,
  String? toBankAccount,
  String? reasonOfPayment,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'PaymentBy': paymentBy,
      'PayedTo': payedTo,
      'PaymentDateTime': paymentDateTime,
      'ViaBankAccount': viaBankAccount,
      'ToBankAccount': toBankAccount,
      'ReasonOfPayment': reasonOfPayment,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentsRecordDocumentEquality implements Equality<PaymentsRecord> {
  const PaymentsRecordDocumentEquality();

  @override
  bool equals(PaymentsRecord? e1, PaymentsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.paymentBy == e2?.paymentBy &&
        e1?.payedTo == e2?.payedTo &&
        e1?.paymentDateTime == e2?.paymentDateTime &&
        e1?.viaBankAccount == e2?.viaBankAccount &&
        e1?.toBankAccount == e2?.toBankAccount &&
        e1?.reasonOfPayment == e2?.reasonOfPayment &&
        listEquality.equals(e1?.eventTicks, e2?.eventTicks) &&
        listEquality.equals(e1?.meetingTickets, e2?.meetingTickets);
  }

  @override
  int hash(PaymentsRecord? e) => const ListEquality().hash([
        e?.paymentBy,
        e?.payedTo,
        e?.paymentDateTime,
        e?.viaBankAccount,
        e?.toBankAccount,
        e?.reasonOfPayment,
        e?.eventTicks,
        e?.meetingTickets
      ]);

  @override
  bool isValidKey(Object? o) => o is PaymentsRecord;
}
