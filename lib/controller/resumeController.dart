import 'package:Harmattan_guinee/model/livre.dart';
import 'package:Harmattan_guinee/views/resumeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ResumeController extends StatelessWidget {
  const ResumeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement du livre, resume
    final nom_livre = ModalRoute.of(context).settings.arguments;
    var livre = Livre.SelectWhereTitre(nom_livre);


    return Scaffold(
      body: ResumeView(livre),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print('exit');
          Navigator.pop(context);
        },
        tooltip: 'Quitter',
        backgroundColor: Colors.red,
        child: Icon(Icons.exit_to_app,  size: 35,),
      ),
    );
  }
}
