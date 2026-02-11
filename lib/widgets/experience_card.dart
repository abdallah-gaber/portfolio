import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/models/experience_item.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.item,
    this.expanded = true,
    this.onTap,
  });

  final ExperienceItem item;
  final bool expanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: AppTheme.spaceMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.role,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppTheme.spaceXs),
                        Text(
                          item.company,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: AppTheme.spaceXs),
                        Text(
                          item.period,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      expanded ? Icons.expand_less : Icons.expand_more,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
              if (expanded && item.bullets.isNotEmpty) ...[
                SizedBox(height: AppTheme.spaceMd),
                ...item.bullets.map(
                  (b) => Padding(
                    padding: EdgeInsets.only(bottom: AppTheme.spaceXs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6, right: AppTheme.spaceSm),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Expanded(child: Text(b, style: theme.textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                ),
              ],
              if (expanded && item.tools != null && item.tools!.isNotEmpty) ...[
                SizedBox(height: AppTheme.spaceSm),
                Wrap(
                  spacing: AppTheme.spaceXs,
                  runSpacing: AppTheme.spaceXs,
                  children: item.tools!
                      .split(RegExp(r'[,&]'))
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .map((t) => Chip(
                            label: Text(t, style: theme.textTheme.labelSmall),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
