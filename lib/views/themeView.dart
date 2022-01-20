import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class ThemeView extends StatefulWidget {
  //variable
  final themes;

  const ThemeView(this.themes, {Key key}) : super(key: key);

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
    //


    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 100,right: 100,top: 50),
        child: Form(
          key: formGlobalKey,
          child: SingleChildScrollView(
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
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
                Divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: FutureBuilder(
                      future: widget.themes,
                      builder: (context, AsyncSnapshot snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {

                            List<Map<String, dynamic>> data = snapshot.data;
                            int n = data.length;
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,
                              children: List.generate(n, (index) {
                                return TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/biblioteque');
                                  },
                                  child: Image.file(
                                    File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/themes/${data[index]['couverture_theme']}"),
                                    width: 400,
                                    height: 400,
                                  ),
                                );
                              }),
                            );

                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      }
                  ),
                )

              ],
            ),
          ),
        ),
      ),

    );
  }
}
