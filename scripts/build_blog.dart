import 'dart:convert';
import 'dart:io';

import 'package:markdown/markdown.dart' as md;
import 'package:yaml/yaml.dart';

const siteUrl = 'https://abdallahgaber.dev';
const author = 'Abdallah Gaber';
const description =
    'Articles on Flutter, engineering, and lessons from building software.';
const _escape = HtmlEscape();
String escape(String value) => _escape.convert(value);

class Post {
  final String slug, title, description, body;
  final DateTime date;
  final List<String> tags;
  final bool draft;
  final String? ogImage;

  Post(
    this.slug,
    this.title,
    this.description,
    this.date,
    this.tags,
    this.draft,
    this.body, {
    this.ogImage,
  });

  String get path => '/blog/$slug/';
  String get socialImageUrl => '$siteUrl${ogImage ?? '/og_image.jpg'}';
  String get isoDate => date.toIso8601String().substring(0, 10);
  String get displayDate {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static Post parse(String slug, String source) {
    Never invalid(String message) =>
        throw FormatException('$slug.md: $message');
    if (!RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(slug) ||
        {'index', 'assets', 'images', '404'}.contains(slug)) {
      invalid(
        'Use a unique lowercase, hyphenated filename (not a reserved name).',
      );
    }
    final match = RegExp(
      r'^---\n([\s\S]*?)\n---\n([\s\S]*)$',
    ).firstMatch(source.replaceAll('\r\n', '\n'));
    if (match == null) invalid('Expected YAML metadata between --- lines.');
    final data = loadYaml(match.group(1)!);
    if (data is! YamlMap) invalid('Metadata must be a YAML mapping.');
    String field(String key) {
      final value = data[key];
      if (value is! String || value.trim().isEmpty) {
        invalid('$key must be a non-empty string.');
      }
      return value.trim();
    }

    final title = field('title');
    final summary = field('description');
    final dateText = field('date');
    final date = DateTime.tryParse(dateText);
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateText) ||
        date == null ||
        date.toIso8601String().substring(0, 10) != dateText) {
      invalid('date must be a valid YYYY-MM-DD date.');
    }
    final draft = data['draft'];
    if (draft is! bool) invalid('draft must be explicitly true or false.');
    final tags = data['tags'];
    if (tags is! YamlList ||
        tags.any((tag) => tag is! String || tag.trim().isEmpty)) {
      invalid('tags must be a list of non-empty strings (or []).');
    }
    final body = match.group(2)!.trim();
    if (body.isEmpty) invalid('The article body is empty.');
    String? ogImage;
    if (data.containsKey('ogImage')) {
      ogImage = field('ogImage');
      if (!RegExp(
        r'^/blog/images/(?:[A-Za-z0-9_-]+/)*[A-Za-z0-9_-]+\.(?:png|jpg|jpeg|webp|gif)$',
      ).hasMatch(ogImage)) {
        invalid(
          'ogImage must be a /blog/images/ path to a PNG, JPEG, WebP, or GIF.',
        );
      }
    }
    return Post(
      slug,
      title,
      summary,
      date,
      tags.cast<String>().map((tag) => tag.trim()).toSet().toList(),
      draft,
      body,
      ogImage: ogImage,
    );
  }
}

String tagsHtml(Post post) =>
    post.tags.map((tag) => '<span class="tag">${escape(tag)}</span>').join();

String renderPage(
  String template, {
  required String title,
  required String summary,
  required String path,
  required String content,
  bool article = false,
  bool noindex = false,
  String extraHead = '',
  String socialImageUrl = '$siteUrl/og_image.jpg',
  String socialImageAlt = 'Abdallah Gaber — mobile engineer and team lead',
}) {
  final values = {
    'TITLE': escape(title),
    'DESCRIPTION': escape(summary),
    'URL': '$siteUrl$path',
    'TYPE': article ? 'article' : 'website',
    'IMAGE': const HtmlEscape(HtmlEscapeMode.attribute).convert(socialImageUrl),
    'IMAGE_ALT': escape(socialImageAlt),
    'HEAD':
        '${noindex ? '<meta name="robots" content="noindex, nofollow">' : ''}$extraHead',
    'CONTENT': content,
    'YEAR': '${DateTime.now().year}',
  };
  // Replace template tokens once; article text is never treated as a template.
  return template.replaceAllMapped(
    RegExp(r'\{\{([A-Z_]+)\}\}'),
    (match) => values[match.group(1)] ?? match.group(0)!,
  );
}

void buildBlog({
  required Directory root,
  required Directory output,
  bool preview = false,
}) {
  final source = Directory('${root.path}/content/posts');
  final posts =
      source
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.md'))
          .map(
            (file) => Post.parse(
              file.uri.pathSegments.last.replaceFirst(RegExp(r'\.md$'), ''),
              file.readAsStringSync(),
            ),
          )
          .where((post) => preview || !post.draft)
          .toList()
        ..sort((a, b) {
          final dateOrder = b.date.compareTo(a.date);
          return dateOrder == 0 ? a.slug.compareTo(b.slug) : dateOrder;
        });
  final template = File('${root.path}/blog/layout.html').readAsStringSync();
  for (final post in posts) {
    final image = post.ogImage;
    if (image != null &&
        !File(
          '${root.path}/content/images/${image.substring('/blog/images/'.length)}',
        ).existsSync()) {
      throw FormatException(
        '${post.slug}.md: ogImage file does not exist: $image',
      );
    }
  }
  final empty = File('${root.path}/blog/empty.html').readAsStringSync();
  // Validate all content before replacing generated files. Only this owned
  // output directory is removed, so deleted posts and drafts cannot linger.
  final blog = Directory('${output.path}/blog');
  if (blog.existsSync()) blog.deleteSync(recursive: true);
  blog.createSync(recursive: true);
  void write(String path, String value) {
    final file = File('${output.path}/$path');
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(value);
  }

  void copyTree(Directory from, String destination) {
    for (final entity in from.listSync(recursive: true).whereType<File>()) {
      if (entity.uri.pathSegments.last.startsWith('.')) continue;
      final relative = entity.path.substring(from.path.length + 1);
      final target = File('${output.path}/$destination/$relative');
      target.parent.createSync(recursive: true);
      entity.copySync(target.path);
    }
  }

  copyTree(Directory('${root.path}/blog/assets'), 'blog/assets');
  copyTree(Directory('${root.path}/content/images'), 'blog/images');
  final cards = posts
      .map(
        (post) =>
            '''
    <article class="post-card">
      <div class="post-meta"><time datetime="${post.isoDate}">${post.displayDate}</time>${post.draft ? '<span class="draft-label">Draft preview</span>' : ''}</div>
      <h2><a href="${post.path}">${escape(post.title)}</a></h2>
      <p>${escape(post.description)}</p>
      <div class="card-bottom"><div class="tags">${tagsHtml(post)}</div><span aria-hidden="true">↗</span></div>
    </article>''',
      )
      .join('\n');
  write(
    'blog/index.html',
    renderPage(
      template,
      title: 'Blog · $author',
      summary: description,
      path: '/blog/',
      noindex: preview,
      content:
          '''
        <section class="intro" aria-labelledby="page-title">
          <p class="eyebrow"><span></span> NOTES FROM THE WORKBENCH</p>
          <h1 id="page-title">A few things<br><span class="gradient-text">worth sharing.</span></h1>
          <p class="intro-copy">$description</p>
        </section>
        ${preview ? '<p class="preview-banner">Local preview · includes drafts · excluded from search indexing</p>' : ''}
        ${posts.isEmpty ? empty : '<section class="post-list" aria-label="Articles">$cards</section>'}
      ''',
    ),
  );
  for (final post in posts) {
    final html = md.markdownToHtml(
      post.body,
      extensionSet: md.ExtensionSet.gitHubWeb,
    );
    final structuredData = jsonEncode({
      '@context': 'https://schema.org',
      '@type': 'BlogPosting',
      'headline': post.title,
      'description': post.description,
      'datePublished': post.isoDate,
      'author': {'@type': 'Person', 'name': author, 'url': siteUrl},
      'mainEntityOfPage': '$siteUrl${post.path}',
      'image': post.socialImageUrl,
    }).replaceAll('<', r'\u003c');
    write(
      'blog/${post.slug}/index.html',
      renderPage(
        template,
        title: '${post.title} · $author',
        summary: post.description,
        path: post.path,
        article: true,
        socialImageUrl: post.socialImageUrl,
        socialImageAlt: post.ogImage == null
            ? 'Abdallah Gaber — mobile engineer and team lead'
            : post.title,
        noindex: preview || post.draft,
        extraHead:
            '''<meta property="article:published_time" content="${post.isoDate}">
          <script type="application/ld+json">$structuredData</script>''',
        content:
            '''
          <article class="article">
            <a class="back-link" href="/blog/">← All articles</a>
            ${post.draft ? '<p class="preview-banner">Draft preview · unpublished</p>' : ''}
            <header class="article-header">
              <div class="post-meta"><time datetime="${post.isoDate}">${post.displayDate}</time><span>$author</span></div>
              <h1>${escape(post.title)}</h1>
              <p class="article-summary">${escape(post.description)}</p>
              <div class="tags">${tagsHtml(post)}</div>
            </header>
            <div class="prose">$html</div>
            <footer class="article-footer"><p>Thanks for reading.</p><a href="/blog/">← Back to all articles</a></footer>
          </article>''',
      ),
    );
  }
  write(
    '404.html',
    renderPage(
      template,
      title: 'Page not found · $author',
      summary: 'This page could not be found.',
      path: '/404.html',
      noindex: true,
      content:
          '''<section class="intro"><p class="eyebrow">404 / PAGE NOT FOUND</p>
        <h1>A missing page.<br><span class="gradient-text">A way back.</span></h1>
        <p class="intro-copy">This link may have moved, or the article isn't published yet.</p>
        <a class="button" href="/blog/">Explore the blog <span aria-hidden="true">↗</span></a></section>''',
    ),
  );
  final baseSitemap = File('${root.path}/web/sitemap.xml').readAsStringSync();
  final urls = [
    '/blog/',
    ...posts.where((post) => !post.draft).map((post) => post.path),
  ].map((path) => '  <url><loc>$siteUrl$path</loc></url>').join('\n');
  write(
    'sitemap.xml',
    baseSitemap.replaceFirst('</urlset>', '$urls\n</urlset>'),
  );
  if (preview) {
    write('robots.txt', 'User-agent: *\nDisallow: /\n');
    for (final asset in ['favicon.ico', 'og_image.jpg']) {
      File('${root.path}/web/$asset').copySync('${output.path}/$asset');
    }
  }
  stdout.writeln(
    'Built ${posts.length} ${preview ? 'preview' : 'published'} posts → ${blog.path}',
  );
}

void main(List<String> args) {
  if (args.any((arg) => arg != '--preview')) {
    stderr.writeln('Usage: dart run scripts/build_blog.dart [--preview]');
    exitCode = 64;
    return;
  }
  final preview = args.contains('--preview');
  try {
    buildBlog(
      root: Directory.current,
      output: Directory(preview ? 'build/blog-preview' : 'build/web'),
      preview: preview,
    );
  } catch (error) {
    stderr.writeln('Blog build failed: $error');
    exitCode = 1;
  }
}
