import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class ThemeView extends StatefulWidget {
  const ThemeView({Key key}) : super(key: key);

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    //argument
    final type = ModalRoute.of(context).settings.arguments;
    //form
    final formGlobalKey = GlobalKey<FormState>();

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 100,right: 100),
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                Text(
                    'Thématique ($type)',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                    ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  //height: ,
                  width: 500,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.search),
                      hintText: 'Entrer votre votre recherche',
                      labelText: 'Recherche',
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Divider(),
                GridView.count(
                  shrinkWrap: true,
                  //primary: false,
                  //padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/biblioteque');
                      },
                      child: Image.asset("assets/theme/arts_spectacles.png"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/biblioteque');
                      },
                      child: Image.asset("assets/theme/communication.png"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/biblioteque');
                      },
                      child: Image.asset("assets/theme/droit.png"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
