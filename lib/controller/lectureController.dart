import 'package:Harmattan_guinee/views/lectureView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_turn/page_turn.dart';

class LectureController extends StatelessWidget {
  const LectureController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = GlobalKey<PageTurnState>();
    return Scaffold(
      body: LectureView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          _controller.currentState.goToPage(2);
        },
      ),
    );
  }
}
