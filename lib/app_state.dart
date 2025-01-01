import 'package:flutter/material.dart';
import 'my_flutter/request_manager.dart';
import '/backend/backend.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  final _mentorsListCacheManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> mentorsListCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _mentorsListCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMentorsListCacheCache() => _mentorsListCacheManager.clear();
  void clearMentorsListCacheCacheKey(String? uniqueKey) =>
      _mentorsListCacheManager.clearRequest(uniqueKey);

  final _feedCacheManager = StreamRequestManager<List<ReelsRecord>>();
  Stream<List<ReelsRecord>> feedCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ReelsRecord>> Function() requestFn,
  }) =>
      _feedCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFeedCacheCache() => _feedCacheManager.clear();
  void clearFeedCacheCacheKey(String? uniqueKey) =>
      _feedCacheManager.clearRequest(uniqueKey);
}
