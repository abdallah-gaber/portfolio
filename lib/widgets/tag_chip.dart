import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: AppTheme.spaceSm, bottom: AppTheme.spaceSm),
      child: Chip(
        label: Text(
          label,
          style: theme.textTheme.labelMedium,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spaceSm,
          vertical: AppTheme.spaceXs,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
