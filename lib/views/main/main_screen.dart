import 'package:flutter/material.dart';
import 'package:sm_app/views/chats/chat_screen.dart';
import 'package:sm_app/views/feeds/feed_screen.dart';
import 'package:sm_app/views/main/bottom_navigation.dart';
import 'package:sm_app/views/profile/profile_screen.dart';
import 'package:sm_app/views/stories/stories_screen.dart';

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
