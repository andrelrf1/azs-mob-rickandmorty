import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:rick_and_morty_app/models/episode.dart';
import 'package:rick_and_morty_app/requests/graphql.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:rick_and_morty_app/screens/episode/widgets/character_card_widget.dart';
import 'package:rick_and_morty_app/sqlite.dart';

class EpisodeScreen extends StatefulWidget {
  final int id;
  final bool watched;
  final bool liked;
  EpisodeScreen({
    Key key,
    @required this.id,
    this.watched = false,
    this.liked = false,
  })  : assert(id != null),
        super(key: key);

  @override
  _EpisodeScreenState createState() =>
      _EpisodeScreenState(watched: watched, liked: liked);
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  final ScrollController _scrollCtrl = ScrollController();
  Map<String, dynamic> _episodeData = {};
  bool _loading = true;
  bool watched;
  bool liked;

  _EpisodeScreenState({this.watched, this.liked});

  Future<void> saveEpisodeDetails() async {
    SQLite dataBase = SQLite();
    Episode episode = Episode(
      id: int.parse(_episodeData['id']),
      name: _episodeData['name'],
      episode: _episodeData['episode'],
      airDate: _episodeData['air_date'],
      liked: liked,
      watched: watched,
    );
    await dataBase.connect();
    await dataBase.insertEpisode(episode: episode);
    await dataBase.disconnect();
  }

  String getImageRoute(String epDetails) {
    epDetails = epDetails.substring(0, 3);
    String imageRoute;
    switch (epDetails) {
      case 'S01':
        imageRoute = 'assets/baners/s1.jpg';
        break;
      case 'S02':
        imageRoute = 'assets/baners/s2.jpg';
        break;
      case 'S03':
        imageRoute = 'assets/baners/s3.jpg';
        break;
      case 'S04':
        imageRoute = 'assets/baners/s4.png';
        break;
    }
    return imageRoute;
  }

  void getEpisodeData() async {
    Graphql graphql = Graphql();
    SQLite dataBase = SQLite();
    QueryResult result = await graphql.getEpisode(id: widget.id);
    await dataBase.connect();
    List<Episode> data = await dataBase.getEpisodes(
      'getWatched',
      id: widget.id,
    );
    setState(() {
      if (this.mounted) {
        _episodeData = result.data['episode'];
        if (data.isNotEmpty) {
          watched = data[0].watched;
          liked = data[0].liked;
        }
        _loading = false;
      }
    });
  }

  @override
  void initState() {
    getEpisodeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: Image.asset(
                    getImageRoute(_episodeData['episode']),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Colors.transparent,
                    ],
                  )),
                ),
                Scrollbar(
                  controller: _scrollCtrl,
                  child: ListView(
                    controller: _scrollCtrl,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      SizedBox(height: 300.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(
                                  '${_episodeData['id']} - ${_episodeData['name']}',
                                  style: TextStyle(fontSize: 26),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                '${_episodeData['episode']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                '${_episodeData['air_date']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ActionChip(
                          onPressed: () async {
                            await LaunchApp.openApp(
                              androidPackageName: 'com.netflix.mediaclient',
                              appStoreLink:
                                  'https://play.google.com/store/apps/details?id=com.netflix.mediaclient',
                            );
                          },
                          label: Text('Assistir na Netflix'),
                          avatar: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: Image.asset('assets/netflix.svg'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ActionChip(
                            avatar: Icon(Icons.done_rounded),
                            label: Text('Assistido'),
                            onPressed: () async {
                              setState(() {
                                watched = !watched;
                                if (!watched) {
                                  liked = watched;
                                }
                              });
                              await saveEpisodeDetails();
                            },
                            backgroundColor: watched ? Colors.cyan : null,
                          ),
                          SizedBox(width: 10.0),
                          ActionChip(
                            avatar: Icon(Icons.star_rounded),
                            label: Text('Favorito'),
                            onPressed: () async {
                              setState(() {
                                liked = !liked;
                                if (liked) {
                                  watched = liked;
                                }
                              });
                              await saveEpisodeDetails();
                            },
                            backgroundColor: liked ? Colors.orange[600] : null,
                          ),
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        'Characters',
                        style: TextStyle(fontSize: 22),
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.only(top: 20.0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: (50 / 70),
                        ),
                        itemCount: _episodeData['characters'].length,
                        itemBuilder: (context, index) => CharacterCardWidget(
                            characterName: _episodeData['characters'][index]
                                ['name'],
                            specie: _episodeData['characters'][index]
                                ['species'],
                            status: _episodeData['characters'][index]['status'],
                            imageURL: _episodeData['characters'][index]
                                ['image']),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
