import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/my_flutter/my_flutter_util.dart';

class ReelsRecord extends FirestoreRecord {
  ReelsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "postedBy" field.
  DocumentReference? _postedBy;
  DocumentReference? get postedBy => _postedBy;
  bool hasPostedBy() => _postedBy != null;

  // "postDateTime" field.
  DateTime? _postDateTime;
  DateTime? get postDateTime => _postDateTime;
  bool hasPostDateTime() => _postDateTime != null;

  // "reelDescription" field.
  String? _reelDescription;
  String get reelDescription => _reelDescription ?? '';
  bool hasReelDescription() => _reelDescription != null;

  // "reelMediaPath" field.
  String? _reelMediaPath;
  String get reelMediaPath => _reelMediaPath ?? '';
  bool hasReelMediaPath() => _reelMediaPath != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "views" field.
  List<DocumentReference>? _views;
  List<DocumentReference> get views => _views ?? const [];
  bool hasViews() => _views != null;

  // "likes" field.
  List<DocumentReference>? _likes;
  List<DocumentReference> get likes => _likes ?? const [];
  bool hasLikes() => _likes != null;

  // "shares" field.
  List<DocumentReference>? _shares;
  List<DocumentReference> get shares => _shares ?? const [];
  bool hasShares() => _shares != null;

  void _initializeFields() {
    _postedBy = snapshotData['postedBy'] as DocumentReference?;
    _postDateTime = snapshotData['postDateTime'] as DateTime?;
    _reelDescription = snapshotData['reelDescription'] as String?;
    _reelMediaPath = snapshotData['reelMediaPath'] as String?;
    _title = snapshotData['title'] as String?;
    _views = getDataList(snapshotData['views']);
    _likes = getDataList(snapshotData['likes']);
    _shares = getDataList(snapshotData['shares']);
  }

  static CollectionReference get collection => FirebaseFirestore.instanceFor(
          app: Firebase.app(), databaseId: 'talenties-5f525')
      .collection('reels');

  static Stream<ReelsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReelsRecord.fromSnapshot(s));

  static Future<ReelsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReelsRecord.fromSnapshot(s));

  static ReelsRecord fromSnapshot(DocumentSnapshot snapshot) => ReelsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReelsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReelsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReelsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReelsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReelsRecordData({
  DocumentReference? postedBy,
  DateTime? postDateTime,
  String? reelDescription,
  String? reelMediaPath,
  String? title,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'postedBy': postedBy,
      'postDateTime': postDateTime,
      'reelDescription': reelDescription,
      'reelMediaPath': reelMediaPath,
      'title': title,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReelsRecordDocumentEquality implements Equality<ReelsRecord> {
  const ReelsRecordDocumentEquality();

  @override
  bool equals(ReelsRecord? e1, ReelsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postedBy == e2?.postedBy &&
        e1?.postDateTime == e2?.postDateTime &&
        e1?.reelDescription == e2?.reelDescription &&
        e1?.reelMediaPath == e2?.reelMediaPath &&
        e1?.title == e2?.title &&
        listEquality.equals(e1?.views, e2?.views) &&
        listEquality.equals(e1?.likes, e2?.likes) &&
        listEquality.equals(e1?.shares, e2?.shares);
  }

  @override
  int hash(ReelsRecord? e) => const ListEquality().hash([
        e?.postedBy,
        e?.postDateTime,
        e?.reelDescription,
        e?.reelMediaPath,
        e?.title,
        e?.views,
        e?.likes,
        e?.shares
      ]);

  @override
  bool isValidKey(Object? o) => o is ReelsRecord;
}
