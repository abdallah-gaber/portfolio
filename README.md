# Abdallah Gaber – Portfolio (Flutter Web)

Personal portfolio site for [abdallahgaber.dev](https://abdallahgaber.dev). Built with **Flutter Web** and refreshed with the 2026 bento redesign: aurora background, glass navigation, animated hero, bento About layout, timeline Experience, and upgraded project/skills/contact sections.

See the redesign summary in [docs/redesign-2026.md](/Users/abdallahgaber/Library/CloudStorage/OneDrive-LinkDevelopment/private/portfolio/docs/redesign-2026.md).

## Highlights

- Dark-first aurora visual system with custom typography
- Floating frosted-glass navigation
- Animated hero with rotating role headline
- Bento About section and timeline Experience section
- Hover-enhanced project cards and grouped glass skill cards
- Scroll-reveal animations across the page

## Project Screenshots

Featured project media currently available in the repo:

### MOC ePalace

![MOC ePalace screenshot](/Users/abdallahgaber/Library/CloudStorage/OneDrive-LinkDevelopment/private/portfolio/assets/images/placeholder_moc_epalace.png)

### Hood's Shopper

![Hood's Shopper screenshot](/Users/abdallahgaber/Library/CloudStorage/OneDrive-LinkDevelopment/private/portfolio/assets/images/placeholder_hoods_shopper.jpeg)

### Hood's Seller

![Hood's Seller screenshot](/Users/abdallahgaber/Library/CloudStorage/OneDrive-LinkDevelopment/private/portfolio/assets/images/placeholder_hoods_seller.jpeg)

## GIF Preview

A live portfolio walkthrough GIF has not been added yet. I could not generate a real browser capture in this environment because video/browser capture tooling was unavailable, so this README only includes the static screenshots that already exist in the repository.

## How to run

**Prerequisites:** Flutter SDK (stable channel, with web support).

```bash
# Install dependencies
flutter pub get

# Run in Chrome (development)
flutter run -d chrome

# Build for production (output in build/web/)
flutter build web
```

Serve the built site locally (e.g. for testing production build):

```bash
# From project root, serve build/web
cd build/web && python3 -m http.server 8080
# Or use any static server; open http://localhost:8080
```

## Configuration (done / optional)

- **Profile & CV:** GitHub, LinkedIn, and CV download URL are set in `lib/core/constants/app_constants.dart`. `showGithubInHero` is `false` (GitHub icon hidden in hero); set to `true` to show it.
- **Featured projects:** Descriptions, screenshots (`imagePath`), and store links live in `lib/core/data/portfolio_data.dart` → `featuredProjects`.
- **Archive projects:** Each item can have `name`, `role`, `androidUrl`, `iosUrl`, and `imagePath` (app icon). Cards show the icon when `imagePath` is set; store links open Play Store / App Store.
- **SEO:** `web/sitemap.xml` and `web/robots.txt` point to `abdallahgaber.dev`. Update if your domain differs. OG image: `web/og_image.jpg` (referenced in `web/index.html`). Title, description, theme-color, and Twitter Card meta tags are set in `web/index.html`.
- **Favicon & PWA:** Custom favicons in `web/`: `favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png`, `apple-touch-icon.png`, `android-chrome-192x192.png`, `android-chrome-512x512.png`. `manifest.json` uses theme `#0B1220` and the android-chrome icons for PWA (no separate maskable icons).

## Firebase Analytics

Analytics is wired with **Firebase** (script in `web/index.html`, init in `lib/main.dart`). To enable it:

1. **Create a Firebase project**  
   Go to [Firebase Console](https://console.firebase.google.com/) → Create project (or use existing) → turn on **Analytics** if prompted.

2. **Add a Web app**  
   In the project: Project settings (gear) → **Your apps** → **Add app** → choose **Web** (</>). Register the app; you’ll get a `firebaseConfig` object.

3. **Connect this repo with FlutterFire**  
   From the project root run:
   ```bash
   dart run flutterfire_cli:flutterfire configure
   ```
   Sign in if asked, pick the Firebase project, select **Web**. This generates `lib/firebase_options.dart` with your config (and keeps `web/index.html` scripts as-is).

4. **Run / build**  
   After that, `flutter run -d chrome` or `flutter build web` will use your config. The app logs an “app open” event when the site loads.

**Where it lives:**  
- **Scripts:** `web/index.html` (Firebase JS SDK).  
- **Init & events:** `lib/main.dart` (Firebase.initializeApp + FirebaseAnalytics.instance.logAppOpen).

## How to add a new project

1. **Featured project (card with description and store links)**  
   Edit `lib/core/data/portfolio_data.dart`. In `featuredProjects`, add a `ProjectItem`:
   - `name`, `role`, `description`, `techHighlights`, `androidUrl` / `iosUrl`, optional `imagePath`.

2. **Archive project (card in the list)**  
   In the same file, add a `ProjectItem` to `archiveProjects` with `name`, `role`, optional `androidUrl` / `iosUrl`, and optional `imagePath` (app icon). Set `isFeatured: false`. Cards with no store links appear dimmed; cards with links show Android/Apple icon buttons.

3. **Images**  
   Add files under `assets/images/` and set `imagePath` in `portfolio_data.dart`. Featured projects use it for the card screenshot; archive projects use it for the small app icon. No need to change `pubspec.yaml`; `assets/images/` is already declared.

## Project structure

```
lib/
  core/           # Theme, constants, models, data, utils
  features/home/  # Home page, sections, and home-specific widgets (aurora, glass nav)
  shared/widgets/ # Shared glass and animation primitives
  widgets/        # Reusable UI such as project and experience cards
docs/
  redesign-2026.md
```

## Deploy

- **Build:** `flutter build web`
- **Output:** `build/web/` (static assets + `index.html`, `main.dart.js`, etc.)

### Vercel

`vercel.json` is configured with:

- **buildCommand:** `flutter build web`
- **outputDirectory:** `build/web` (so Vercel serves the Flutter build, not the repo root)
- **rewrites:** Paths without a file extension are rewritten to `/index.html` (SPA fallback so direct URLs and refresh work)
- **headers:** Preserved for `apple-app-site-association` and `.well-known/`

Vercel’s default build image does not include Flutter. In the project **Settings → Build & Development**:

1. Set **Framework Preset** to **Other**.
2. Set **Install Command** to one of:
   - A command that installs Flutter (e.g. clone the Flutter SDK and run `flutter pub get`), or
   - Use a [Flutter-compatible build image or community template](https://vercel.com/docs/deployments/configure-a-build) if available.
3. Build Command and Output Directory are overridden by `vercel.json` (`flutter build web` and `build/web`).

If you see **NOT_FOUND (404)** after deploy, the usual cause is the output directory not set to `build/web` (so `index.html` is not found). The rewrites fix 404s for in-app paths (e.g. opening `/about` directly).

- **Analytics:** Firebase Analytics is set up; see **Firebase Analytics** above.

## License

Private / personal use.
