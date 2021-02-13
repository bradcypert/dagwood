import 'dart:io';

import 'package:dagwood/content_writeable_writer.dart';
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
    var templateString = template.readAsStringSync();
    parsed.forEach((post) {
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
      post.contents = injected;

      ContentWriteableWriter.write(post,
          outputFilename: post.file.path.replaceAll(RegExp(r'[^.]+$'), 'html'));
    });
  }
}
