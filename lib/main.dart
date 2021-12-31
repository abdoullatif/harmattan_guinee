import 'package:Harmattan_guinee/controller/bibliothequeController.dart';
import 'package:Harmattan_guinee/controller/lectureController.dart';
import 'package:Harmattan_guinee/controller/resumeController.dart';
import 'package:Harmattan_guinee/controller/slidehomeController.dart';
import 'package:Harmattan_guinee/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'controller/homeController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harmattan Guinee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Harmattan guinee app'),
      initialRoute: '/',
      routes: {
        '/': (context) => const SliderhomeController(),
        '/home': (context) => const HomeController(),
        '/themes': (context) => const ThemeController(),
        '/biblioteque': (context) => const BibliothequeController(),
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