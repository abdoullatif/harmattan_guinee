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
