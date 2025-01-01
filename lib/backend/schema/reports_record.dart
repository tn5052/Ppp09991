import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class ReportsRecord extends FirestoreRecord {
  ReportsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "reportID" field.
  String? _reportID;
  String get reportID => _reportID ?? '';
  bool hasReportID() => _reportID != null;

  // "reported_by" field.
  DocumentReference? _reportedBy;
  DocumentReference? get reportedBy => _reportedBy;
  bool hasReportedBy() => _reportedBy != null;

  // "type_reported" field.
  String? _typeReported;
  String get typeReported => _typeReported ?? '';
  bool hasTypeReported() => _typeReported != null;

  // "event_reported" field.
  DocumentReference? _eventReported;
  DocumentReference? get eventReported => _eventReported;
  bool hasEventReported() => _eventReported != null;

  // "user_reported" field.
  DocumentReference? _userReported;
  DocumentReference? get userReported => _userReported;
  bool hasUserReported() => _userReported != null;

  // "dateTime" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  bool hasReason() => _reason != null;

  // "status_report" field.
  String? _statusReport;
  String get statusReport => _statusReport ?? '';
  bool hasStatusReport() => _statusReport != null;

  void _initializeFields() {
    _reportID = snapshotData['reportID'] as String?;
    _reportedBy = snapshotData['reported_by'] as DocumentReference?;
    _typeReported = snapshotData['type_reported'] as String?;
    _eventReported = snapshotData['event_reported'] as DocumentReference?;
    _userReported = snapshotData['user_reported'] as DocumentReference?;
    _dateTime = snapshotData['dateTime'] as DateTime?;
    _reason = snapshotData['reason'] as String?;
    _statusReport = snapshotData['status_report'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('reports');

  static Stream<ReportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReportsRecord.fromSnapshot(s));

  static Future<ReportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReportsRecord.fromSnapshot(s));

  static ReportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReportsRecordData({
  String? reportID,
  DocumentReference? reportedBy,
  String? typeReported,
  DocumentReference? eventReported,
  DocumentReference? userReported,
  DateTime? dateTime,
  String? reason,
  String? statusReport,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'reportID': reportID,
      'reported_by': reportedBy,
      'type_reported': typeReported,
      'event_reported': eventReported,
      'user_reported': userReported,
      'dateTime': dateTime,
      'reason': reason,
      'status_report': statusReport,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReportsRecordDocumentEquality implements Equality<ReportsRecord> {
  const ReportsRecordDocumentEquality();

  @override
  bool equals(ReportsRecord? e1, ReportsRecord? e2) {
    return e1?.reportID == e2?.reportID &&
        e1?.reportedBy == e2?.reportedBy &&
        e1?.typeReported == e2?.typeReported &&
        e1?.eventReported == e2?.eventReported &&
        e1?.userReported == e2?.userReported &&
        e1?.dateTime == e2?.dateTime &&
        e1?.reason == e2?.reason &&
        e1?.statusReport == e2?.statusReport;
  }

  @override
  int hash(ReportsRecord? e) => const ListEquality().hash([
        e?.reportID,
        e?.reportedBy,
        e?.typeReported,
        e?.eventReported,
        e?.userReported,
        e?.dateTime,
        e?.reason,
        e?.statusReport
      ]);

  @override
  bool isValidKey(Object? o) => o is ReportsRecord;
}
