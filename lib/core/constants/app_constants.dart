/// App-wide constants and placeholder URLs.
/// Replace TODO_* values before production.
class AppConstants {
  AppConstants._();

  // --- Profile & CV ---
  static const String githubUrl = 'https://github.com/abdallah-gaber';
  /// Set to false to hide GitHub from hero (e.g. if you're not active there).
  static const bool showGithubInHero = false;
  static const String linkedInUrl = 'https://www.linkedin.com/in/abdallah--gaber/';
  /// Direct-download link for CV (Google Drive export).
  static const String cvDownloadUrl =
      'https://drive.google.com/uc?export=download&id=1njzUBiAYT-C9OSzOuTGIkOHxHGhwuqKK';

  // --- Contact ---
  static const String email = 'abdallah.gaber.ragab@gmail.com';
  static const String location = 'Cairo, Egypt';

  // --- Site ---
  static const String siteName = 'Abdallah Gaber';
  static const String siteDescription =
      'Senior Mobile Team Lead (Flutter). 13 years in software. '
      'I lead cross-platform teams and ship production apps end-to-end.';

  // --- Breakpoints (logical pixels) ---
  static const double breakpointMobile = 600;
  static const double breakpointTablet = 900;
  static const double breakpointDesktop = 1200;

  // --- Spacing scale ---
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;
  static const double spaceSection = 80;
}
