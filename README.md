# Abdallah Gaber – Portfolio (Flutter Web)

Personal portfolio site for [abdallahgaber.dev](https://abdallahgaber.dev). Built with **Flutter Web**: responsive, light/dark theme, single-page layout with smooth scroll.

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
- **SEO:** `web/sitemap.xml` and `web/robots.txt` point to `abdallahgaber.dev`. Update if your domain differs. OG image: `web/og_image.jpg` (referenced in `web/index.html`).

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
  features/home/  # Home page and sections (nav, hero, about, experience, projects, skills, contact, footer)
  widgets/        # Shared UI (SectionHeader, PrimaryButton, ProjectCard, ExperienceCard, TagChip)
```

## Deploy

- **Build:** `flutter build web`
- **Output:** `build/web/` (static assets + `index.html`, `main.dart.js`, etc.)
- **Vercel:** Point the project root to the repo and set build command to `flutter build web` and output directory to `build/web`. Existing `vercel.json` and `.well-known/` are preserved at repo root for app links.
- **Analytics:** Firebase Analytics is set up; see **Firebase Analytics** above.

## License

Private / personal use.
