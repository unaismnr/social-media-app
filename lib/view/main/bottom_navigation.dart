import 'package:flutter/material.dart';
import 'package:sm_app/utils/color_consts.dart';

final navigationNotifier = ValueNotifier(0);

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: navigationNotifier,
        builder: (context, newNav, _) {
          return NavigationBar(
            selectedIndex: newNav,
            onDestinationSelected: (newValue) {
              navigationNotifier.value = newValue;
            },
            indicatorColor: mainBlue.withOpacity(0.1),
            backgroundColor: mainBlue.withOpacity(0.06),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.feed_outlined),
                  selectedIcon: Icon(Icons.feed),
                  label: 'Feeds'),
              NavigationDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: 'Chats'),
              NavigationDestination(
                  icon: Icon(Icons.change_circle_outlined),
                  selectedIcon: Icon(Icons.change_circle),
                  label: 'Stories'),
              NavigationDestination(
                  icon: Icon(Icons.person_3_outlined),
                  selectedIcon: Icon(Icons.person_3),
                  label: 'Profile'),
            ],
          );
        });
  }
}
