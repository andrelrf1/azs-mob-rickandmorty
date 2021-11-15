import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/episodes_list/widgets/episode_tile.dart';

class SeasonScreen extends StatelessWidget {
  final List<Map<String, dynamic>> episodes;

  SeasonScreen({
    Key? key,
    required this.episodes,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: RotatedBox(
          quarterTurns: 1,
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_circle_down,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        itemCount: episodes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: EpisodeTileWidget(
            title: episodes[index]['name'],
            details: episodes[index]['episode'],
            releaseDate: episodes[index]['air_date'],
            id: int.parse(episodes[index]['id']),
          ),
        ),
      ),
    );
  }
}
