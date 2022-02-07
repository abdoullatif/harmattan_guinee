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
    var page = Pages.SelectWherePageLivreId(int.parse(livre_id));

    return Scaffold(
      body: LectureView(page),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Retour', style: Theme.of(context).textTheme.button,),
        icon: Icon(Icons.exit_to_app, size: 35, color: Theme.of(context).buttonColor,),
        tooltip: 'Quitter',
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pop(context);
        },
        heroTag: null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
