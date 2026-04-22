import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class GlassNavBar extends StatelessWidget {
  const GlassNavBar({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.onNavTap,
    required this.onDownloadCv,
  });

  final bool isDark;
  final VoidCallback onThemeToggle;
  final void Function(String) onNavTap;
  final VoidCallback onDownloadCv;

  static const _links = [
    ('About', 'about'),
    ('Experience', 'experience'),
    ('Projects', 'projects'),
    ('Skills', 'skills'),
    ('Contact', 'contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide =
        MediaQuery.sizeOf(context).width >= AppConstants.breakpointTablet;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0x26080810),
            border: Border(bottom: BorderSide(color: AppColors.glassBorder)),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => onNavTap('hero'),
                    child: Text(
                      AppConstants.siteName,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isWide) ...[
                    for (final (label, id) in _links)
                      _NavLink(label: label, onTap: () => onNavTap(id)),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: onDownloadCv,
                      icon: const Icon(
                        Icons.download_outlined,
                        size: 15,
                        color: AppColors.teal,
                      ),
                      label: const Text(
                        'CV',
                        style: TextStyle(color: AppColors.teal, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => onNavTap('contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.violet,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Contact',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (!isWide)
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: AppColors.textSub,
                      size: 20,
                    ),
                    onPressed: onThemeToggle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hover = true),
    onExit: (_) => setState(() => _hover = false),
    child: TextButton(
      onPressed: widget.onTap,
      style: TextButton.styleFrom(
        foregroundColor: _hover ? AppColors.violet : AppColors.textSub,
        textStyle: const TextStyle(fontSize: 14),
      ),
      child: Text(widget.label),
    ),
  );
}
