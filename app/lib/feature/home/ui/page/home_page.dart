import 'package:flutter/material.dart';
import 'package:scalable_flutter_app_pro/core/extension/context.dart';
import 'package:scalable_flutter_app_pro/feature/article/ui/widget/articles_tab.dart';
import 'package:scalable_flutter_app_pro/feature/explore/ui/widget/explore_tab.dart';
import 'package:scalable_flutter_app_pro/feature/notifications/ui/widget/notification_action_handler.dart';
import 'package:scalable_flutter_app_pro/feature/user/ui/widget/profile_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = <_HomeTab>[
      _HomeTab(
        label: context.l10n.home,
        icon: Icons.home,
        builder: (context) => const ArticlesTab(),
      ),
      _HomeTab(
        label: context.l10n.explore,
        icon: Icons.explore,
        builder: (context) => const ExploreTab(),
      ),
      _HomeTab(
        label: context.l10n.profile,
        icon: Icons.person,
        builder: (context) => const ProfileTab(),
      ),
    ];

    final Widget body;
    final Widget? bottomNavigationBar;
    final content = tabs[_selectedIndex].builder(context);

    if (context.isWide) {
      body = Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: [
              for (final tab in tabs)
                NavigationRailDestination(
                  label: Text(tab.label),
                  icon: Icon(tab.icon),
                ),
            ],
          ),
          Expanded(child: content),
        ],
      );
      bottomNavigationBar = null;
    } else {
      body = SafeArea(child: content);
      bottomNavigationBar = BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          for (final tab in tabs)
            BottomNavigationBarItem(
              label: tab.label,
              icon: Icon(tab.icon),
            ),
        ],
      );
    }

    return NotificationActionHandler(
      child: Scaffold(
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}

class _HomeTab {
  const _HomeTab({
    required this.label,
    required this.icon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final WidgetBuilder builder;
}
