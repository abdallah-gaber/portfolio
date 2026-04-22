import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/models/project_item.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/launch_url.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectItem project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final surface = AppColors.surfaceHighColor(context);
    final border = AppColors.border(context);
    final textPrimary = AppColors.primaryText(context);
    final textSub = AppColors.secondaryText(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? AppColors.violet.withValues(alpha: 0.5)
                  : border,
              width: _hovered ? 1.5 : 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.violet.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: p.imagePath != null
                      ? Image.asset(
                          p.imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.violet.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          p.role,
                          style: GoogleFonts.inter(
                            color: AppColors.violet,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.name,
                        style: GoogleFonts.spaceGrotesk(
                          color: textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (p.description != null) ...[
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            p.description!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: textSub,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      if (p.techHighlights.isNotEmpty)
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: p.techHighlights
                              .map((t) => _TinyChip(t))
                              .toList(),
                        ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          if (p.androidUrl != null &&
                              !p.androidUrl!.startsWith('TODO'))
                            _StoreBtn(
                              icon: Icons.android,
                              label: 'Play Store',
                              onTap: () => launchExternalUrl(p.androidUrl!),
                              accent: AppColors.teal,
                            ),
                          const SizedBox(width: 8),
                          if (p.iosUrl != null && !p.iosUrl!.startsWith('TODO'))
                            _StoreBtn(
                              icon: Icons.apple,
                              label: 'App Store',
                              onTap: () => launchExternalUrl(p.iosUrl!),
                              accent: AppColors.textSub,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
    color: AppColors.surfaceColor(context),
    child: Center(
      child: Icon(
        Icons.phone_android,
        size: 48,
        color: AppColors.mutedText(context).withValues(alpha: 0.4),
      ),
    ),
  );
}

class _TinyChip extends StatelessWidget {
  const _TinyChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.surfaceColor(context),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.border(context)),
    ),
    child: Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        color: AppColors.mutedText(context),
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _StoreBtn extends StatelessWidget {
  const _StoreBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: accent),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
