import 'package:Harmattan_guinee/views/landingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class LandingController extends StatelessWidget {
  const LandingController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandingView(),
    );
  }
}