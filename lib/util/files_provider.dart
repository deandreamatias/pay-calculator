import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FilesProvider {
  
  writeFile(String string, bool append) async {
    final file = await _localFile;
    file.writeAsStringSync('$string', mode: append ? FileMode.writeOnlyAppend : FileMode.writeOnly);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/report.txt');
  }
}
