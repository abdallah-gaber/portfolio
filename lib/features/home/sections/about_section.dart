import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/tag_chip.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            const SectionHeader(title: 'About'),
            SizedBox(height: AppTheme.spaceMd),
            Text(
              'I lead mobile teams and own the full app lifecycle—from concept and design to build, deploy, and release. '
              'I focus on quality, Agile delivery, and clear communication with stakeholders.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            SizedBox(height: AppTheme.spaceLg),
            Text(
              'Quick facts',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: AppTheme.spaceSm),
            Wrap(
              children: PortfolioData.quickFacts.map((f) => TagChip(label: f)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
