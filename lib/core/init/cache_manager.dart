// ignore_for_file: one_member_abstracts

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheManager {
  void initManager({required String fileName, required Directory dir});
}

class CacheCurrencyService extends CacheManager {
  File? _file;

  File? get file => _file;

  @override
  void initManager({required String fileName, required Directory dir}) {
    _file = File('${dir.path}/$fileName.json');
  }

  String? readFile() {
    return _file?.readAsStringSync();
  }

  Future<void> removeFile() async {
    await _file?.delete();
  }

  void writeFile({required String body}) {
    _file?.writeAsStringSync(body, flush: true);
  }

  Future<void> cacheClear(DateTime cacheTime, String basePostfix) async {
    final cacheKey = 'cache_$basePostfix';
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(cacheKey)) {
      await preferences.setString(cacheKey, cacheTime.toString());
    } else if ((DateTime.now().hour - cacheTime.hour.abs()) > 4) {
      await Future.wait([removeFile(), preferences.remove(cacheKey)]);
    }
  }
}
