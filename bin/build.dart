import 'dart:io';

import 'package:dagwood/asset.dart';
import 'package:dagwood/asset_pipeline.dart';
import 'package:dagwood/postbuilder.dart';

void build(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Help coming soon.');
    return;
  }

  Postbuilder(template: File('./post-template.html'))
    ..findFiles()
    ..parsePosts()
    ..writeParsedPostsToFile();

  var assets = Directory('./assets')
      .listSync(recursive: true)
      .map((e) => File(e.path))
      .toList();

  assets
      .map((asset) => Asset(file: asset))
      .map((asset) => AssetPipeline.processAsset(asset))
      .forEach((asset) => AssetPipeline.writeAsset(asset));

  Directory('pages').listSync().forEach((element) {
    var newPath = element.path.replaceFirst('pages', '');
    File(element.path).copy('build/${newPath}');
  });
}
