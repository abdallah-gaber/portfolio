import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/scroll_reveal.dart';
import '../../../shared/widgets/section_label.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isNarrow ? 20 : 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollReveal(child: const SectionLabel(label: 'About me')),
          const SizedBox(height: 32),
          isNarrow ? _NarrowBento() : _WideBento(),
        ],
      ),
    );
  }
}

class _WideBento extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ScrollReveal(delay: 100.ms, child: _BioCellLarge()),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ScrollReveal(delay: 200.ms, child: _AvailabilityCell()),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ScrollReveal(delay: 300.ms, child: _LocationCell()),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ScrollReveal(delay: 400.ms, child: _YearsCell()),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ScrollReveal(delay: 500.ms, child: _QuickFactsCell()),
            ),
          ],
        ),
      ),
    ],
  );
}

class _NarrowBento extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      ScrollReveal(child: _BioCellLarge()),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: ScrollReveal(delay: 100.ms, child: _AvailabilityCell()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ScrollReveal(delay: 200.ms, child: _YearsCell()),
          ),
        ],
      ),
      const SizedBox(height: 12),
      ScrollReveal(delay: 300.ms, child: _QuickFactsCell()),
    ],
  );
}

class _BioCellLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GlassCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.violet, AppColors.teal],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Abdallah Gaber',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'I lead mobile teams and own the full app lifecycle - concept, design, build, deploy, '
          'and release. 13 years in software means I have shipped apps across Android, iOS, and '
          'Flutter for companies ranging from startups to government-scale digital platforms.',
          style: GoogleFonts.inter(
            color: AppColors.textSub,
            fontSize: 15,
            height: 1.7,
          ),
        ),
      ],
    ),
  );
}

class _AvailabilityCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GlassCard(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.teal.withValues(alpha: 0.12),
        AppColors.teal.withValues(alpha: 0.04),
      ],
    ),
    borderColor: AppColors.teal.withValues(alpha: 0.3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.teal,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Available',
              style: GoogleFonts.inter(
                color: AppColors.teal,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Open to\nnew roles',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

class _LocationCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GlassCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.coral,
          size: 22,
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.location,
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Egypt',
          style: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 12),
        ),
      ],
    ),
  );
}

class _YearsCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GlassCard(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.violet.withValues(alpha: 0.15),
        AppColors.violet.withValues(alpha: 0.05),
      ],
    ),
    borderColor: AppColors.violet.withValues(alpha: 0.3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '13+',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.violet,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'Years\nexperience',
          style: GoogleFonts.inter(
            color: AppColors.textSub,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

class _QuickFactsCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GlassCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick facts',
          style: GoogleFonts.inter(
            color: AppColors.textMuted,
            fontSize: 11,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PortfolioData.quickFacts.map((f) => _FactChip(f)).toList(),
        ),
      ],
    ),
  );
}

class _FactChip extends StatelessWidget {
  const _FactChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.violet.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.violet.withValues(alpha: 0.25)),
    ),
    child: Text(
      label,
      style: GoogleFonts.inter(
        color: AppColors.violet,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
