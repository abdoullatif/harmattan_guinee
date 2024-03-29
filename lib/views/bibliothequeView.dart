import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:coverflow/coverflow.dart';
import 'package:lottie/lottie.dart';

import 'package:perspective_pageview/perspective_pageview.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';


class BibliothequeView extends StatefulWidget {
  //variable
  final livreThematique;

  const BibliothequeView(this.livreThematique, {Key key}) : super(key: key);

  @override
  _BibliothequeViewState createState() => _BibliothequeViewState();
}

class _BibliothequeViewState extends State<BibliothequeView> {
  @override
  Widget build(BuildContext context) {
    //widget variable
    List<Widget> couvertureLivre = [];
    List<String> titre = [];
    String nom_livre;

    return FutureBuilder(
        future: widget.livreThematique,
        builder: (context, AsyncSnapshot snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {

            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {

              List<Map<String, dynamic>> data = snapshot.data;

              //print(data);

              for(int i = 0; i < data.length; i++){
                //start
                couvertureLivre.add(
                    Image.file(
                      File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[i]['titre']}/${data[i]['couverture_livre']}"),
                    ),
                );
                titre.add(data[i]['titre'].replaceAll('_',' '));
                //end boucle
              }

              //Image
              List<Widget> images2 = [
                Image.asset("assets/images/9782343212760b.jpg"),
                Image.asset("assets/images/9782343217147b.jpg"),
              ];

              //Books
              final List<String> titles = [
                "Title1",
                "Title2",
              ];

              return data.isNotEmpty ?
                Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                        BlendMode.dstATop),
                    image: AssetImage("assets/background/planche.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    child: CoverFlow(
                      images: couvertureLivre,
                      titles: titre,
                      textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,backgroundColor: Colors.white,height: 15,),
                      displayOnlyCenterTitle: true,
                      onCenterItemSelected: (index) {
                        //print('Selected Item\'s index: $index');
                        nom_livre = titre.elementAt(index);
                        Navigator.pushNamed(context, '/resume', arguments: nom_livre.replaceAll(' ','_'));
                      },
                      shadowOpacity: 0.3,
                      shadowOffset: Offset(3, 8),
                    ),
                  ),

                ),
              ) :
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1),
                        BlendMode.dstATop),
                    image: AssetImage("assets/background/planche.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Oups, il n\'y a pas de livre dans cette thématique, Désolé !',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 10,),
                        Lottie.asset(
                          'assets/lotties/astronaut.json',
                          width: 500,
                          height: 500,
                          fit: BoxFit.fill,
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

        }

    );
  }
}
