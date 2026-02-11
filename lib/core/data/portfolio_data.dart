import '../models/experience_item.dart';
import '../models/project_item.dart';

/// Central data for the portfolio (experience, projects, skills).
class PortfolioData {
  PortfolioData._();

  static List<ExperienceItem> get experience => [
        const ExperienceItem(
          company: 'Link Development',
          role: 'Senior Cross Platform Software Technical Lead',
          period: 'July 2024 – Now',
          tools: 'Azure Pipeline, Flutter, Dart, Java, Git, Android Studio, Xcode, Microsoft',
          bullets: [
            'Full app lifecycle: concept, design, build, deploy, release.',
            'Lead cross-platform team; Agile delivery.',
            'Shipped MOC ePalace (Android + iOS).',
          ],
        ),
        const ExperienceItem(
          company: "Hood's",
          role: 'Senior Mobile Developer (Flutter)',
          period: 'March 2022 – June 2024',
          tools: 'Flutter, Dart',
          bullets: [
            'Seller app (Android + iOS).',
            'Shopper app (Android + iOS).',
          ],
        ),
        const ExperienceItem(
          company: 'Ma3n',
          role: 'Flutter Senior Developer',
          period: 'Earlier',
          bullets: [],
        ),
        const ExperienceItem(
          company: 'INTERNeT SOLUTIONS',
          role: 'Flutter Senior Developer',
          period: 'Earlier',
          bullets: [],
        ),
        const ExperienceItem(
          company: 'Earlier roles',
          role: 'Android / Java development',
          period: 'Earlier',
          bullets: [],
        ),
      ];

  static List<ProjectItem> get featuredProjects => [
        ProjectItem(
          name: 'MOC ePalace',
          role: 'Technical Lead',
          description: 'Official app for MOC ePalace services.', // TODO_PROJECT_DESC
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
            'Team leadership',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=com.moc.epalace&hl=en',
          iosUrl: 'https://apps.apple.com/eg/app/id6756418392?l=ar',
          imagePath: null, // TODO_SCREENSHOT: e.g. 'assets/images/placeholder_moc_epalace.png'
          isFeatured: true,
        ),
        ProjectItem(
          name: "Hood's Seller",
          role: 'Senior Flutter Developer',
          description: 'Seller app for Hood\'s live shopping platform.', // TODO_PROJECT_DESC
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=live.hoods.seller',
          iosUrl: 'https://apps.apple.com/eg/app/sell-on-hoods/id1614340111',
          imagePath: null,
          isFeatured: true,
        ),
        ProjectItem(
          name: "Hood's Shopper",
          role: 'Senior Flutter Developer',
          description: 'Shopper app for Hood\'s live shopping.', // TODO_PROJECT_DESC
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=live.hoods',
          iosUrl: 'https://apps.apple.com/eg/app/hoods-live-shopping/id1614081311',
          imagePath: null,
          isFeatured: true,
        ),
      ];

  static List<ProjectItem> get archiveProjects => [
        const ProjectItem(
          name: 'Hadded',
          role: 'Flutter',
          androidUrl: 'https://play.google.com/store/apps/details?id=...',
          iosUrl: 'https://apps.apple.com/...',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Hadded Owner',
          role: 'Flutter',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Tamkeen',
          role: 'Flutter',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Morstan',
          role: 'Flutter',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Morstan Doctors',
          role: 'Flutter',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Radwa',
          role: 'Android',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Awal Qatfa',
          role: 'Android',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Jawhara',
          role: 'Android',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Andalosian',
          role: 'Android',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'AT%',
          role: 'Android',
          isFeatured: false,
        ),
        const ProjectItem(
          name: 'Top Stores',
          role: 'Android',
          isFeatured: false,
        ),
      ];

  static const Map<String, List<String>> skills = {
    'Mobile': [
      'Flutter',
      'Dart',
      'Android',
      'iOS basics',
    ],
    'Tooling': [
      'Azure Pipelines',
      'Git',
      'CI/CD',
    ],
    'Practices': [
      'Agile',
      'Design Patterns',
      'Testing', // TODO: depth/level if needed
    ],
  };

  static const List<String> quickFacts = [
    'Flutter',
    'Dart',
    'CI/CD',
    'Azure Pipelines',
    'Mobile Architecture',
    'Leadership',
  ];
}
