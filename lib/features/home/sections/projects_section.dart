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
    final isNarrow = MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
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
                childAspectRatio: 0.85,
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
                .map((p) => _ArchiveChip(project: p))
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

class _ArchiveChip extends StatelessWidget {
  const _ArchiveChip({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasLinks = (project.androidUrl != null && project.androidUrl!.isNotEmpty &&
            !project.androidUrl!.startsWith('TODO')) ||
        (project.iosUrl != null && project.iosUrl!.isNotEmpty && !project.iosUrl!.startsWith('TODO'));

    return Padding(
      padding: EdgeInsets.only(right: AppTheme.spaceSm, bottom: AppTheme.spaceSm),
      child: ActionChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(project.name),
            if (hasLinks) ...[
              SizedBox(width: AppTheme.spaceXs),
              Text(
                ' · ${project.role}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        onPressed: hasLinks
            ? () {
                final url = project.androidUrl ?? project.iosUrl;
                if (url != null) launchExternalUrl(url);
              }
            : null,
      ),
    );
  }
}
