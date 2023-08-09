import 'dart:io';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheManager {
  @required
  void initManager({required String fileName, required String fileExtension, required Directory dir});
}

class CacheCurrencyService extends CacheManager {
  String _fileName = '';
  String _fileExtension = '';
  File? _file;

  File? get file => _file;

  @override
  void initManager({required String fileName, required String fileExtension, required Directory dir}) {
    _fileExtension = fileExtension;
    _fileName = fileName + _fileExtension;

    _file = File(dir.path + '/' + _fileName);
  }

  String? readFile() {
    return _file?.readAsStringSync();
  }

  void removeFile() async {
    await _file?.delete();
  }

  void writeFile({required String body}) {
    _file?.writeAsStringSync(body, flush: true, mode: FileMode.write);
  }

  void cacheClear(DateTime cacheTime, String basePostfix) async {
    final cacheKey = 'cache_$basePostfix';
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(cacheKey)) {
      await preferences.setString(cacheKey, cacheTime.toString());
    } else if ((DateTime.now().hour.toInt() - cacheTime.hour.toInt().abs()) > 4) {
      removeFile();
      await preferences.remove(cacheKey);
    } else {
      return;
    }
  }
}
