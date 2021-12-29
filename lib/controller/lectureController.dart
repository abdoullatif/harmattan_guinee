import 'package:Harmattan_guinee/views/lectureView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LectureController extends StatelessWidget {
  const LectureController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LectureView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print('exit');
          Navigator.pop(context);
        },
        tooltip: 'Quitter',
        backgroundColor: Colors.red,
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
