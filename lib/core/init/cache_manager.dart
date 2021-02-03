import 'dart:io';

import 'package:meta/meta.dart';

abstract class CacheManager {
  @required
  void initManager(
      {@required String fileName,
      @required String fileExtension,
      @required Directory dir});
}

class CacheCurrencyService extends CacheManager {
  String _fileName;
  String _fileExtension;
  File _file;

  File get file => _file;

  @override
  void initManager({String fileName, String fileExtension, Directory dir}) {
    _fileExtension = fileExtension;
    _fileName = fileName + _fileExtension;

    _file = File(dir.path + "/" + _fileName);
  }

  String readFile() {
    return _file.readAsStringSync();
  }

  void writeFile({@required String body}) {
    _file.writeAsStringSync(body, flush: true, mode: FileMode.write);
  }
}
