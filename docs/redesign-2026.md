# Portfolio Redesign 2026

This document summarizes the `feat/portfolio-bento-2026` redesign work for the Flutter Web portfolio.

## What changed

- Reworked the visual system to a dark-first aurora theme with custom typography via `google_fonts`.
- Replaced the standard app bar with a floating frosted-glass navigation bar.
- Added shared glass UI primitives in `lib/shared/widgets/`.
- Introduced animated aurora background and scroll-reveal behavior.
- Redesigned the hero into a kinetic headline with rotating role labels and richer CTA/stat blocks.
- Converted the About section into a bento-style layout.
- Rebuilt Experience into a glowing vertical timeline.
- Upgraded project cards with hover treatment and stronger visual hierarchy.
- Reworked Skills into grouped glass cards with category accents.
- Replaced the flat contact rows with a centered CTA card.
- Removed the now-unused `lib/features/home/sections/app_nav.dart`.

## New dependencies

- `google_fonts`
- `flutter_animate`
- `visibility_detector`

## Dependency note

`google_fonts ^6.x` conflicts with the previously pinned `flutterfire_cli ^0.2.6` in this repo's dependency graph. To keep `flutter pub get` resolvable, the dev dependency was adjusted to `flutterfire_cli ^0.1.1+2`.

## Verification

- `flutter analyze`
- `flutter test`

Both passed after the redesign changes.

## Visual assets

The repository currently contains project imagery under `assets/images/`, and the README now uses those images for richer documentation.

A true portfolio walkthrough GIF was not generated in this environment because browser/video capture tooling was not available during the update pass.
