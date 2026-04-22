import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 3,
        height: 20,
        color: AppColors.violet,
        margin: const EdgeInsets.only(right: 12),
      ),
      Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          color: AppColors.textMuted,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
      ),
    ],
  );
}
