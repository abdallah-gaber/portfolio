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
          description: 'A digital cultural platform connecting artists and audiences through exhibitions, events, and rich creative content.',
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
            'Team leadership',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=com.moc.epalace&hl=en',
          iosUrl: 'https://apps.apple.com/eg/app/id6756418392?l=ar',
          imagePath: "assets/images/placeholder_moc_epalace.png",
          isFeatured: true,
        ),
        ProjectItem(
          name: "Hood's Shopper",
          role: 'Senior Flutter Developer',
          description: 'A live-stream shopping platform where users discover, interact, and buy products in real time.',
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=live.hoods',
          iosUrl: 'https://apps.apple.com/eg/app/hoods-live-shopping/id1614081311',
          imagePath: 'assets/images/placeholder_hoods_shopper.jpeg',
          isFeatured: true,
        ),
        ProjectItem(
          name: "Hood's Seller",
          role: 'Senior Flutter Developer',
          description: 'A seller platform for hosting live streams, showcasing products, and managing real-time sales.',
          techHighlights: [
            'Full lifecycle',
            'Release to stores',
            'Agile delivery',
          ],
          androidUrl: 'https://play.google.com/store/apps/details?id=live.hoods.seller',
          iosUrl: 'https://apps.apple.com/eg/app/sell-on-hoods/id1614340111',
          imagePath: 'assets/images/placeholder_hoods_seller.jpeg',
          isFeatured: true,
        ), 
      ];

  static List<ProjectItem> get archiveProjects => [
        const ProjectItem(
          name: 'Radwa',
          role: 'Developer (Flutter)',
          androidUrl: 'https://play.google.com/store/apps/details?id=sa.net.is.radwa&hl=en',
          iosUrl: 'https://apps.apple.com/eg/app/radwa-express-%D8%B1%D8%B6%D9%88%D9%89-%D8%A5%D9%83%D8%B3%D8%A8%D8%B1%D9%8A%D8%B3/id1536911687',
          isFeatured: false,
          imagePath: 'assets/images/radwa-app.webp',
        ),
        const ProjectItem(
          name: 'Awal Qatfa',
          role: 'Developer (Flutter)',
          iosUrl: 'https://apps.apple.com/eg/app/awal-qatfa-%D8%A7%D9%88%D9%84-%D9%82%D8%B7%D9%81%D8%A9/id1509689405',
          isFeatured: false,
        imagePath: 'assets/images/AwalQatfa-app.webp',
        ),
        const ProjectItem(
          name: 'Jawhara',
          role: 'Developer (Flutter)',
          androidUrl: 'https://play.google.com/store/apps/details?id=online.jawhara',
          iosUrl: 'https://apps.apple.com/eg/app/%D8%AC%D9%88%D9%87%D8%B1%D9%87-%D8%AA%D8%B3%D9%88%D9%82-%D8%A3%D9%88%D9%86%D9%84%D8%A7%D9%8A%D9%86/id1565162947',
          isFeatured: false,
          imagePath: 'assets/images/jawhara-app.webp',
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
