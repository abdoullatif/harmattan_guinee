import 'package:Harmattan_guinee/views/themeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ThemeController extends StatelessWidget {
  const ThemeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThemeView(),
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
