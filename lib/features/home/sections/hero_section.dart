import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/launch_url.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
    required this.onGithub,
    required this.onLinkedIn,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  final VoidCallback onGithub;
  final VoidCallback onLinkedIn;

  @override
  Widget build(BuildContext context) {
    final isNarrow =
        MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
    final textSub = AppColors.secondaryText(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 560),
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isNarrow ? 20 : 64,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusPill().animate().fadeIn(delay: 200.ms).slideY(begin: -0.3),
            const SizedBox(height: 24),
            _KineticHeadline(isNarrow: isNarrow),
            const SizedBox(height: 20),
            Text(
              '13 years in software · Flutter specialist · Cairo, Egypt',
              style: GoogleFonts.inter(
                color: textSub,
                fontSize: isNarrow ? 16 : 20,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
            const SizedBox(height: 36),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _HeroCta(
                  label: 'View Projects',
                  onTap: onViewProjects,
                  filled: true,
                ),
                _HeroCta(
                  label: 'Download CV',
                  onTap: () => launchExternalUrl(AppConstants.cvDownloadUrl),
                  filled: false,
                ),
              ],
            ).animate().fadeIn(delay: 800.ms),
            const SizedBox(height: 36),
            _StatsRow().animate().fadeIn(delay: 1000.ms),
            const SizedBox(height: 36),
            Row(
              children: [
                if (AppConstants.showGithubInHero) ...[
                  _SocialChip(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: onGithub,
                  ),
                  const SizedBox(width: 8),
                ],
                _SocialChip(
                  icon: Icons.work_outline,
                  label: 'LinkedIn',
                  onTap: onLinkedIn,
                ),
                const SizedBox(width: 8),
                _SocialChip(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  onTap: () =>
                      launchExternalUrl('mailto:${AppConstants.email}'),
                ),
              ],
            ).animate().fadeIn(delay: 1100.ms),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.teal.withValues(alpha: 0.4)),
      color: AppColors.teal.withValues(alpha: 0.08),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.teal,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Open to new opportunities',
          style: GoogleFonts.inter(
            color: AppColors.teal,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _KineticHeadline extends StatefulWidget {
  const _KineticHeadline({required this.isNarrow});

  final bool isNarrow;

  @override
  State<_KineticHeadline> createState() => _KineticHeadlineState();
}

class _KineticHeadlineState extends State<_KineticHeadline> {
  final _roles = const [
    'Mobile Team Lead',
    'Flutter Architect',
    'Cross-Platform Dev',
  ];
  int _idx = 0;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) {
        return;
      }
      setState(() => _idx = (_idx + 1) % _roles.length);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fs = widget.isNarrow ? 34.0 : 60.0;
    final textPrimary = AppColors.primaryText(context);
    final textSub = AppColors.secondaryText(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Abdallah Gaber',
          style: GoogleFonts.spaceGrotesk(
            color: textPrimary,
            fontSize: fs,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
        Row(
          children: [
            Text(
              'Senior ',
              style: GoogleFonts.spaceGrotesk(
                color: textSub,
                fontSize: fs * 0.58,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(begin: const Offset(0, 0.4), end: Offset.zero)
                      .animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeOut),
                      ),
                  child: child,
                ),
              ),
              child: Text(
                _roles[_idx],
                key: ValueKey(_idx),
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.violet,
                  fontSize: fs * 0.58,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 450.ms),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 32,
    runSpacing: 16,
    children: const [
      _Stat('13+', 'Years Experience'),
      _Stat('20+', 'Apps Shipped'),
      _Stat('3+', 'Teams Led'),
    ],
  );
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: GoogleFonts.spaceGrotesk(
          color: AppColors.primaryText(context),
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        label,
        style: GoogleFonts.inter(
          color: AppColors.mutedText(context),
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    ],
  );
}

class _HeroCta extends StatelessWidget {
  const _HeroCta({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) => filled
      ? ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.violet,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        )
      : OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryText(context),
            side: BorderSide(color: AppColors.border(context)),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(label),
        );
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ActionChip(
    avatar: Icon(icon, size: 16, color: AppColors.secondaryText(context)),
    label: Text(
      label,
      style: TextStyle(color: AppColors.secondaryText(context), fontSize: 12),
    ),
    onPressed: onTap,
    backgroundColor: AppColors.surfaceHighColor(context),
    side: BorderSide(color: AppColors.border(context)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  );
}
