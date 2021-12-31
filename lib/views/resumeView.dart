import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


class ResumeView extends StatefulWidget {
  const ResumeView({Key key}) : super(key: key);

  @override
  _ResumeViewState createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30,right: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset("assets/images/9782343212760b.jpg"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Une jeunesse a l\'ombre',
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
                                          Text("Cet essai restitue l'enfance, l'adolescence et la vie adulte du bouillant capitaine "
                                              "Moussa Dadis Camara. La violence des combats, les ruses visant à sauver la vie du "
                                              "président Dadis, les méditations silencieuses et douloureuses de ce dernier "
                                              "après le massacre du stade du 28 septembre sont relatées sans bienveillance, "
                                              "mais sans rancoeur non plus... Plus qu'un récit, cet ouvrage est aussi un essai "
                                              "sur l'histoire récente de la Guinée."),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 30,),
                                          Text("Natif de Conakry, Yamoussa Sidibé a fait des études de lettres modernes"
                                              " à l'École normale supérieure de Manéa, près de Conakry. Sa passion pour "
                                              "le journalisme le conduira très tôt sur le parvis de la RTG, la "
                                              "Radiodiffusion-Télévision guinéenne, dont il gravira tous les échelons "
                                              "avant d'en devenir directeur général de 2013 à 2017."),
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
                              Navigator.pushNamed(context, '/lecture');
                            },
                            icon: Icon(Icons.book_rounded, size: 18),
                            label: Text('Lire un extraire'),
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
                            label: Text('Ecouter un extraire'),
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
