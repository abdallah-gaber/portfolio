import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.onNavTap});

  final void Function(String sectionId) onNavTap;

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.spaceXl,
        horizontal: AppTheme.spaceMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor(context),
        border: Border(
          top: BorderSide(color: AppColors.border(context), width: 1),
        ),
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppTheme.spaceLg,
            runSpacing: AppTheme.spaceSm,
            children: [
              _FooterLink(label: 'About', onTap: () => onNavTap('about')),
              _FooterLink(
                label: 'Experience',
                onTap: () => onNavTap('experience'),
              ),
              _FooterLink(label: 'Projects', onTap: () => onNavTap('projects')),
              _FooterLink(label: 'Skills', onTap: () => onNavTap('skills')),
              _FooterLink(label: 'Contact', onTap: () => onNavTap('contact')),
            ],
          ),
          SizedBox(height: AppTheme.spaceMd),
          Text(
            '© $year ${AppConstants.siteName}. Built with Flutter Web.',
            style: TextStyle(color: AppColors.mutedText(context), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(color: AppColors.mutedText(context), fontSize: 12),
      ),
    );
  }
}
