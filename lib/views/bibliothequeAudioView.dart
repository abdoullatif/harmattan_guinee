import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volume_control/volume_control.dart';


class BibliotequeAudioView extends StatefulWidget {
  final livreAudio;
  const BibliotequeAudioView(this.livreAudio, {Key key}) : super(key: key);

  @override
  _BibliotequeAudioViewState createState() => _BibliotequeAudioViewState();
}

class _BibliotequeAudioViewState extends State<BibliotequeAudioView> {

  //
  List queryAudio;
  List queryAudioSaved;
  bool exist=false;

  //Fonction
  Future<List<Map<String, dynamic>>> getAudio () async {
    if(!exist) {
      queryAudio = await widget.livreAudio;
      queryAudioSaved = queryAudio;
      exist = true;
    }
    return queryAudio;
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(/*
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1),
                BlendMode.dstATop),
            image: AssetImage("assets/background/planche.png"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Livre audio',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 20,),
                SizedBox(
                  //height: ,
                  width: 500,
                  child: TextField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.search),
                      hintText: 'Entrer votre votre recherche',
                      labelText: 'Recherche',
                    ),
                    onChanged: (text) {
                      //
                      setState(() {
                        text = text.toLowerCase();
                        queryAudio = queryAudioSaved;
                        queryAudio = queryAudio.where((element) {

                          var titre = element["titre"].replaceAll('_',' ').toLowerCase();

                          //print(titre.contains(text));
                          return titre.contains(text);

                        }).toList();
                      });
                      //
                    },
                  ),
                ),
                SizedBox(height: 10,),
                FutureBuilder(
                  future: getAudio(),
                  builder: (context, AsyncSnapshot snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState == ConnectionState.done) {

                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        //
                        List<Map<String, dynamic>> data = snapshot.data;
                        int n = data.length;

                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: ListView.builder(
                            itemCount: n,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5.0,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 160, // MediaQuery.of(context).size.width / 6
                                      child: Image.file(
                                        File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[index]['titre']}/${data[index]['couverture_livre']}"),
                                        //width: 200,
                                        height: 200,
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 1.6, // MediaQuery.of(context).size.width / 2
                                      child: Column(
                                        children: [
                                          Text(
                                            "${data[index]['titre'].replaceAll('_',' ')}",
                                            textAlign: TextAlign.left,
                                            //textDirection: TextDirection.rtl,
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          Text(
                                            "${data[index]['resume_livre']} ...",
                                            maxLines: 5,
                                            textAlign: TextAlign.left,
                                            textDirection: TextDirection.rtl,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 8, //MediaQuery.of(context).size.width / 8
                                      child: ElevatedButton.icon(
                                        style: ButtonStyle(
                                          //foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        ),
                                        onPressed: () {
                                          //Navigator.pushNamed(context, '/lecture');
                                          _showAudioPlayer(context,data[index]['titre'],data[index]['contenue_audio'], data[index]['couverture_livre']);
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
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );

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
          ),
        ),
      ),
    );

  }

  //
  StateSetter _setState;

  //AlerteDialog Audio Player
  _showAudioPlayer(BuildContext context, String folder, String audio, String couverture) {

    //
    double _val = 0.5; //
    Timer timer;

    //init volume_control plugin
    Future<void> initVolumeState() async {
      if (!mounted) return;

      //read the current volume
      _val = await VolumeControl.volume;
      setState(() {
      });
    }

    @override
    void initState() {
      super.initState();
      initVolumeState();
    }

    int maxduration = 100;
    int currentpos = 0;
    String currentpostlabel = "00:00";
    //String audioasset = "assets/audio/red-music.mp3";
    final audiofile = File('/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/$folder/$audio');
    bool isplaying = false;
    bool audioplayed = false;
    //Uint8List audiobytes; // late

    AudioPlayer player = AudioPlayer();

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Container(
          child: AlertDialog(
            title: Text('Lecture audio du livre'),
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

                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 3,
                                  child: Image.file(File("/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/$folder/$couverture")),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  child: Text(currentpostlabel, style: TextStyle(fontSize: 25),),
                                ),

                                Container(
                                    child: Slider(
                                      value: double.parse(currentpos.toString()),
                                      min: 0,
                                      max: double.parse(maxduration.toString()) + 1.0,
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
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "Volume",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),

                                //Volume
                                Slider(value:_val,min:0,max:1,divisions: 100,onChanged:(val){
                                  _val = val;
                                  setState(() {});
                                  if (timer!=null){
                                    timer?.cancel();
                                  }

                                  //use timer for the smoother sliding
                                  timer = Timer(Duration(milliseconds: 200), (){VolumeControl.setVolume(val);});

                                  print("val:$val");
                                }),

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
