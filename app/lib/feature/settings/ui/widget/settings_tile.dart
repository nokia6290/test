import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.label,
    required VoidCallback this.onTap,
    this.isDestructive = false,
    super.key,
  })  : isOn = null,
        onChanged = null;

  const SettingsTile.toggle({
    required this.label,
    required bool this.isOn,
    required ValueChanged<bool> this.onChanged,
    this.icon,
    this.isDestructive = false,
    super.key,
  }) : onTap = null;

  final Widget? icon;
  final String label;
  final VoidCallback? onTap;
  final bool? isOn;
  final bool isDestructive;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isOn = this.isOn;
    final onChanged = this.onChanged;
    final leading = isDestructive
        ? IconTheme(
            data: IconThemeData(
              color: context.colorScheme.error,
            ),
            child: icon!,
          )
        : icon;

    if (isOn != null && onChanged != null) {
      return SwitchListTile.adaptive(
        title: Text(label),
        secondary: leading,
        value: isOn,
        onChanged: onChanged,
      );
    }

    return ListTile(
      leading: leading,
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? context.colorScheme.error : null,
        ),
      ),
      onTap: onTap,
    );
  }
}
