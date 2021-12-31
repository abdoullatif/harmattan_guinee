import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeView extends StatefulWidget {
  final int nombre;
  const HomeView(this.nombre, {Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {

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
              Card(
                elevation: 5.0,
                child: Image.asset("assets/logo/logo.png",height: 150,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

