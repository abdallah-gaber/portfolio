import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/models/project_item.dart';
import '../core/utils/launch_url.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImage(context),
          Padding(
            padding: EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spaceXs),
                Text(
                  project.role,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (project.description != null) ...[
                  SizedBox(height: AppTheme.spaceSm),
                  Text(
                    project.description!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                if (project.techHighlights.isNotEmpty) ...[
                  SizedBox(height: AppTheme.spaceSm),
                  Wrap(
                    spacing: AppTheme.spaceXs,
                    runSpacing: AppTheme.spaceXs,
                    children: project.techHighlights
                        .map((t) => Chip(
                              label: Text(t, style: theme.textTheme.labelSmall),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ))
                        .toList(),
                  ),
                ],
                SizedBox(height: AppTheme.spaceMd),
                Row(
                  children: [
                    if (project.androidUrl != null && !project.androidUrl!.startsWith('TODO'))
                      Padding(
                        padding: EdgeInsets.only(right: AppTheme.spaceSm),
                        child: _LinkChip(
                          label: 'Play Store',
                          url: project.androidUrl!,
                        ),
                      ),
                    if (project.iosUrl != null && !project.iosUrl!.startsWith('TODO'))
                      _LinkChip(
                        label: 'App Store',
                        url: project.iosUrl!,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: project.imagePath != null
          ? Image.asset(
              project.imagePath!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(theme),
            )
          : _placeholder(theme),
    );
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            SizedBox(height: AppTheme.spaceSm),
            Text(
              'TODO_SCREENSHOT',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  const _LinkChip({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _openUrl(url),
    );
  }

  void _openUrl(String url) {
    launchExternalUrl(url);
  }
}
