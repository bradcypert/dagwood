import 'dart:io';

import 'package:dagwood/dagwood.dart' as dagwood;

var configTemplate = '''---
site:
  title: My New Dagwood Site!
  description: A Dagwood is a tall multilayered sandwich.
  author: Your name here!
  siteUrl: https://www.my-awesome-site.com
  organization:
    url: https://www.my-awesome-site.com
    name: Dag Wooderson
    logo: ./some/path/to/a/logo
''';

var pageTemplate = '''<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello Bulma!</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
  </head>
  <body>
  <section class="section">
    <div class="container">
      <h1 class="title">
        Hello World
      </h1>
      <p class="subtitle">
        My first website with <strong>Bulma</strong>!
      </p>
      <p>
        Learn about <a href="./my-favorite-sandwich.html">my favorite sandwich</a>
      </p>
    </div>
  </section>
  </body>
</html>
''';

var postHtml = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    {{dagwood:meta}}
  </head>
  <body>
  <section class="section">
    <div class="container">
      {{dagwood:content}}
    </div>
  </section>
  </body>
</html>
''';

var postTemplate = '''---
title: My Favorite Sandwich
description: A Dagwood is a tall multilayered sandwich.
author: Your name here!
date: 02/30/2020
---

# The Dagwood is My Favorite Sandwich
Oh, how I do love the dagwood. Few things please me as much as its multilayered goodness.
''';

///
/// dagwood create new_site
void create(List<String> arguments) {
  if (arguments.length < 2) {
    print('Help coming soon.');
  }

  var name = arguments[1];

  var directory = Directory('./$name');
  directory.createSync();

  var config = File('./$name/config.yml');
  config.writeAsStringSync(configTemplate);

  var pagesDir = Directory('./$name/pages');
  var postsDir = Directory('./$name/posts');
  pagesDir.createSync();
  postsDir.createSync();

  // write initial posts
  File('./$name/posts/my-favorite-sandwich.md').writeAsStringSync(postTemplate);
  File('./$name/pages/index.html').writeAsStringSync(pageTemplate);
  File('./$name/post-template.html').writeAsStringSync(postHtml);
}
