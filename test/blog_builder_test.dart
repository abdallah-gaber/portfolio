import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import '../scripts/build_blog.dart';

String article({
  String title = 'A useful lesson',
  String date = '2026-09-23',
  bool draft = false,
}) =>
    '''---
title: '$title'
date: '$date'
description: 'A summary with <angle brackets> & quotes.'
tags: ['Flutter', 'Engineering']
draft: $draft
---

## The problem

A paragraph with a [link](https://example.com).

```dart
if (count < 2) print('hello');
```

![Data flow](/blog/images/lesson/diagram.svg)
''';

void main() {
  late Directory root;
  late Directory output;
  setUp(() {
    root = Directory.systemTemp.createTempSync('portfolio-blog-test-');
    output = Directory('${root.path}/build/web');
    for (final folder in ['content/posts', 'content/images', 'blog', 'web']) {
      Directory('${root.path}/$folder').createSync(recursive: true);
    }
    for (final path in [
      'blog/layout.html',
      'blog/empty.html',
      'web/sitemap.xml',
      'web/favicon.ico',
      'web/og_image.jpg',
    ]) {
      File(path).copySync('${root.path}/$path');
    }
    Directory('${root.path}/blog/assets').createSync();
    File('blog/assets/blog.css').copySync('${root.path}/blog/assets/blog.css');
  });
  tearDown(() => root.deleteSync(recursive: true));
  void add(String slug, String content) =>
      File('${root.path}/content/posts/$slug.md').writeAsStringSync(content);
  String read(String path) => File('${output.path}/$path').readAsStringSync();
  void build({bool preview = false}) =>
      buildBlog(root: root, output: output, preview: preview);

  test(
    'empty production has the illustration and preserves portfolio sitemap',
    () {
      build();
      expect(read('blog/index.html'), contains('The first page'));
      expect(read('blog/index.html'), contains('/blog/assets/notebook.svg'));
      expect(
        read('sitemap.xml'),
        contains('<loc>https://abdallahgaber.dev/</loc>'),
      );
      expect(
        read('sitemap.xml'),
        contains('<loc>https://abdallahgaber.dev/blog/</loc>'),
      );
      expect(read('404.html'), contains('noindex, nofollow'));
    },
  );

  test(
    'renders articles, escapes metadata, sorts cards, and copies images',
    () {
      add('older', article(date: '2026-08-01'));
      add('newer', article(title: 'Flutter & <friends>'));
      final image = File('${root.path}/content/images/lesson/diagram.svg');
      image.parent.createSync(recursive: true);
      image.writeAsStringSync('<svg/>');
      build();
      final page = read('blog/newer/index.html');
      expect(page, contains('Flutter &amp; &lt;friends&gt;'));
      expect(page, contains('<h2 id="the-problem">The problem</h2>'));
      expect(page, contains('class="language-dart"'));
      expect(page, contains('count &lt; 2'));
      expect(page, contains('application/ld+json'));
      expect(page, contains('https://abdallahgaber.dev/blog/newer/'));
      expect(page, isNot(contains('noindex')));
      expect(read('blog/images/lesson/diagram.svg'), '<svg/>');
      final listing = read('blog/index.html');
      expect(
        listing.indexOf('/blog/newer/'),
        lessThan(listing.indexOf('/blog/older/')),
      );
    },
  );

  test('draft preview is noindex and production removes stale draft HTML', () {
    add('private-draft', article(title: 'Unpublished idea', draft: true));
    build(preview: true);
    expect(read('blog/private-draft/index.html'), contains('Draft preview'));
    expect(
      read('blog/private-draft/index.html'),
      contains('noindex, nofollow'),
    );
    expect(read('sitemap.xml'), isNot(contains('private-draft')));
    build();
    expect(
      File('${output.path}/blog/private-draft/index.html').existsSync(),
      isFalse,
    );
    expect(read('blog/index.html'), isNot(contains('Unpublished idea')));
    expect(read('blog/index.html'), contains('The first page'));
  });

  test('deleted articles disappear on rebuild', () {
    add('removed', article());
    build();
    File('${root.path}/content/posts/removed.md').deleteSync();
    build();
    expect(
      File('${output.path}/blog/removed/index.html').existsSync(),
      isFalse,
    );
    expect(read('sitemap.xml'), isNot(contains('/removed/')));
  });

  test('invalid metadata fails before altering the existing output', () {
    build();
    final before = read('blog/index.html');
    add('broken', article(date: '2026-02-30'));
    expect(build, throwsFormatException);
    expect(read('blog/index.html'), before);
    expect(() => Post.parse('assets', article()), throwsFormatException);
    expect(
      () => Post.parse('missing', article().replaceFirst('draft: false', '')),
      throwsFormatException,
    );
    expect(
      () => Post.parse(
        'bad-tags',
        article().replaceFirst(
          "tags: ['Flutter', 'Engineering']",
          'tags: [123]',
        ),
      ),
      throwsFormatException,
    );
  });
}
