import 'dart:io';

import 'package:yaml/yaml.dart';

enum PostFormat { Markdown }

class Post {
  File file;
  PostFormat format = PostFormat.Markdown;
  String contents;
  YamlMap meta;

  Post({this.file, this.format = PostFormat.Markdown});

  void parseFile() {
    var contents = file.readAsStringSync();
    var dividedFile = contents.split('---');
    var metadata = ['---', dividedFile[0], dividedFile[1]].join('\n');
    meta = loadYaml(metadata);
    this.contents = dividedFile.last;
  }
}
