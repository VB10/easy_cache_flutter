import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'base_model.dart';

abstract class ICacheManager {
  late SharedPreferences prefs;
  Future<bool> addCacheItem<T>(String id, T model);
  Future<T> getCacheItem<T extends IBaseModel>(String id, IBaseModel model);
}

class CacheManager implements ICacheManager {
  static CacheManager? _instace;
  static CacheManager get instance {
    if (_instace != null) return _instace!;
    _instace = CacheManager._init();
    return _instace!;
  }

  late SharedPreferences prefs;
  CacheManager._init() {
    initPrefences();
  }

  Future<void> initPrefences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  String _key<T>(String id) {
    return '${T.toString()}-$id';
  }

  Future<bool> addCacheItem<T>(String id, T model) async {
    final _stingModel = jsonEncode(model);
    return await prefs.setString(_key<T>(id), _stingModel);
  }

  Future<bool> removeCacheItem<T>(String id) async {
    return await prefs.remove(_key<T>(id));
  }

  Future<T> getCacheItem<T extends IBaseModel>(String id, IBaseModel model) async {
    final cacheData = prefs.getString(_key<T>(id)) ?? '';
    final normalModelJson = jsonDecode(cacheData);
    return model.fromJson(normalModelJson);
  }

  List<T> getCacheList<T extends IBaseModel>(IBaseModel model) {
    final cacheDataList = prefs.getKeys().where((element) => element.contains('$T-')).toList();

    if (cacheDataList.isNotEmpty) {
      return cacheDataList.map((e) => model.fromJson(jsonDecode(prefs.getString(e) ?? '')) as T).toList();
    }
    return [];
  }

  Future<bool> removeAllItem<T>(String id) async {
    return await prefs.remove('${T.runtimeType}-$id');
  }

  Future<bool> removeAllCache<T>() async {
    final cacheDataList = prefs.getKeys().where((element) => element.contains('$T-')).toList();

    for (var i = 0; i < cacheDataList.length; i++) {
      await prefs.remove(cacheDataList[i]);
    }

    return true;
  }
}
