import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/scroll_reveal.dart';
import '../../../shared/widgets/section_label.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _accents = [AppColors.violet, AppColors.teal, AppColors.coral];

  @override
  Widget build(BuildContext context) {
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    final entries = PortfolioData.skills.entries.toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isNarrow ? 20 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollReveal(child: const SectionLabel(label: 'Skills')),
          const SizedBox(height: 32),
          isNarrow
              ? Column(
                  children: List.generate(
                    entries.length,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ScrollReveal(
                        delay: Duration(milliseconds: 100 * i),
                        child: _SkillGroupCard(
                          category: entries[i].key,
                          skills: entries[i].value,
                          accent: _accents[i % _accents.length],
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    entries.length,
                    (i) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: i < entries.length - 1 ? 12 : 0,
                        ),
                        child: ScrollReveal(
                          delay: Duration(milliseconds: 100 * i),
                          child: _SkillGroupCard(
                            category: entries[i].key,
                            skills: entries[i].value,
                            accent: _accents[i % _accents.length],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({
    required this.category,
    required this.skills,
    required this.accent,
  });

  final String category;
  final List<String> skills;
  final Color accent;

  @override
  Widget build(BuildContext context) => GlassCard(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [accent.withValues(alpha: 0.10), accent.withValues(alpha: 0.02)],
    ),
    borderColor: accent.withValues(alpha: 0.25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.toUpperCase(),
          style: GoogleFonts.inter(
            color: accent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        ...skills.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  s,
                  style: GoogleFonts.inter(
                    color: AppColors.primaryText(context),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
