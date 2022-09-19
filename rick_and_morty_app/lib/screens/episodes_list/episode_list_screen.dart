import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:rick_and_morty_app/requests/graphql.dart';
import 'package:rick_and_morty_app/screens/episodes_list/widgets/episode_tile.dart';
import 'package:rick_and_morty_app/screens/episodes_list/widgets/seasson_card.dart';
import 'package:rick_and_morty_app/screens/search/search_screen.dart';
import 'package:rick_and_morty_app/screens/seasson/seasson_screen.dart';

class EpisodeListScreen extends StatefulWidget {
  const EpisodeListScreen({super.key});

  @override
  _EpisodeListScreenState createState() => _EpisodeListScreenState();
}

class _EpisodeListScreenState extends State<EpisodeListScreen> {
  final ScrollController _scrollCtrl = ScrollController();
  List<Map<String, dynamic>> _episodes = [];
  bool _loading = true;
  int _selectedChip = 0;

  void getData() async {
    Graphql graphql = Graphql();
    List<QueryResult> results = await Future.wait([
      graphql.getAllEpisodes(page: 1),
      graphql.getAllEpisodes(page: 2),
      graphql.getAllEpisodes(page: 3),
    ]);
    List<Map<String, dynamic>?> data = [
      for (var result in results) result.data
    ];
    if (mounted) {
      setState(() {
        _episodes = [
          ...data[0]!['episodes']['results'],
          ...data[1]!['episodes']['results'],
          ...data[2]!['episodes']['results'],
        ];
      });
      _loading = false;
    }
  }

  void nextScreen(String seasson) {
    List<Map<String, dynamic>> data = [];
    for (var element in _episodes) {
      if (element['episode'].contains(seasson)) {
        data.add(element);
      }
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SeasonScreen(episodes: data),
    ));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          _loading
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchScreen(episodes: _episodes),
                    ));
                  },
                ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                ActionChip(
                  label: const Text('Episódios'),
                  onPressed: () {
                    setState(() {
                      _selectedChip = 0;
                    });
                  },
                  backgroundColor:
                      _selectedChip == 0 ? Colors.green[700] : Colors.grey[700],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                ActionChip(
                  label: const Text('Temporadas'),
                  onPressed: () {
                    setState(() {
                      _selectedChip = 1;
                    });
                  },
                  backgroundColor:
                      _selectedChip == 1 ? Colors.green[700] : Colors.grey[700],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollCtrl,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _selectedChip == 0
                ? _episodes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 60.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'No episodes',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          right: 15.0,
                          left: 15.0,
                        ),
                        controller: _scrollCtrl,
                        itemCount: _episodes.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: EpisodeTileWidget(
                            title: _episodes[index]['name'],
                            details: _episodes[index]['episode'],
                            releaseDate: _episodes[index]['air_date'],
                            id: int.parse(_episodes[index]['id']),
                          ),
                        ),
                      )
                : _episodes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 60.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'No Seassons',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          right: 15.0,
                          left: 15.0,
                        ),
                        controller: _scrollCtrl,
                        children: [
                          SeasonCardWidget(
                            seasonTitle: '1ª Temporada',
                            imagePath: 'assets/baners/s1.jpg',
                            onPressed: () {
                              nextScreen('S01');
                            },
                          ),
                          SeasonCardWidget(
                            seasonTitle: '2ª Temporada',
                            imagePath: 'assets/baners/s2.jpg',
                            onPressed: () {
                              nextScreen('S02');
                            },
                          ),
                          SeasonCardWidget(
                            seasonTitle: '3ª Temporada',
                            imagePath: 'assets/baners/s3.jpg',
                            onPressed: () {
                              nextScreen('S03');
                            },
                          ),
                          SeasonCardWidget(
                            seasonTitle: '4ª Temporada',
                            imagePath: 'assets/baners/s4.png',
                            onPressed: () {
                              nextScreen('S04');
                            },
                          ),
                        ],
                      ),
      ),
    );
  }
}
