import 'package:Harmattan_guinee/model/audio.dart';
import 'package:Harmattan_guinee/model/langue.dart';
import 'package:Harmattan_guinee/model/livre.dart';
import 'package:Harmattan_guinee/utils/config.dart';
import 'package:Harmattan_guinee/utils/parametre.dart';
import 'package:Harmattan_guinee/views/bibliothequeAudioView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class BibliothequeAudioController extends StatelessWidget {
  const BibliothequeAudioController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement biblioteque Audio
    final langue_id = ModalRoute.of(context).settings.arguments;
    //var livreAudio = Audio.SelectAudio();
    var livreAudio;
    if(langue_id != '' && langue_id != null) livreAudio = Audio.SelectWhereAudioLangue(langue_id);
    else livreAudio = Audio.SelectAudioFr();
    //
    var langue = Langue.Select();


    return Scaffold(
      body: BibliotequeAudioView(livreAudio,langue),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              label: Text('Retour', style: Theme.of(context).textTheme.button,),
              icon: Icon(Icons.exit_to_app, size: 35, color: Theme.of(context).buttonColor,),
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
              backgroundColor: Theme.of(context).backgroundColor, //Colors.black38
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
