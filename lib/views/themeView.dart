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

  //
  List querythematique;
  List querythematiqueSaved;
  bool exist=false;

  //Fonction
  Future<List<Map<String, dynamic>>> getThematique () async {
    if(!exist) {
      querythematique = await widget.themes;
      querythematiqueSaved = querythematique;
      exist = true;
    }
    return querythematique;
  }

  @override
  Widget build(BuildContext context) {
    //argument
    final type = ModalRoute.of(context).settings.arguments;
    //form
    final formGlobalKey = GlobalKey<FormState>();


    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 100,right: 100,top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Thématique',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 10,),
              SizedBox(
                //height: ,
                width: 500,
                child: TextField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.search),
                    hintText: 'Entrer votre votre recherche',
                    labelText: 'Recherche',
                  ),
                  onChanged: (text){
                    setState(() {
                      text = text.toLowerCase();
                      querythematique = querythematiqueSaved;
                      querythematique = querythematique.where((element) {

                        var nom_thematique = element["nom_theme"].toLowerCase();

                        return nom_thematique.contains(text);

                      }).toList();
                      //
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: FutureBuilder(
                    future: getThematique(),
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
                              return Card(
                                elevation: 5.0,
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/biblioteque', arguments: data[index]['id']);
                                  },
                                  child: Column(
                                    children: [
                                      Image.file(
                                        File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/themes/${data[index]['couverture_theme']}"),
                                        width: 300,
                                        height: 300,
                                      ),
                                      Text(data[index]['nom_theme']),
                                    ],
                                  ),
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

    );
  }
}
