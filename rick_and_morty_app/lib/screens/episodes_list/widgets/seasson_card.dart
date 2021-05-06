import 'package:flutter/material.dart';

class SeassonCardWidget extends StatelessWidget {
  final String seassonTitle;
  final String imagePath;
  final Function onPressed;

  SeassonCardWidget({
    Key key,
    @required this.seassonTitle,
    @required this.imagePath,
    @required this.onPressed,
  })  : assert(seassonTitle != null && imagePath != null && onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              alignment: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                seassonTitle,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
