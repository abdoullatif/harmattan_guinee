import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ResumeView extends StatefulWidget {
  const ResumeView({Key key}) : super(key: key);

  @override
  _ResumeViewState createState() => _ResumeViewState();
}

class _ResumeViewState extends State<ResumeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100,right: 100),
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Text('Une jeunesse a l\'ombre'),
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
                          ElevatedButton(
                            style: ButtonStyle(
                              //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () { },
                            child: Text('Acheter'),
                          ),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            style: ButtonStyle(
                              //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () { },
                            child: Text('Recevoir un extraire'),
                          ),
                          SizedBox(width: 20,),
                          ElevatedButton(
                            style: ButtonStyle(
                              //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () { },
                            child: Text('Lire'),
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
}
