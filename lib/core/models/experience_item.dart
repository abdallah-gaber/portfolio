/// One job/role in the experience timeline.
class ExperienceItem {
  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    this.bullets = const [],
    this.tools,
  });

  final String company;
  final String role;
  final String period;
  final List<String> bullets;
  final String? tools;
}
