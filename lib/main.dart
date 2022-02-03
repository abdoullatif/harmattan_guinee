import 'dart:io';
import 'package:Harmattan_guinee/controller/bibliothequeController.dart';
import 'package:Harmattan_guinee/controller/lectureController.dart';
import 'package:Harmattan_guinee/controller/resumeController.dart';
import 'package:Harmattan_guinee/controller/slidehomeController.dart';
import 'package:Harmattan_guinee/controller/themeController.dart';
import 'package:Harmattan_guinee/synchro/synchro_by_sooba_inspire_by_alimou_washington.dart';
import 'package:Harmattan_guinee/utils/config.dart';
import 'package:Harmattan_guinee/utils/parametre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'controller/bibliothequeAudioController.dart';
import 'controller/homeController.dart';
import 'databases/sqflite_db.dart';

//globale var
var synchronisation;

//bad certificate correction
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //bad certificat
  HttpOverrides.global = new MyHttpOverrides();
  var path = Directory.current.path;
  //Init db
  await DB.init();
  await Parametre.createFolder();
  //Hive.init(path);
  //DB local parametre
  List<Map<String, dynamic>> tab = await DB.querySelect("parametre");
  if(tab.isNotEmpty){
    //send data for init synchronisation
    synchronisation = Synchro("/data/user/0/com.tulipindustries.Harmattan_guinee/databasesharmattan",
        "/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/"
        ,"uploads",tab[0]['user'],tab[0]['mdp'],tab[0]['dbname'],tab[0]['ip_server'],tab[0]['adresse_server']);
    synchronisation.synchronize();
  }
  //Orientation Paysage
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTheme.addListener(() {
      print('change');
      setState(() {
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harmattan Guinee',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      /*
      ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      */
      //home: MyHomePage(title: 'Harmattan guinee app'),
      initialRoute: '/',
      routes: {
        '/': (context) => const SliderhomeController(),
        '/home': (context) => const HomeController(),
        '/themes': (context) => const ThemeController(),
        '/biblioteque': (context) => const BibliothequeController(),
        '/bibliotequeAudio': (context) => const BibliothequeAudioController(),
        '/resume': (context) => const ResumeController(),
        '/lecture': (context) => const LectureController(),
      },
    );
  }
}





/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return SliderhomeController();
  }
}
*/