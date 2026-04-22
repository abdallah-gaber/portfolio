import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_constants.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/core/utils/launch_url.dart';
import 'package:portfolio/features/home/sections/hero_section.dart';
import 'package:portfolio/features/home/sections/about_section.dart';
import 'package:portfolio/features/home/sections/experience_section.dart';
import 'package:portfolio/features/home/sections/projects_section.dart';
import 'package:portfolio/features/home/sections/skills_section.dart';
import 'package:portfolio/features/home/sections/contact_section.dart';
import 'package:portfolio/features/home/sections/footer_section.dart';
import 'package:portfolio/features/home/widgets/aurora_background.dart';
import 'package:portfolio/features/home/widgets/glass_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  final bool isDark;
  final VoidCallback onThemeToggle;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _sc = ScrollController();
  final Map<String, GlobalKey> _keys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollTo(String id) {
    final ctx = _keys[id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _downloadCv() {
    if (!AppConstants.cvDownloadUrl.startsWith('TODO_')) {
      launchExternalUrl(AppConstants.cvDownloadUrl);
    }
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: isNarrow ? _drawer(context) : null,
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          CustomScrollView(
            controller: _sc,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 64)),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      key: _keys['hero'],
                      child: HeroSection(
                        onViewProjects: () => _scrollTo('projects'),
                        onContact: () => _scrollTo('contact'),
                        onGithub: () =>
                            launchExternalUrl(AppConstants.githubUrl),
                        onLinkedIn: () =>
                            launchExternalUrl(AppConstants.linkedInUrl),
                      ),
                    ),
                    SizedBox(key: _keys['about'], child: const AboutSection()),
                    SizedBox(
                      key: _keys['experience'],
                      child: const ExperienceSection(),
                    ),
                    SizedBox(
                      key: _keys['projects'],
                      child: const ProjectsSection(),
                    ),
                    SizedBox(
                      key: _keys['skills'],
                      child: const SkillsSection(),
                    ),
                    SizedBox(
                      key: _keys['contact'],
                      child: const ContactSection(),
                    ),
                    FooterSection(onNavTap: _scrollTo),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassNavBar(
              isDark: widget.isDark,
              onThemeToggle: widget.onThemeToggle,
              onNavTap: _scrollTo,
              onDownloadCv: _downloadCv,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer(BuildContext context) => Drawer(
    backgroundColor: AppColors.surface,
    child: ListView(
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 24),
      children: [
        for (final e in {
          'About': 'about',
          'Experience': 'experience',
          'Projects': 'projects',
          'Skills': 'skills',
          'Contact': 'contact',
        }.entries)
          ListTile(
            title: Text(
              e.key,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            onTap: () {
              Navigator.pop(context);
              _scrollTo(e.value);
            },
          ),
        const Divider(color: AppColors.glassBorder),
        ListTile(
          title: const Text(
            'Download CV',
            style: TextStyle(color: AppColors.violet),
          ),
          onTap: () {
            Navigator.pop(context);
            _downloadCv();
          },
        ),
      ],
    ),
  );
}
