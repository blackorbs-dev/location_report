import 'package:flutter/material.dart' hide Route;
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/core/theme/extensions.dart';

import '../../../../router/routes.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  static final List<_TabItem> _tabs = [
    _TabItem(label: 'Dashboard', icon: 'assets/icons/dashboard_dial.svg', route: Route.dashboard),
    _TabItem(label: 'Report List', icon: 'assets/icons/list_unordered.svg', route: Route.reportList),
    _TabItem(label: 'Report Map', icon: 'assets/icons/location.svg', route: Route.reportMap),
    _TabItem(label: 'Account', icon: 'assets/icons/account_manage.svg', route: Route.account),
  ];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return _tabs.indexWhere((tab) => location.startsWith(tab.route));
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          indicatorColor: Colors.white10,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32)
          ),
          backgroundColor: context.theme.colorScheme.tertiaryContainer,
          labelTextStyle: WidgetStateProperty.all(
            context.theme.textTheme.bodySmall
                .withColor(context.theme.colorScheme.primary)
          ),
          destinations: _tabs.map((tab) =>
              NavigationDestination(
                  icon: SvgPicture.asset(tab.icon),
                  label: tab.label
              )
          ).toList(),
          onDestinationSelected: (index) => context.go(_tabs[index].route),
      )
    );
  }
}

class _TabItem {
  final String label;
  final String icon;
  final String route;

  const _TabItem({required this.label, required this.icon, required this.route});
}
