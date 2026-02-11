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

## How to replace placeholders

All placeholders are marked with `TODO_` in code or comments. Replace them before going live.

| Placeholder | Where | What to do |
|------------|--------|------------|
| **TODO_GITHUB_URL** | `lib/core/constants/app_constants.dart` | Set `githubUrl` to your GitHub profile URL. |
| **TODO_LINKEDIN_URL** | Same file | Set `linkedInUrl` to your LinkedIn profile URL. |
| **TODO_CV_PDF_URL** | Same file | Set `cvDownloadUrl` to the URL of your CV PDF (e.g. hosted file or link). |
| **TODO_PROJECT_DESC** | `lib/core/data/portfolio_data.dart` | Replace placeholder descriptions in `featuredProjects` with one-line descriptions per app. |
| **TODO_SCREENSHOT** | Same file + assets | Set `imagePath` for each featured project (e.g. `assets/images/placeholder_moc_epalace.png`) and add the image files under `assets/images/`. |
| **TODO_METRICS** | N/A | If you add metrics later, use real data only; do not fabricate. |
| **Sitemap domain** | `web/sitemap.xml` | Replace `https://abdallahgaber.dev/` with your production base URL if different. |
| **robots.txt Sitemap** | `web/robots.txt` | Uncomment and set `Sitemap: https://abdallahgaber.dev/sitemap.xml` (or your domain). |

## How to add a new project

1. **Featured project (card with description and store links)**  
   Edit `lib/core/data/portfolio_data.dart`. In `featuredProjects`, add a `ProjectItem`:
   - `name`, `role`, `description`, `techHighlights`, `androidUrl` / `iosUrl`, optional `imagePath`.

2. **Archive project (chip in the list)**  
   In the same file, add a `ProjectItem` to `archiveProjects` with `name`, `role`, and optional `androidUrl` / `iosUrl` (set `isFeatured: false`; other fields can be omitted).

3. **Screenshot**  
   Add the image under `assets/images/` and reference it in `imagePath` (e.g. `assets/images/my_app.png`). No need to change `pubspec.yaml` if the `assets/images/` folder is already declared.

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
- **Analytics:** Optional. Add your analytics snippet or SDK in `web/index.html` or via a Flutter package; keep a clear TODO in code where you intend to add it.

## License

Private / personal use.
