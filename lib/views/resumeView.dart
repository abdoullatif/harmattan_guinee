import 'dart:io';
import 'dart:typed_data';

import 'package:Harmattan_guinee/model/audio.dart';
import 'package:Harmattan_guinee/model/livre.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                                        _showDialogReceive(context,data[0]['titre'],data[0]['extraire']);
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
                                    FutureBuilder(
                                      future: Livre.SelectWhere(int.parse(data[0]['id'])),
                                      builder: (context, AsyncSnapshot snapshot){

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.connectionState == ConnectionState.done) {

                                          if (snapshot.hasError) {
                                            return const Text('Error');
                                          } else if (snapshot.hasData) {

                                            List<Map<String, dynamic>> livreExist = snapshot.data;
                                            //
                                            return livreExist.isNotEmpty ?
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
                                            ) : Container();

                                          } else {
                                            return const Text('Empty data');
                                          }

                                        } else {
                                          return Text('State: ${snapshot.connectionState}');
                                        }

                                      },
                                    ),
                                    SizedBox(width: 20,),
                                    FutureBuilder(
                                      future: Audio.SelectWhere(int.parse(data[0]['id'])),
                                      builder: (context, AsyncSnapshot snapshot){

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.connectionState == ConnectionState.done) {

                                          if (snapshot.hasError) {
                                            return const Text('Error');
                                          } else if (snapshot.hasData) {

                                            List<Map<String, dynamic>> AudioExist = snapshot.data;
                                            //
                                            return AudioExist.isNotEmpty ?
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                              ),
                                              onPressed: () {
                                                //Navigator.pushNamed(context, '/lecture');
                                                _showAudioPlayer(context,data[0]['titre'], AudioExist[0]['contenue_audio']);
                                              },
                                              icon: Icon(Icons.volume_mute_rounded, size: 35),
                                              label: Text(
                                                'Ecouter',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 21,
                                                ),
                                              ),
                                            ) : Container();

                                          } else {
                                            return const Text('Empty data');
                                          }

                                        } else {
                                          return Text('State: ${snapshot.connectionState}');
                                        }

                                      },
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

  //
  StateSetter _setState;

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
                    //Text('Entrer votre numero de telephone'),
                    SizedBox(
                      //height: ,
                      //width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.phone_android),
                          hintText: 'Numero de telephone',
                          labelText: 'Entrer votre numero de telephone',
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
  _showDialogReceive(BuildContext context, String titre, String extraire) {
    //
    final _formKey = GlobalKey<FormState>();

    TextEditingController _email = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        //
        return Container(
          child: AlertDialog(
            title: Text('Recevoir un extraire'),
            content: Container(
              width: 700,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //Text('Entrer votre numero addresse email'),
                      SizedBox(
                        //height: ,
                        //width: 500,
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.email),
                            hintText: 'email',
                            labelText: 'Adresse E-mail',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuiller entrer une adresse mail valide';
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
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState.validate()) {
                    //
                    final Email email = Email(
                      body: 'Voici-ci join un extraire en pdf du livre ${titre.replaceAll('_', ' ')} ',
                      subject: 'Extraire du livre ${titre.replaceAll('_', ' ')}',
                      recipients: [_email.text],
                      //cc: ['cc@example.com'],
                      //bcc: ['bcc@example.com'],
                      attachmentPaths: ['/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/$titre/$extraire'],
                      isHTML: false,
                    );

                    String platformResponse;

                    try {
                      await FlutterEmailSender.send(email);
                      platformResponse = 'success';

                      Fluttertoast.showToast(
                          msg: "Email envoyer avec succes !", //Présence enregistrée,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                    } catch (error) {
                      platformResponse = error.toString();
                    }

                    Navigator.of(context).pop();

                  }

                },
                child: Text('Recevoir l\'extraire ', style: Theme.of(context).textTheme.button,),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Annuler', style: Theme.of(context).textTheme.button,),
              ),
            ],
          ),
        );
      },
    );
  }

  //AlerteDialog Audio Player
  _showAudioPlayer(BuildContext context, String folder, String audio) {

    //

    int maxduration = 100;
    int currentpos = 0;
    String currentpostlabel = "00:00";
    String audioasset = "assets/audio/red-music.mp3";
    final audiofile = File('/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/$folder/$audio');
    bool isplaying = false;
    bool audioplayed = false;
    Uint8List audiobytes; // late

    AudioPlayer player = AudioPlayer();

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Container(
          child: AlertDialog(
            title: Text('Lecture'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                //
                _setState = setState;

                //fonction
                Future.delayed(Duration.zero, () async {

                  //ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
                  //audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
                  //convert ByteData to Uint8List

                  player.onDurationChanged.listen((Duration d) { //get the duration of audio
                    maxduration = d.inMilliseconds;
                    _setState(() {

                    });
                  });

                  player.onAudioPositionChanged.listen((Duration  p){
                    currentpos = p.inMilliseconds; //get the current position of playing audio

                    //generating the duration label
                    int shours = Duration(milliseconds:currentpos).inHours;
                    int sminutes = Duration(milliseconds:currentpos).inMinutes;
                    int sseconds = Duration(milliseconds:currentpos).inSeconds;

                    int rhours = shours;
                    int rminutes = sminutes - (shours * 60);
                    int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

                    currentpostlabel = "$rhours:$rminutes:$rseconds";

                    _setState(() {
                      //refresh the UI
                    });
                  });

                });


                return Container(
                  width: 700,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Text(''),
                        Container(
                            margin: EdgeInsets.only(top:50),
                            child: Column(
                              children: [

                                Container(
                                  child: Text(currentpostlabel, style: TextStyle(fontSize: 25),),
                                ),

                                Container(
                                    child: Slider(
                                      value: double.parse(currentpos.toString()),
                                      min: 0,
                                      max: double.parse(maxduration.toString()),
                                      divisions: maxduration,
                                      label: currentpostlabel,
                                      onChanged: (double value) async {
                                        int seekval = value.round();
                                        int result = await player.seek(Duration(milliseconds: seekval));
                                        if(result == 1){ //seek successful
                                          currentpos = seekval;
                                        }else{
                                          print("Seek unsuccessful.");
                                        }
                                      },
                                    )
                                ),

                                Container(
                                  child: Wrap(
                                    spacing: 10,
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () async {
                                            if(!isplaying && !audioplayed){
                                              int result = await player.play(audiofile.path,isLocal: true);
                                              if(result == 1){ //play success
                                                _setState(() {
                                                  isplaying = true;
                                                  audioplayed = true;
                                                });
                                              }else{
                                                print("Error while playing audio.");
                                              }
                                            }else if(audioplayed && !isplaying){
                                              int result = await player.resume();
                                              if(result == 1){ //resume success
                                                _setState(() {
                                                  isplaying = true;
                                                  audioplayed = true;
                                                });
                                              }else{
                                                print("Error on resume audio.");
                                              }
                                            }else{
                                              int result = await player.pause();
                                              if(result == 1){ //pause success
                                                _setState(() {
                                                  isplaying = false;
                                                });
                                              }else{
                                                print("Error on pause audio.");
                                              }
                                            }
                                          },
                                          icon: Icon(isplaying?Icons.pause:Icons.play_arrow),
                                          label:Text(isplaying?"Pause":"Play")
                                      ),

                                      ElevatedButton.icon(
                                          onPressed: () async {
                                            int result = await player.stop();
                                            if(result == 1){ //stop success
                                              _setState(() {
                                                isplaying = false;
                                                audioplayed = false;
                                                currentpos = 0;
                                                currentpostlabel = "00:00";
                                              });
                                            }else{
                                              print("Error on stop audio.");
                                            }
                                          },
                                          icon: Icon(Icons.stop),
                                          label:Text("Stop")
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            )

                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () async{
                  int result = await player.stop();
                  if(result == 1){ //stop success
                    _setState(() {
                      isplaying = false;
                      audioplayed = false;
                      currentpos = 0;
                      currentpostlabel = "00:00";
                    });
                  }else{
                    print("Error on stop audio.");
                  }
                  Navigator.of(context).pop();
                },
                label: Text('QUITTER', style: TextStyle(color: Colors.white),),
                icon: Icon(Icons.exit_to_app, size: 35,),
              ),
            ],
          ),
        );
      },
    ).then((exit) async{
      if (exit == null) {

        int result = await player.stop();
        if(result == 1){ //stop success
          _setState(() {
            isplaying = false;
            audioplayed = false;
            currentpos = 0;
            currentpostlabel = "00:00";
          });
        }else{
          print("Error on stop audio.");
        }
        return;

      }

      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }



}







/*

other plug : just_audio 0.9.18


hint
*
FutureBuilder(
                                      future: ,
                                      builder: (context, AsyncSnapshot snapshot){

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.connectionState == ConnectionState.done) {

                                          if (snapshot.hasError) {
                                            return const Text('Error');
                                          } else if (snapshot.hasData) {

                                            //
                                            return ;

                                          } else {
                                            return const Text('Empty data');
                                          }

                                        } else {
                                          return Text('State: ${snapshot.connectionState}');
                                        }

                                      },
                                    ),
* */
