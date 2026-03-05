import 'dart:convert';

import 'package:hive_ce/hive.dart';

import '../../core/constants/app_constants.dart';

class ProductLocalDatasource {
  static const _productsBox = 'products_cache';
  static const _timestampKey = '_timestamps';

  Future<Box> get _box async => Hive.openBox(_productsBox);

  Future<void> cacheData(String key, dynamic data) async {
    final box = await _box;
    await box.put(key, jsonEncode(data));
    // Store timestamp
    final timestamps = Map<String, dynamic>.from(
      jsonDecode(box.get(_timestampKey, defaultValue: '{}') as String),
    );
    timestamps[key] = DateTime.now().millisecondsSinceEpoch;
    await box.put(_timestampKey, jsonEncode(timestamps));
  }

  Future<dynamic> getCachedData(String key) async {
    final box = await _box;
    if (!_isCacheValid(box, key)) return null;
    final raw = box.get(key) as String?;
    if (raw == null) return null;
    return jsonDecode(raw);
  }

  bool _isCacheValid(Box box, String key) {
    final raw = box.get(_timestampKey, defaultValue: '{}') as String;
    final timestamps = Map<String, dynamic>.from(jsonDecode(raw));
    final ts = timestamps[key] as int?;
    if (ts == null) return false;
    final age = DateTime.now().millisecondsSinceEpoch - ts;
    return age < AppConstants.cacheDuration.inMilliseconds;
  }

  Future<void> clearCache() async {
    final box = await _box;
    await box.clear();
  }
}
