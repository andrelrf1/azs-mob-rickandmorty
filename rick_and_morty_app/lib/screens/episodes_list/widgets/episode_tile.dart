import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/screens/episode/episode_screen.dart';

class EpisodeTileWidget extends StatelessWidget {
  final String title;
  final String details;
  final String releaseDate;
  final int id;
  final bool watched;
  final bool liked;

  EpisodeTileWidget({
    Key key,
    @required this.title,
    @required this.details,
    @required this.releaseDate,
    @required this.id,
    this.watched = false,
    this.liked = false,
  })  : assert(title != null &&
            details != null &&
            id != null &&
            releaseDate != null),
        super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    getImageRoute(details),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$id - $title'),
                    SizedBox(height: 15.0),
                    Text(
                      '$details - $releaseDate',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EpisodeScreen(
            id: id,
            watched: watched,
            liked: liked,
          ),
        ));
      },
    );
  }
}
