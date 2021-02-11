import 'dart:io';

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

  Directory('pages').listSync().forEach((element) {
    var newPath = element.path.replaceFirst('pages', '');
    File(element.path).copy('build/${newPath}');
  });
}
