import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Harmattan_guinee/model/theme.dart';
import 'package:Harmattan_guinee/views/themeView.dart';

class ThemeController extends StatelessWidget {
  const ThemeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //traitement des theme a afficher
    var themes = Themes.Select();

    return Scaffold(
      body: ThemeView(themes),
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
