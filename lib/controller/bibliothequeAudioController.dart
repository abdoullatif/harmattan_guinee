import 'package:Harmattan_guinee/model/livre.dart';
import 'package:Harmattan_guinee/views/bibliothequeAudioView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class BibliothequeAudioController extends StatelessWidget {
  const BibliothequeAudioController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement biblioteque Audio
    final parametre = ModalRoute.of(context).settings.arguments;
    var livreaudio = Livre.SelectWhereTypeTheme(int.tryParse('2') ?? 00,parametre);

    return Scaffold(
      body: BibliotequeAudioView(livreaudio),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print('exit');
          Navigator.pop(context);
        },
        tooltip: 'Quitter',
        backgroundColor: Colors.red,
        child: Icon(Icons.exit_to_app, size: 35,),
      ),
    );
  }
}