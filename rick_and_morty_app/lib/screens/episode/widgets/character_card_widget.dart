import 'package:flutter/material.dart';

class CharacterCardWidget extends StatelessWidget {
  final String characterName;
  final String specie;
  final String status;
  final String imageURL;

  CharacterCardWidget({
    Key key,
    @required this.characterName,
    @required this.specie,
    @required this.status,
    @required this.imageURL,
  })  : assert(characterName != null &&
            specie != null &&
            status != null &&
            imageURL != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(characterName),
              Text(
                '$specie - $status',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
