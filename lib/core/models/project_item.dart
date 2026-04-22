/// Featured or archive project.
class ProjectItem {
  const ProjectItem({
    required this.name,
    required this.role,
    this.description,
    this.techHighlights = const [],
    this.androidUrl,
    this.iosUrl,
    this.imagePath,
    this.isFeatured = true,
  });

  final String name;
  final String role;
  final String? description;
  final List<String> techHighlights;
  final String? androidUrl;
  final String? iosUrl;
  /// Asset path, e.g. 'assets/images/placeholder_moc.png'. Use null for placeholder widget.
  final String? imagePath;
  final bool isFeatured;
}
