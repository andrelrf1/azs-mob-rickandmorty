import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/episodes_list/widgets/episode_tile.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> episodes;

  SearchScreen({Key key, @required this.episodes})
      : assert(episodes != null),
        super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _filteredEpisodes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                onChanged: (value) {
                  List<Map<String, dynamic>> itens = [];
                  widget.episodes.forEach((element) {
                    if (element['name']
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      itens.add(element);
                    }
                    if (this.mounted) {
                      setState(() {
                        _filteredEpisodes = itens;
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        itemCount: _filteredEpisodes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: EpisodeTileWidget(
            title: _filteredEpisodes[index]['name'],
            details: _filteredEpisodes[index]['episode'],
            releaseDate: _filteredEpisodes[index]['air_date'],
            id: int.parse(_filteredEpisodes[index]['id']),
          ),
        ),
      ),
    );
  }
}
