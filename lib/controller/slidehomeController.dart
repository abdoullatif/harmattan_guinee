import 'package:Harmattan_guinee/views/sliderhomeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SliderhomeController extends StatelessWidget {
  const SliderhomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderhomeView(),
    );
  }
}
