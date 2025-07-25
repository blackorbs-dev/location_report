import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final Widget? leading;

  const MainAppBar({
    super.key,
    required this.title,
    this.leading, this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title, style: context.theme.textTheme.titleSmall,
      ),
      centerTitle: true,
      backgroundColor: context.theme.colorScheme.onPrimary,
      leading: leading,
      actions: action == null? null : [action!],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
