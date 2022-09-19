import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/episodes_list/episode_list_screen.dart';
import 'package:rick_and_morty_app/screens/favorites/favorites_screen.dart';
import 'package:rick_and_morty_app/screens/home/components/bottom_app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageCtrl = PageController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          EpisodeListScreen(),
          FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(pageCtrl: _pageCtrl),
    );
  }
}
