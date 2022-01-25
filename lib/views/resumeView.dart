import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class ResumeView extends StatefulWidget {
  final livre;

  const ResumeView(this.livre, {Key key}) : super(key: key);

  @override
  _ResumeViewState createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  @override
  Widget build(BuildContext context) {
    //

    return FutureBuilder(
      future: widget.livre,
      builder: (context, AsyncSnapshot snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {

          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {

            var data = snapshot.data;

            return Padding(
              padding: EdgeInsets.only(left: 30,right: 30, top: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Image.file(
                            File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[0]['titre']}/${data[0]['couverture_livre']}"),
                            width: 400,
                            height: 700,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  '${data[0]['titre']}',
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30,),
                              DefaultTabController(
                                length: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child: TabBar(
                                          indicatorColor: Colors.blue,
                                          unselectedLabelColor: Colors.grey,
                                          labelColor: Colors.blue,
                                          tabs: [
                                            Tab(text: "Resume"),
                                            Tab(text: "Biographie de l'auteur"),
                                            //Tab(text: "User"),
                                          ]
                                      ),
                                    ),
                                    Container(
                                      //Add this to give height
                                      height: MediaQuery.of(context).size.height /2.5,
                                      child: TabBarView(
                                          children: [
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 30,),
                                                  Text("${data[0]['resume_livre']}"),
                                                ],
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 30,),
                                                  Text("${data[0]['biographie_auteur']}"),
                                                ],
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    onPressed: () {
                                      _showDialogBuy(context);
                                    },
                                    icon: Icon(Icons.shopping_cart, size: 18),
                                    label: Text('Acheter'),
                                  ),
                                  SizedBox(width: 20,),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    onPressed: () {
                                      _showDialogReceive(context);
                                    },
                                    icon: Icon(Icons.send, size: 18),
                                    label: Text('Recevoir un extraire'),
                                  ),
                                  SizedBox(width: 20,),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/lecture', arguments: data[0]['id']);
                                    },
                                    icon: Icon(Icons.book_rounded, size: 18),
                                    label: Text('Lire'),
                                  ),
                                  SizedBox(width: 20,),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    ),
                                    onPressed: () {
                                      //Navigator.pushNamed(context, '/lecture');
                                    },
                                    icon: Icon(Icons.audiotrack, size: 18),
                                    label: Text('Ecouter'),
                                  ),
                                ],
                              ),
                              Divider(),
                              /*
                              Text('Laisser un commentaire'),
                              TextField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                minLines: 1,
                                maxLines: 5,
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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

  //AlerteDialog Achat
  _showDialogBuy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text('Acheter'),
            content: Container(
              width: 700,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Entrer votre numero de telephone'),
                    SizedBox(
                      //height: ,
                      //width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.phone_android),
                          hintText: 'Numero de telephone',
                          labelText: 'Numero de telephone',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Suivant', style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        );
      },
    );
  }

  //AlerteDialog Recevoir un extraire
  _showDialogReceive(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text('Recevoir un extraire'),
            content: Container(
              width: 700,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Entrer votre numero addresse email'),
                    SizedBox(
                      //height: ,
                      //width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.email),
                          hintText: 'email',
                          labelText: 'email',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Recevoir', style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        );
      },
    );
  }



}
