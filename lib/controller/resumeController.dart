import 'package:Harmattan_guinee/views/resumeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ResumeController extends StatelessWidget {
  const ResumeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResumeView(),
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
