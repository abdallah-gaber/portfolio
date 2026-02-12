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
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext == null) return;
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );
  }

  void _onDownloadCv() {
    if (AppConstants.cvDownloadUrl.startsWith('TODO_')) return;
    launchExternalUrl(AppConstants.cvDownloadUrl);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= AppConstants.breakpointTablet;
    return Scaffold(
      drawer: isWide ? null : _buildDrawer(context),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Text(
              AppConstants.siteName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actions: [
              if (isWide) ...[
                TextButton(
                  onPressed: () => _scrollToSection('about'),
                  child: const Text('About'),
                ),
                TextButton(
                  onPressed: () => _scrollToSection('experience'),
                  child: const Text('Experience'),
                ),
                TextButton(
                  onPressed: () => _scrollToSection('projects'),
                  child: const Text('Projects'),
                ),
                TextButton(
                  onPressed: () => _scrollToSection('skills'),
                  child: const Text('Skills'),
                ),
                TextButton(
                  onPressed: () => _scrollToSection('contact'),
                  child: const Text('Contact'),
                ),
                TextButton(
                  onPressed: AppConstants.cvDownloadUrl.startsWith('TODO_')
                      ? null
                      : _onDownloadCv,
                  child: Text(
                    AppConstants.cvDownloadUrl.startsWith('TODO_')
                        ? 'Download CV (TODO)'
                        : 'Download CV',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: AppTheme.spaceMd),
                  child: FilledButton(
                    onPressed: () => _scrollToSection('contact'),
                    child: const Text('Contact'),
                  ),
                ),
              ],
              IconButton(
                icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: widget.onThemeToggle,
                tooltip: widget.isDark ? 'Light mode' : 'Dark mode',
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _Section(key: _sectionKeys['hero'], child: _buildHero()),
                _Section(key: _sectionKeys['about'], child: const AboutSection()),
                _Section(key: _sectionKeys['experience'], child: const ExperienceSection()),
                _Section(key: _sectionKeys['projects'], child: const ProjectsSection()),
                _Section(key: _sectionKeys['skills'], child: const SkillsSection()),
                _Section(key: _sectionKeys['contact'], child: const ContactSection()),
                FooterSection(onNavTap: _scrollToSection),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + AppTheme.spaceMd),
        children: [
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('about');
            },
          ),
          ListTile(
            title: const Text('Experience'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('experience');
            },
          ),
          ListTile(
            title: const Text('Projects'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('projects');
            },
          ),
          ListTile(
            title: const Text('Skills'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('skills');
            },
          ),
          ListTile(
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('contact');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Download CV'),
            onTap: () {
              Navigator.pop(context);
              _onDownloadCv();
            },
          ),
          ListTile(
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              _scrollToSection('contact');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return HeroSection(
      onViewProjects: () => _scrollToSection('projects'),
      onContact: () => _scrollToSection('contact'),
      onGithub: () {
        if (!AppConstants.githubUrl.startsWith('TODO_')) {
          launchExternalUrl(AppConstants.githubUrl);
        }
      },
      onLinkedIn: () {
        if (!AppConstants.linkedInUrl.startsWith('TODO_')) {
          launchExternalUrl(AppConstants.linkedInUrl);
        }
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}