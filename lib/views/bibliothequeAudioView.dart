import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BibliotequeAudioView extends StatefulWidget {
  final livreAudio;
  const BibliotequeAudioView(this.livreAudio, {Key key}) : super(key: key);

  @override
  _BibliotequeAudioViewState createState() => _BibliotequeAudioViewState();
}

class _BibliotequeAudioViewState extends State<BibliotequeAudioView> {
  @override
  Widget build(BuildContext context) {
    //form
    final formGlobalKey = GlobalKey<FormState>();

    return FutureBuilder(
      future: widget.livreAudio,
      builder: (context, AsyncSnapshot snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.connectionState == ConnectionState.done) {

        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          //
          var data = snapshot.data;

          return Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 40),
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    Text(
                      'Livre Audio',
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
                    SizedBox(height: 15,),
                    SizedBox(
                      height: 550,
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3.5,
                                  child: Image.file(
                                    File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[0]['titre']}/${data[0]['couverture_livre']}"),
                                    //width: 200,
                                    height: 200,
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "titre\n"
                                        "Description",

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    onPressed: () {
                                      //Navigator.pushNamed(context, '/lecture');
                                    },
                                    icon: Icon(Icons.audiotrack, size: 35),
                                    label: Text(
                                      'Ecouter',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

        } else {
          return const Text('Empty data');
        }

      } else {
        return Text('State: ${snapshot.connectionState}');
      }

      },
    );
  }
}
