import 'dart:io';

import 'package:dagwood/markdown/markdown_parser.dart';
import 'package:dagwood/post.dart';

class Postbuilder {
  File template;
  List<File> posts;
  List<Post> parsed;

  Postbuilder({this.template, this.posts});

  /// traverse the filesystem to find all posts.
  void findFiles() {
    posts = Directory('./posts')
        .listSync(recursive: true)
        .where((element) => element.path.endsWith('.md'))
        .map((e) => File(e.path))
        .toList();
  }

  void parsePosts() {
    parsed = posts.map((file) => Post(file: file)..parseFile()).toList();
  }

  void writeParsedPostsToFile() {
    ensureDirectoryExists('build');
    var templateString = template.readAsStringSync();
    parsed.forEach((post) {
      var relativePath = post.file.path.replaceAll('./', '/');
      var splitRelative = relativePath.split('/');
      var directoryPath =
          splitRelative.where((element) => !element.endsWith('.md'));
      var curPathPart = '';
      directoryPath.forEach((element) {
        curPathPart += element;
        ensureDirectoryExists(curPathPart.replaceAll('.', ''));
      });

      var fileName = splitRelative.last.replaceAll('.md', '.html');
      // remove /post from the url / build structure
      // TODO: @gross could not get replaceAll working for some reason
      curPathPart = curPathPart
          .split('/')
          .where((element) => element != 'posts')
          .join('/');
      var file = File('./build/$curPathPart/$fileName');
      file.createSync();

      var metaHtml = post.meta.keys
          .map((key) {
            switch (key) {
              case 'title':
                return '<title>${post.meta[key]}</title>';
                break;
              case 'description':
                return '<meta name="description" content="${post.meta[key]}" />';
                break;
              case 'author':
                return '';
                break;
              case 'date':
                return '';
                break;
            }
          })
          .where((element) => element != '')
          .join('\n');

      var injected = templateString
          .replaceAll(
              '{{dagwood:content}}', MarkdownParser.parseString(post.contents))
          .replaceAll('{{dagwood:meta}}', metaHtml);
      file.writeAsString(injected);
    });
  }
}

void ensureDirectoryExists(String path) {
  var buildDir = Directory('./$path');
  if (!buildDir.existsSync()) {
    buildDir.createSync();
  }
}
