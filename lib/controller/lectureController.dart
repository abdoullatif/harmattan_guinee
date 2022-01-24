import 'package:Harmattan_guinee/model/page.dart';
import 'package:Harmattan_guinee/views/lectureView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LectureController extends StatelessWidget {
  const LectureController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement de la lecture, du pdf
    final livre_id = ModalRoute.of(context).settings.arguments;
    var page = Pages.SelectWherePageLivre(int.parse(livre_id));

    return Scaffold(
      body: LectureView(page),
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
