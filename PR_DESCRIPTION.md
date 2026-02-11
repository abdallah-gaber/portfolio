# Portfolio refresh 2026 – Flutter Web

## Plan / Summary

### What changed

- **Scaffolded Flutter Web** in the repo (replacing the previous static HTML landing).
- **Single-page portfolio** with sections: Top Nav, Hero, About, Experience, Featured Projects, Archive Projects, Skills, Contact, Footer.
- **Design system:** Light + dark theme (persisted via `shared_preferences`), typography scale, spacing scale, reusable widgets (`SectionHeader`, `PrimaryButton`, `ProjectCard`, `ExperienceCard`, `TagChip`). Material 3, neutral palette with blue accent.
- **Responsive layout:** Breakpoints for mobile / tablet / desktop; drawer nav on small screens, nav bar on wide.
- **Content:** Filled from CV (Link Development, Hood’s, MOC ePalace, Hood’s Seller/Shopper, education, skills, contact). Store links for featured apps; archive list for older apps with a short disclaimer.
- **SEO:** Updated `web/index.html` (title, description, OG tags). Added `web/sitemap.xml` and `web/robots.txt` (update domain before production).
- **README:** How to run, how to replace placeholders, how to add a project, deploy notes.

### What’s left as TODO

- **Replace placeholders** (see README):
  - `TODO_GITHUB_URL`, `TODO_LINKEDIN_URL`, `TODO_CV_PDF_URL` in `lib/core/constants/app_constants.dart`
  - Project descriptions and screenshot paths in `lib/core/data/portfolio_data.dart`
  - Sitemap/robots domain in `web/sitemap.xml` and `web/robots.txt`
- **Optional:** Contact form (static or mailto); analytics (add snippet or package and document in README).

### How to deploy

1. Run `flutter build web` (output: `build/web/`).
2. Deploy `build/web/` to your host (e.g. Vercel: set build command to `flutter build web`, output directory to `build/web`; ensure Flutter is available in the build environment or use a CI step that runs Flutter and then deploys the folder).
3. Replace placeholders and, if needed, update sitemap/robots with your production domain.
