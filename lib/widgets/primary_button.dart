import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/launch_url.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spaceLg,
            vertical: AppTheme.spaceMd,
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [icon!, SizedBox(width: AppTheme.spaceSm), Text(label)],
              )
            : Text(label),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spaceLg,
          vertical: AppTheme.spaceMd,
        ),
      ),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon!, SizedBox(width: AppTheme.spaceSm), Text(label)],
            )
          : Text(label),
    );
  }
}

/// Link that opens in new tab (for web).
class ExternalLinkButton extends StatelessWidget {
  const ExternalLinkButton({
    super.key,
    required this.label,
    required this.url,
    this.isPlaceholder = false,
  });

  final String label;
  final String url;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    if (isPlaceholder || url.startsWith('TODO_')) {
      return FilledButton.tonal(
        onPressed: null,
        child: Text('$label (TODO)'),
      );
    }
    return FilledButton(
      onPressed: () => launchExternalUrl(url),
      child: Text(label),
    );
  }
}
