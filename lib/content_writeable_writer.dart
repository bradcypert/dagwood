import 'dart:io';

import 'package:dagwood/content_writeable.dart';

class ContentWriteableWriter {
  static void write(ContentsWriteable contentsWriteable,
      {String outputFilename}) {
    ensureDirectoryExists('build');

    var outputPath = outputFilename ?? contentsWriteable.file.path;
    var relativePath = outputPath.replaceAll('./', '/');
    var pathSegments = relativePath.split('/');
    var directoryPath =
        pathSegments.where((element) => !element.contains(RegExp(r'[^.]+$')));

    var curPathPart = '';
    directoryPath.forEach((element) {
      curPathPart += element;
      ensureDirectoryExists(curPathPart.replaceAll('.', ''));
    });

    var fileName = pathSegments.last;

    curPathPart =
        curPathPart.split('/').where((element) => element != 'posts').join('/');
    var file = File('./build/$curPathPart/$fileName');
    file.createSync();

    file.writeAsString(contentsWriteable.contents);
  }
}

void ensureDirectoryExists(String path) {
  var buildDir = Directory('./$path');
  if (!buildDir.existsSync()) {
    buildDir.createSync();
  }
}
