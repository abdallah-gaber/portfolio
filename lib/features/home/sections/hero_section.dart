import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/launch_url.dart';
import '../../../widgets/primary_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
    required this.onGithub,
    required this.onLinkedIn,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final VoidCallback onGithub;
  final VoidCallback onLinkedIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNarrow = MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.spaceSection,
        horizontal: isNarrow ? AppTheme.spaceMd : AppTheme.spaceXxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Senior Mobile Team Lead (Flutter)',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppTheme.spaceMd),
            Text(
              '13 years in software. I lead cross-platform teams and ship production apps end-to-end.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            SizedBox(height: AppTheme.spaceXl),
            Wrap(
              spacing: AppTheme.spaceMd,
              runSpacing: AppTheme.spaceMd,
              children: [
                PrimaryButton(
                  label: 'View Projects',
                  onPressed: onViewProjects,
                ),
                PrimaryButton(
                  label: 'Contact',
                  onPressed: onContact,
                  isOutlined: true,
                ),
              ],
            ),
            SizedBox(height: AppTheme.spaceXl),
            Row(
              children: [
                if (AppConstants.showGithubInHero) ...[
                  _SocialIcon(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: onGithub,
                    isPlaceholder: false,
                  ),
                  SizedBox(width: AppTheme.spaceMd),
                ],
                _SocialIcon(
                  icon: Icons.business_center,
                  label: 'LinkedIn',
                  onTap: onLinkedIn,
                  isPlaceholder: false,
                ),
                SizedBox(width: AppTheme.spaceMd),
                _SocialIcon(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () => launchExternalUrl('mailto:${AppConstants.email}'),
                  isPlaceholder: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPlaceholder = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: isPlaceholder ? '$label (TODO)' : label,
      child: IconButton(
        onPressed: isPlaceholder ? null : onTap,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
