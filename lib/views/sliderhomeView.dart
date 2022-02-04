import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderhomeView extends StatefulWidget {
  const SliderhomeView({Key key}) : super(key: key);

  @override
  _SliderhomeViewState createState() => _SliderhomeViewState();
}

class _SliderhomeViewState extends State<SliderhomeView> {

  //image slider
  final List<String> imgList = [
    //'assets/slider/banner1.png',
    //'assets/slider/banner2.png',
    'assets/slider/banner3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: MediaQuery.of(context).size.height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlayInterval: const Duration(seconds: 60),
        //aspectRatio: 16/9,
      ),
      items: imgList.map((item) => Container(
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/home');
          },
          child: Center(
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      )).toList(),
    );
  }
}
