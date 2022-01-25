import 'package:Harmattan_guinee/model/livre.dart';
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
