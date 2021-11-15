import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  final PageController pageCtrl;

  BottomAppBarWidget({Key? key, required this.pageCtrl}) : super(key: key);

  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Container(
        height: 75.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: _index != 0 ? null : Colors.green[700],
              ),
              onPressed: () {
                setState(() {
                  _index = 0;
                });
                widget.pageCtrl.jumpToPage(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.star_rounded,
                color: _index != 1 ? null : Colors.green[700],
              ),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
                widget.pageCtrl.jumpToPage(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
