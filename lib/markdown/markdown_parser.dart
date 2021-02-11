import 'package:markdown/markdown.dart';

class MarkdownParser {
  static String parseString(String markdown) {
    return markdownToHtml(markdown);
  }
}
