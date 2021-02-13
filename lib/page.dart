import 'dart:io';

import 'package:dagwood/content_writeable.dart';

class Page implements ContentsWriteable {
  @override
  File file;
  @override
  String contents;
}
