import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/experience_card.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  static const int _expandedCount = 2;
  bool _accordionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    final list = PortfolioData.experience;
    final expandedItems = list.take(_expandedCount).toList();
    final collapsedItems = list.skip(_expandedCount).toList();

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
            const SectionHeader(title: 'Experience'),
            SizedBox(height: AppTheme.spaceLg),
            ...expandedItems.map(
              (e) => ExperienceCard(item: e, expanded: true),
            ),
            if (collapsedItems.isNotEmpty) ...[
              ExpansionTile(
                initiallyExpanded: _accordionExpanded,
                onExpansionChanged: (v) => setState(() => _accordionExpanded = v),
                title: Text(
                  'Earlier roles',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                children: collapsedItems
                    .map(
                      (e) => ExperienceCard(
                        item: e,
                        expanded: true,
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
