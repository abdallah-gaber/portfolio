import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../core/models/project_item.dart';
import '../../../core/utils/launch_url.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    final crossAxisCount = _crossAxisCount(MediaQuery.sizeOf(context).width);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.spaceSection,
        horizontal: isNarrow ? AppTheme.spaceMd : AppTheme.spaceXxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Featured Projects'),
          SizedBox(height: AppTheme.spaceLg),
          LayoutBuilder(
            builder: (context, constraints) {
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: AppTheme.spaceMd,
                crossAxisSpacing: AppTheme.spaceMd,
                childAspectRatio: 0.75,
                children: PortfolioData.featuredProjects
                    .map((p) => ProjectCard(project: p))
                    .toList(),
              );
            },
          ),
          SizedBox(height: AppTheme.spaceXxl),
          Text(
            'Archive',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spaceSm),
          Text(
            'Older apps. Some products may have evolved since my contribution.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppTheme.spaceMd),
          Wrap(
            spacing: AppTheme.spaceMd,
            runSpacing: AppTheme.spaceMd,
            children: PortfolioData.archiveProjects
                .map((p) => _ArchiveProjectCard(project: p))
                .toList(),
          ),
        ],
      ),
    );
  }

  int _crossAxisCount(double width) {
    if (width >= AppConstants.breakpointDesktop) return 3;
    if (width >= AppConstants.breakpointTablet) return 2;
    return 1;
  }
}

bool _isValidUrl(String? url) {
  if (url == null || url.isEmpty) return false;
  if (url.startsWith('TODO')) return false;
  return true;
}

class _ArchiveProjectCard extends StatelessWidget {
  const _ArchiveProjectCard({required this.project});

  final ProjectItem project;

  static const double _iconSize = 40;

  Widget _buildAppIcon(ThemeData theme, bool hasAnyLink) {
    final color = hasAnyLink
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;
    if (project.imagePath != null && project.imagePath!.isNotEmpty) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            project.imagePath!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(
              Icons.apps,
              size: 28,
              color: color,
            ),
          ),
        ),
      );
    }
    return Icon(Icons.apps, size: 28, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAndroid = _isValidUrl(project.androidUrl);
    final hasIos = _isValidUrl(project.iosUrl);
    final hasAnyLink = hasAndroid || hasIos;

    return Opacity(
      opacity: hasAnyLink ? 1.0 : 0.5,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spaceMd,
            vertical: AppTheme.spaceSm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAppIcon(theme, hasAnyLink),
              SizedBox(width: AppTheme.spaceSm),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    project.role,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (hasAndroid || hasIos) ...[
                SizedBox(width: AppTheme.spaceSm),
                if (hasAndroid)
                  IconButton(
                    icon: const Icon(Icons.android),
                    onPressed: () => launchExternalUrl(project.androidUrl!),
                    tooltip: 'Open on Play Store',
                    style: IconButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
                if (hasIos)
                  IconButton(
                    icon: const Icon(Icons.apple),
                    onPressed: () => launchExternalUrl(project.iosUrl!),
                    tooltip: 'Open on App Store',
                    style: IconButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
