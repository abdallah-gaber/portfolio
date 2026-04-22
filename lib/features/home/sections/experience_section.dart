import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/scroll_reveal.dart';
import '../../../shared/widgets/section_label.dart';
import '../../../widgets/experience_card.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  static const _expandedCount = 2;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    final list = PortfolioData.experience;
    final visible = _showAll ? list : list.take(_expandedCount).toList();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isNarrow ? 20 : 64,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollReveal(child: const SectionLabel(label: 'Experience')),
            const SizedBox(height: 32),
            ...List.generate(
              visible.length,
              (i) => ScrollReveal(
                delay: Duration(milliseconds: 100 * i),
                child: ExperienceCard(
                  item: visible[i],
                  isLast:
                      i == visible.length - 1 &&
                      (_showAll || list.length <= _expandedCount),
                ),
              ),
            ),
            if (list.length > _expandedCount)
              TextButton.icon(
                onPressed: () => setState(() => _showAll = !_showAll),
                icon: Icon(_showAll ? Icons.expand_less : Icons.expand_more),
                label: Text(_showAll ? 'Show less' : 'Show earlier roles'),
                style: TextButton.styleFrom(foregroundColor: AppColors.violet),
              ),
          ],
        ),
      ),
    );
  }
}
