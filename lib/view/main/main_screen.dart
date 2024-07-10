import 'package:flutter/material.dart';
import 'package:sm_app/view/chats/chat_screen.dart';
import 'package:sm_app/view/feeds/feed_screen.dart';
import 'package:sm_app/view/main/bottom_navigation.dart';
import 'package:sm_app/view/profile/profile_screen.dart';
import 'package:sm_app/view/stories/stories_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final screens = [
    FeedScreen(),
    ChatScreen(),
    StoriesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: navigationNotifier,
          builder: (context, newNav, _) {
            return screens[newNav];
          }),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
