import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/models/experience_item.dart';
import '../core/theme/app_theme.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.item,
    this.expanded = true,
    this.onTap,
    this.isLast = false,
  });

  final ExperienceItem item;
  final bool expanded;
  final VoidCallback? onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surfaceHighColor(context);
    final border = AppColors.border(context);
    final textPrimary = AppColors.primaryText(context);
    final textSub = AppColors.secondaryText(context);
    final textMuted = AppColors.mutedText(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.violet.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.violet.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.role,
                    style: GoogleFonts.spaceGrotesk(
                      color: textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.company,
                    style: GoogleFonts.inter(
                      color: AppColors.violet,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.period,
                    style: GoogleFonts.inter(color: textMuted, fontSize: 12),
                  ),
                  if (expanded && item.bullets.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    ...item.bullets.map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6, right: 8),
                              child: Icon(
                                Icons.arrow_right,
                                size: 16,
                                color: AppColors.teal,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                b,
                                style: GoogleFonts.inter(
                                  color: textSub,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (expanded &&
                      item.tools != null &&
                      item.tools!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item.tools!
                          .split(RegExp(r'[,&]'))
                          .map((t) => t.trim())
                          .where((t) => t.isNotEmpty)
                          .map((t) => _TechTag(t))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  const _TechTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.surfaceColor(context),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.border(context)),
    ),
    child: Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        color: AppColors.mutedText(context),
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
