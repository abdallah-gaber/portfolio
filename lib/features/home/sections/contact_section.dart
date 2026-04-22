import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/launch_url.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/scroll_reveal.dart';
import '../../../shared/widgets/section_label.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
          ScrollReveal(child: const SectionLabel(label: "Let's connect")),
          const SizedBox(height: 32),
          ScrollReveal(
            delay: const Duration(milliseconds: 100),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: GlassCard(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.violet.withValues(alpha: 0.12),
                      AppColors.teal.withValues(alpha: 0.06),
                    ],
                  ),
                  borderColor: AppColors.violet.withValues(alpha: 0.3),
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Text(
                        'Have a project in mind?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.primaryText(context),
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "I'm available for freelance, consulting, or full-time opportunities.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.secondaryText(context),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () =>
                            launchExternalUrl('mailto:${AppConstants.email}'),
                        icon: const Icon(Icons.email_outlined),
                        label: Text(AppConstants.email),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.violet,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.mutedText(context),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppConstants.location,
                            style: GoogleFonts.inter(
                              color: AppColors.mutedText(context),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
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
