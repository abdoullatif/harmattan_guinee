import 'package:Harmattan_guinee/utils/config.dart';
import 'package:Harmattan_guinee/views/homeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomeController extends StatelessWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Traitement controller homeView
    int nombre = 20;

    return Scaffold(
      body: HomeView(nombre),
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
