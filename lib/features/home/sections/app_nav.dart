import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class AppNav extends StatelessWidget implements PreferredSizeWidget {
  const AppNav({
    super.key,
    required this.onNavTap,
    required this.onDownloadCv,
    required this.onContact,
    required this.onThemeToggle,
    this.isDark = false,
  });

  final void Function(String sectionId) onNavTap;
  final VoidCallback onDownloadCv;
  final VoidCallback onContact;
  final VoidCallback onThemeToggle;
  final bool isDark;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNarrow = MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;

    return AppBar(
      title: GestureDetector(
        onTap: () => onNavTap('hero'),
        child: Text(
          AppConstants.siteName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actions: [
        if (!isNarrow) ...[
          _NavLink(label: 'About', onTap: () => onNavTap('about')),
          _NavLink(label: 'Experience', onTap: () => onNavTap('experience')),
          _NavLink(label: 'Projects', onTap: () => onNavTap('projects')),
          _NavLink(label: 'Skills', onTap: () => onNavTap('skills')),
          _NavLink(label: 'Contact', onTap: () => onNavTap('contact')),
          SizedBox(width: AppTheme.spaceSm),
          TextButton(
            onPressed: onDownloadCv,
            child: const Text('Download CV'),
          ),
          Padding(
            padding: EdgeInsets.only(right: AppTheme.spaceMd),
            child: FilledButton(
              onPressed: onContact,
              child: const Text('Contact'),
            ),
          ),
        ],
        IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: onThemeToggle,
          tooltip: isDark ? 'Light mode' : 'Dark mode',
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label),
    );
  }
}
