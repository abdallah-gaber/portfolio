import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/launch_url.dart';
import '../../../widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.spaceSection,
        horizontal: isNarrow ? AppTheme.spaceMd : AppTheme.spaceXxl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Contact'),
            SizedBox(height: AppTheme.spaceLg),
            _ContactRow(
              icon: Icons.email,
              label: 'Email',
              value: AppConstants.email,
              onTap: () => launchExternalUrl('mailto:${AppConstants.email}'),
            ),
            SizedBox(height: AppTheme.spaceMd),
            _ContactRow(
              icon: Icons.location_on,
              label: 'Location',
              value: AppConstants.location,
              onTap: null,
            ),
            SizedBox(height: AppTheme.spaceXl),
            OutlinedButton.icon(
              onPressed: () => launchExternalUrl('mailto:${AppConstants.email}'),
              icon: const Icon(Icons.email, size: 20),
              label: const Text('Send email'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceLg,
                  vertical: AppTheme.spaceMd,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: theme.colorScheme.primary),
        SizedBox(width: AppTheme.spaceMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: AppTheme.spaceXs),
              if (onTap != null)
                InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    value,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else
                Text(value, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
