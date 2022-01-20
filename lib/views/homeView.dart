import 'dart:io';

import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatefulWidget {
  //variable
  final int nombre;

  const HomeView(this.nombre, {Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {



  @override
  Widget build(BuildContext context) {
    // init
    int lastTap = DateTime.now().millisecondsSinceEpoch;
    int consecutiveTaps = 0;
    //print(widget.nombre);
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 130, right: 130),
          child: Column(
            children: [
              SizedBox(height: 100,),
              GridView.count(
                shrinkWrap: true,
                //primary: false,
                //padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    elevation: 10,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/themes', arguments: 'Tous les livres');
                      },
                      child: Image.asset("assets/home/all_livre.png"),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/biblioteque');
                      },
                      child: Image.asset("assets/home/livre_promo.png"),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, '/livreAudio');
                        Navigator.pushNamed(context, '/themes', arguments: 'Livres audio');
                      },
                      child: Image.asset("assets/home/livre_audio.png"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              InkWell(
                onTap: (){
                  int now = DateTime.now().millisecondsSinceEpoch;
                  if (now - lastTap < 1000) {
                    //print("Consecutive tap");
                    consecutiveTaps ++;
                    //print("taps = " + consecutiveTaps.toString());
                    if (consecutiveTaps > 4){
                      // Do something
                      _showDialogLogin(context);
                    }
                  } else {
                    consecutiveTaps = 0;
                  }
                  lastTap = now;
                },
                child: Card(
                  elevation: 5.0,
                  child: Image.asset("assets/logo/logo.png",height: 150,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Alerte Login
  _showDialogLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //variable
        final _formKey = GlobalKey<FormState>();
        //
        TextEditingController _email = TextEditingController();
        TextEditingController _password = TextEditingController();
        //
        return Container(
          child: AlertDialog(
            title: Text('Panneaux de configuration'),
            content: Container(
              width: 700,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Login'),
                      SizedBox(
                        //height: ,
                        //width: 500,
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.email),
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              print(value);
                              return 'Veuiller entrer l\'email ';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        //height: ,
                        //width: 500,
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.vpn_key_sharp),
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              print(value);
                              return 'Veuiller entrer le mot de passe';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {

                  //validate
                  if (_formKey.currentState.validate()) {
                    if(_email.text == "admin" && _password.text == "aze"){
                      Navigator.of(context).pop();
                      _showDialogParameter(context);
                      //toast
                      Fluttertoast.showToast(
                          msg: "Connecte", //Présence enregistrée,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      //toast
                      Fluttertoast.showToast(
                          msg: "Erreur de login !", //Présence enregistrée,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                  }

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

  //
  StateSetter _setState;

  //Alerte parameter
  _showDialogParameter(BuildContext context) {

    //variable
    final _formKey = GlobalKey<FormState>();
    //textbox
    //TextEditingController _locate = TextEditingController();
    TextEditingController _device = TextEditingController();
    TextEditingController _adresse_server = TextEditingController();
    TextEditingController _ip_server = TextEditingController();
    //TextEditingController _site_pdaig = TextEditingController();
    TextEditingController _user = TextEditingController();
    TextEditingController _mdp = TextEditingController();
    TextEditingController _dbname = TextEditingController();
    //-------------------------------------------------------------------------------------
    getParam() async {
      List<Map<String, dynamic>> tab = await DB.querySelect("parametre");
      if(tab.isNotEmpty){
        _setState(() {
          _device = TextEditingController(text: tab[0]['device']);
          _adresse_server = TextEditingController(text: tab[0]['adresse_server']);
          _dbname = TextEditingController(text: tab[0]['dbname']);
          _ip_server = TextEditingController(text: tab[0]['ip_server']);
          //_site_harmattan = TextEditingController(text: tab[0]['site_harmattan']);
          _user = TextEditingController(text: tab[0]['user']);
          _mdp = TextEditingController(text: tab[0]['mdp']);
        });
      }
    }
    getParam();
    //-------------------------------------------------------------------------------------
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Panneaux de configuration'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                //
                _setState = setState;
                return Container(
                  width: 700,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              //color: Colors.indigo,
                                margin: EdgeInsets.only(bottom: 30.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 30.0,
                                    child: ElevatedButton.icon(
                                      onPressed: () async{
                                        var confirm = await showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                title: Text("ATTENTION"),
                                                content: Text('Voulez vous vraiment videz la base de donnée de la tablette ?', style: TextStyle(color: Colors.red),),
                                                actions: [
                                                  ElevatedButton(
                                                    child: Text('NON'),
                                                    onPressed: (){
                                                      Navigator.of(context).pop('non');
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    child: Text('Oui'),
                                                    onPressed: (){
                                                      Navigator.of(context).pop('oui');
                                                    },
                                                  ),
                                                ],
                                              );
                                            }
                                        );
                                        //troncate data
                                        if (confirm == "oui") {

                                          //Delect all dossier in database

                                          List<Map<String, dynamic>> queryLivre = await DB.querySelect("livre");

                                          if(queryLivre.isNotEmpty){
                                            for (int i = 0; i < queryLivre.length; i++){
                                              File folder = File('/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/${queryLivre[i]["titre"]}');
                                              await folder.delete();
                                            }
                                          }

                                          // Exepte Media
                                          DB.troncateTable("users"); //table
                                          DB.troncateTable("theme"); //table
                                          DB.troncateTable("livre"); //table
                                          DB.troncateTable("audio"); //table
                                          DB.troncateTable("page"); //table

                                          //Toaste
                                          Fluttertoast.showToast(
                                              msg: "La base de donnée a été nottoyer avec succès ! ",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );

                                        }

                                      },
                                      icon: Icon(Icons.clear, size: 18),
                                      label: Text("Reset Data", textAlign: TextAlign.center,),
                                    ),
                                    //Text("Parametre", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),),
                                  ),
                                )
                            ),
                            TextFormField(
                              obscureText: false,
                              controller: _device,
                              decoration: InputDecoration(
                                icon: Icon(Icons.tablet, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Identifiant de la tablette",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  print(value);
                                  return 'Veuiller entrer le nom de la tablette';
                                }
                                return null;
                              },
                            ),
                            //SizedBox(height: 25.0),
                            SizedBox(height: 25.0),
                            TextFormField(
                              obscureText: false,
                              controller: _adresse_server,
                              decoration: InputDecoration(
                                icon: Icon(Icons.vpn_lock, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Adresse DNS du server",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuiller entrer l\'Adresse DNS du server';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.0),
                            TextFormField(
                              obscureText: false,
                              controller: _dbname,
                              decoration: InputDecoration(
                                icon: Icon(Icons.vpn_lock, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Nom de la base de donnee",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuiller entrer l\'Adresse DNS du server';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.0),
                            TextFormField(
                              obscureText: false,
                              controller: _ip_server,
                              decoration: InputDecoration(
                                icon: Icon(Icons.settings, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Adresse ip du server",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuiller entrer l\'Adresse ip du server';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.0),
                            /*
                              TextFormField(
                                obscureText: false,
                                controller: _site_pdaig,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.web, color: Colors.blue),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintText: "Site web officiel de l'harmattan",
                                  //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Veuiller le site officiel de l\'harmattan';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.0),
                               */
                            TextFormField(
                              obscureText: false,
                              controller: _user,
                              decoration: InputDecoration(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Nom utlilisateur server",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuiller entrer le Nom utlilisateur server';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.0),
                            TextFormField(
                              obscureText: false,
                              controller: _mdp,
                              decoration: InputDecoration(
                                icon: Icon(Icons.security, color: Colors.blue),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Mot de passe Utilisateur-server",
                                //border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, width: 1.0)),
                              ),
                              /*
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Veuiller entrer le Mot de passe Utilisateur-server';
                                }
                                return null;
                              },
                              */
                            ),
                            SizedBox(height: 25.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),

          actions: [
            ElevatedButton.icon(
              //minWidth: MediaQuery.of(context).size.width,
              //padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () async{
                if (_formKey.currentState.validate()) {
                  //Verification
                  List<Map<String, dynamic>> tab = await DB.querySelect("parametre");
                  if(tab.isNotEmpty){
                    //On modifie les informations present
                    await DB.updateTable("parametre", {
                      "device": _device.text,
                      //"locate": "",
                      "dbname": _dbname.text,
                      "mdp": _mdp.text,
                      "adresse_server": _adresse_server.text,
                      "ip_server": _ip_server.text,
                      //"site_harmattan": _site_pdaig.text,
                      "user": _user.text,
                    },tab[0]['id']);

                    //toast
                    Fluttertoast.showToast(
                        msg: "Modification effectuer avec succes !", //Présence enregistrée,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                  } else {
                    // insertion du nom de la tablette
                    await DB.insert("parametre", {
                      "device": _device.text,
                      //"locate": "",
                      "adresse_server": _adresse_server.text,
                      "dbname": _dbname.text,
                      "ip_server": _ip_server.text,
                      //"site_harmattan": _site_pdaig.text,
                      "user": _user.text,
                      "mdp": _mdp.text,
                    });

                    //toast
                    Fluttertoast.showToast(
                        msg: "Enregistrement effectuer avec succes !", //Présence enregistrée,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                  }
                }
              },
              icon: Icon(Icons.save, size: 18),
              label: Text("Enregistrer", textAlign: TextAlign.center,),
            ),
            ElevatedButton.icon(
              onPressed: () async{
                _setState(() {
                  _device = TextEditingController(text: '');
                  _adresse_server = TextEditingController(text: '');
                  _dbname = TextEditingController(text: '');
                  _ip_server = TextEditingController(text: '');
                  //_site_harmattan = TextEditingController(text: '');
                  _user = TextEditingController(text: '');
                  _mdp = TextEditingController(text: '');
                });
              },
              icon: Icon(Icons.clear, size: 18),
              label: Text("Clear", textAlign: TextAlign.center,),
            ),
            /*
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Enregistrer', style: TextStyle(color: Colors.black),),
              ),*/
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Quitter', style: TextStyle(color: Colors.black),),
            ),
          ],
        );
      },
    );
  }


}

