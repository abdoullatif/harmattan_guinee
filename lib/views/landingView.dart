import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class LandingView extends StatelessWidget {
  const LandingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandingViewContent(),
    );
  }
}


class LandingViewContent extends StatefulWidget {
  const LandingViewContent({Key key}) : super(key: key);

  @override
  _LandingViewContentState createState() => _LandingViewContentState();
}

class _LandingViewContentState extends State<LandingViewContent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
