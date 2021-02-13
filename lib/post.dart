import 'dart:io';

import 'package:dagwood/content_writeable.dart';
import 'package:yaml/yaml.dart';

enum PostFormat { Markdown }

class Post implements ContentsWriteable {
  @override
  File file;
  @override
  String contents;
  PostFormat format = PostFormat.Markdown;
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
