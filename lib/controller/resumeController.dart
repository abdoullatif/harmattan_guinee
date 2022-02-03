import 'package:Harmattan_guinee/model/livre.dart';
import 'package:Harmattan_guinee/utils/config.dart';
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
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              label: Text('Retour'),
              icon: Icon(Icons.exit_to_app, size: 35,),
              tooltip: 'Quitter',
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: null,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 300,
            ),
            FloatingActionButton.extended(
              label: Text('Changer de mode'),
              icon: Icon(Icons.brightness_6_rounded, size: 35,),
              backgroundColor: Colors.black38,
              onPressed: (){
                currentTheme.switchTheme();
              },
              heroTag: null,
            )
          ]
      ),
    );
  }
}
