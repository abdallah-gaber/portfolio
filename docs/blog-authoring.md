# Writing a blog post

The Flutter portfolio and static HTML blog share one repository, domain, and
deployment. Dart generates the blog from Markdown during the Vercel build.
No database, admin account, or Node toolchain is needed.

## Your first post

1. Create a content branch from the latest `main` after the foundation PR merges.
2. Copy `docs/post-template.md` to `content/posts/your-post-slug.md`.
3. Update the title, publication date, description, and tags. Keep `draft: true`
   while writing. The filename determines the permanent URL:
   `/blog/your-post-slug/`. Avoid renaming published files unless you add a redirect.
4. Write the body using Markdown. The title comes from metadata; use `##` for
   sections. Fenced code blocks, lists, links, quotes, and tables are supported.
5. Preview locally using the commands below.
6. When ready, set `draft: false`, run the production build, and open a PR.
7. Review the Vercel preview before merging. After deployment, open the article's
   live URL and check its images, links, and mobile layout.

Every later post follows the same steps. Editing an existing Markdown file also
requires a build and deployment; changes do not appear on the live site immediately.

## Metadata

All five fields are required. Dates must be real calendar dates in `YYYY-MM-DD`
format. `tags` can be an empty list (`[]`). `draft` must be a YAML boolean.

```yaml
---
title: "A lesson from a Flutter project"
date: "2026-09-23"
description: "A useful summary of what readers will learn."
tags: ["Flutter", "Engineering"]
draft: true
---
```

Use lowercase hyphenated filenames. `index`, `assets`, `images`, and `404` are
reserved. Posts are sorted newest first, then by slug for matching dates. Dates
are display metadata, not scheduling: `draft: false` publishes at the next build,
even if the date is in the future.

## Per-post social images

Optionally add `ogImage` to frontmatter using a published, root-relative image path:

```yaml
ogImage: "/blog/images/my-post-cover.png"
```

Place that file at `content/images/my-post-cover.png`. Subfolders work too.
The generator validates that the file exists and produces an absolute production
URL for Open Graph, Twitter/X, and the article's JSON-LD image. Supported formats
are PNG, JPEG, WebP, and GIF, with letters, numbers, hyphens, and underscores in
filenames. External URLs and relative filesystem paths are not accepted.
Omit the field to retain the global `/og_image.jpg` fallback. This field controls
social metadata only; add a Markdown image to display the cover in the article.

## Images

Put optimized images in `content/images/your-post-slug/`, then use a root-relative
URL and descriptive alt text:

```md
![A diagram of the app's data flow](/blog/images/your-post-slug/data-flow.webp)
```

All files in `content/images` are public build assets, including images intended
for drafts. Do not put private material there. Markdown is trusted, author-owned
content; raw HTML is supported, so review pasted HTML before publishing.

## Local preview (includes drafts)

From the repository root:

```bash
flutter pub get
dart run scripts/build_blog.dart --preview
python3 -m http.server 8081 --directory build/blog-preview
```

Open `http://localhost:8081/blog/`. Re-run the Dart command and refresh after
editing. The preview is separate from the deployment output, includes draft
badges, and blocks search indexing. The portfolio return link requires the full
build below; a blog-only preview does not build Flutter.

## Full production preview (excludes drafts)

```bash
flutter build web --release --base-href "/"
dart run scripts/build_blog.dart
python3 -m http.server 8080 --directory build/web
```

Open `http://localhost:8080/` and follow Blog. Building Flutter clears its output,
so always run the blog generator **after** Flutter. `vercel-build.sh` already does
this. Flutter's development server (`flutter run`) does not serve generated blog
pages. Python serves the directory URLs, but Vercel-specific rewrites and HTTP
404 handling should also be checked on the PR deployment.

## What is generated

- `/blog/`: empty state until the first published article, then post cards.
- `/blog/<filename>/`: HTML article with date, tags, code blocks, and images.
- Per-page title, description, canonical URL, social metadata, and article JSON-LD.
- Optional `ogImage` selects a post-specific share image; otherwise the portfolio image is reused.
- A sitemap preserving the portfolio entries and adding published article URLs.
- A themed 404 page; unknown blog URLs must never fall through to Flutter.

Production builds exclude draft HTML, titles, and summaries. Generated files live
under ignored `build/` directories; commit the source files, never build output.
The post template stays outside `content/posts`, so it is never a real article.
Light/dark preference is shared with the portfolio through its existing browser
storage key. Reading articles works without JavaScript; JS only powers the theme
toggle.

## Validation

```bash
flutter test test/blog_builder_test.dart
flutter analyze
```

Before merging a content PR, check the draft is published intentionally, the date
and URL are correct, images have useful alt text, and links work. Search, tag
filtering, comments, and browser-based editing are intentionally deferred.
