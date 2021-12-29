import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_turn/page_turn.dart';


class LectureView extends StatefulWidget {
  const LectureView({Key key}) : super(key: key);

  @override
  _LectureViewState createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> {
  final _controller = GlobalKey<PageTurnState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: PageTurn(
          key: _controller,
          backgroundColor: Colors.white,
          showDragCutoff: false,
          lastPage: Container(child: Center(child: Text('Last Page!'))),
          children: <Widget>[
            //for (var i = 0; i < 20; i++) AlicePage(page: i),
          ],
        ),
      ),
    );
  }
}
