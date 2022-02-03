import 'package:Harmattan_guinee/model/livre.dart';
import 'package:Harmattan_guinee/utils/config.dart';
import 'package:Harmattan_guinee/views/bibliothequeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class BibliothequeController extends StatelessWidget {
  const BibliothequeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement biblioteque
    final parametre = ModalRoute.of(context).settings.arguments;
    //var livreThematique = Livre.SelectWhereTheme(int.parse(themes_id));
    var livreThematique = Livre.SelectWhereTypeTheme(int.tryParse(parametre) ?? 00,parametre);

    return Scaffold(
      body: BibliothequeView(livreThematique),
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
