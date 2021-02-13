import 'dart:io';

import 'package:dagwood/content_writeable.dart';

enum AssetType { Style, Other }

const AssetMap = {
  'css': AssetType.Style,
  'scss': AssetType.Style,
  'sass': AssetType.Style
};

enum AssetStatus { None, Processed, Written }

class Asset implements ContentsWriteable {
  @override
  File file;

  @override
  String contents;

  AssetType assetType;
  AssetStatus status;

  Asset({this.file}) {
    var ext = file.path.split('.').last;
    assetType = AssetMap[ext] ?? AssetType.Other;
    status = AssetStatus.None;
  }
}
