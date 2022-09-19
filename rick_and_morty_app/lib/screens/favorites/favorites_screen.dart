import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/episode.dart';
import 'package:rick_and_morty_app/screens/episodes_list/widgets/episode_tile.dart';
import 'package:rick_and_morty_app/sqlite.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Episode> _episodes = [];
  bool _loading = true;

  Future<void> getEpisodes() async {
    SQLite database = SQLite();
    await database.connect();
    List<Episode> episodesList = await database.getEpisodes('liked');
    if (mounted) {
      setState(() {
        _episodes = episodesList;
        _loading = false;
      });
    }
    await database.disconnect();
  }

  @override
  void initState() {
    getEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _episodes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star_border_rounded,
                        size: 60.0,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'No favorites',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  itemCount: _episodes.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: EpisodeTileWidget(
                      title: _episodes[index].name,
                      details: _episodes[index].episode,
                      releaseDate: _episodes[index].airDate,
                      id: _episodes[index].id,
                      watched: _episodes[index].watched,
                      liked: _episodes[index].liked,
                    ),
                  ),
                ),
    );
  }
}
