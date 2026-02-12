# Portfolio refresh 2026 – Flutter Web

## Plan / Summary

### What changed

- **Flutter Web** single-page portfolio: Top Nav, Hero, About, Experience, Featured Projects, Archive, Skills, Contact, Footer.
- **Design system:** Light/dark theme (persisted), Material 3, spacing/typography scale, reusable widgets.
- **Responsive:** Drawer on mobile, nav bar on desktop; smooth scroll to sections.
- **Content:** CV-based (Link Development, Hood’s, MOC ePalace, Hood’s Seller/Shopper). Featured projects have descriptions, screenshots, store links. Archive projects have app icons (`imagePath`), optional store links (Android/iOS icons), dimmed when no links.
- **Profile:** GitHub, LinkedIn, CV download URL set; GitHub hidden in hero via `showGithubInHero`.
- **SEO:** Title, description, OG tags and OG image (`web/og_image.jpg`), `sitemap.xml`, `robots.txt` (Sitemap enabled for abdallahgaber.dev).
- **Firebase Analytics:** Integrated (script in `web/index.html`, init in `lib/main.dart`). Run `dart run flutterfire_cli:flutterfire configure` to enable.
- **README:** Run, config, add project, Firebase, deploy.

### What’s left (optional)

- Run **FlutterFire configure** to enable Firebase Analytics (see README).
- **Deploy:** `flutter build web` → deploy `build/web/` (e.g. Vercel: build command `flutter build web`, output `build/web`).

### How to deploy

1. `flutter build web` (output: `build/web/`).
2. Deploy `build/web/` to your host. Ensure Flutter is available in the build environment (or build locally and deploy the folder).
3. If using a different domain, update `web/sitemap.xml` and `web/robots.txt`.
