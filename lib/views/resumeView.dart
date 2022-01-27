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

            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                      BlendMode.dstATop),
                  image: AssetImage("assets/background/planche.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 30,right: 30, top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            //height: 800,
                            child: Image.file(
                              File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[0]['titre']}/${data[0]['couverture_livre']}"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            padding: EdgeInsets.all(15.0),
                            decoration: new BoxDecoration(
                              border: new Border.all(width: 4.0 ,color: Colors.transparent), //color is transparent so that it does not blend with the actual color specified
                              borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
                              color: new Color.fromRGBO(255, 255, 255, 0.6), // Specifies the background color and the opacity
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Titre: ${data[0]['titre'].replaceAll('_',' ')}',
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
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
                                            labelStyle: TextStyle(
                                              fontSize: 22.0,
                                              fontFamily: 'Family Name',
                                              fontWeight: FontWeight.w900,
                                            ),
                                            indicatorColor: Colors.blue,
                                            unselectedLabelColor: Colors.black38,
                                            labelColor: Colors.blue,

                                            tabs: [
                                              Tab(
                                                text: "Resume",
                                                //icon: Icon(Icons.book_rounded),
                                              ),
                                              Tab(
                                                text: "Biographie de l'auteur",
                                              ),
                                            ]
                                        ),
                                      ),
                                      Container(
                                        //Add this to give height
                                        height: MediaQuery.of(context).size.height /2.9,
                                        child: TabBarView(
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 30,),
                                                    Text(
                                                      "${data[0]['resume_livre']}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 21,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 30,),
                                                    Text(
                                                      "${data[0]['biographie_auteur']}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 21,
                                                      ),
                                                    ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      ),
                                      onPressed: () {
                                        _showDialogBuy(context);
                                      },
                                      icon: Icon(Icons.shopping_cart, size: 35),
                                      label: Text(
                                        'Acheter',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      ),
                                      onPressed: () {
                                        _showDialogReceive(context);
                                      },
                                      icon: Icon(Icons.share, size: 35),
                                      label: Text(
                                        'Recevoir',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/lecture', arguments: data[0]['id']);
                                      },
                                      icon: Icon(Icons.book_rounded, size: 35),
                                      label: Text(
                                        'Lire',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    ElevatedButton.icon(
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
