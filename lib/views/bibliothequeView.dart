import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:perspective_pageview/perspective_pageview.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:coverflow/coverflow.dart';

class BibliothequeView extends StatefulWidget {
  const BibliothequeView({Key key}) : super(key: key);

  @override
  _BibliothequeViewState createState() => _BibliothequeViewState();
}

class _BibliothequeViewState extends State<BibliothequeView> {
  @override
  Widget build(BuildContext context) {

    //Horizontale
    List<ImageCarditem > items = [
      ImageCarditem (
        image: Image.asset("assets/images/9782343212760b.jpg"),
      ),
      ImageCarditem (
        image: Image.asset("assets/images/9782343217147b.jpg"),
      ),
      ImageCarditem (
        image: Image.asset("assets/images/9782343223612b.jpg"),
      ),
    ];

    //Books
    final List<String> titles = [
      "Title1",
      "Title2",
      "Title3",
      "Title4",
      "Title5",
      "Title6",
      "Title7",
      "Title8",
    ];

    final List<Widget> images = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.grey,
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.amber,
      ),
    ];
    //Image
    List<Widget> images2 = [
      Image.asset("assets/images/9782343212760b.jpg"),
      Image.asset("assets/images/9782343217147b.jpg"),
      Image.asset("assets/images/9782343222912b.jpg"),
      Image.asset('assets/images/9782343223612b.jpg'),
      Image.asset('assets/images/9782343224459b.jpg'),
      Image.asset('assets/images/9782343224770b.jpg'),
      Image.asset('assets/images/9782343244976b.jpg'),
      Image.asset('assets/images/9782343225166b.jpg'),
    ];

    return Center(
      child: SizedBox(
        child: CoverFlow(
          images: images2,
          titles: titles,
          textStyle: TextStyle(color: Colors.red),
          // displayOnlyCenterTitle: true,
          onCenterItemSelected: (index) {
            print('Selected Item\'s index: $index');
            if(index == 0) Navigator.pushNamed(context, '/resume');
          },
          shadowOpacity: 0.3,
          shadowOffset: Offset(3, 8),
        ),
      ),

      /*
        HorizontalCardPager(
          onPageChanged: (page) => print("page : $page"),
          onSelectedItem: (page) => print("selected : $page"),
          items: items,
        ),
        */

      /*
        PerspectivePageView(
          hasShadow: true, // Enable-Disable Shadow
          shadowColor: Colors.black12, // Change Color
          aspectRatio: PVAspectRatio.ONE_ONE, // Add Aspect Ratio
          children: <Widget>[
            GestureDetector(
              onTap: () {
                debugPrint("Statement One");
              },
              child: Image.asset("assets/images/9782343212760b.jpg"),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343217147b.jpg",height: 400,),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343222912b.jpg"),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343223612b.jpg"),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343224459b.jpg"),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343224770b.jpg"),
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Statement Two");
              },
              child: Image.asset("assets/images/9782343225166b.jpg"),
            ),
          ],

        ),
        */

      /*
        ListWheelScrollView(
          //scrollDirection: Axis.horizontal,
          itemExtent: 700,
          // diameterRatio: 1.6,
          // offAxisFraction: -0.4,
          // squeeze: 0.8,
          // clipToSize: true,
          children: <Widget>[
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
            InkWell(
              onTap:null ,
              child: Column(
                children: [
                  Image.asset("assets/images/9782343212760b.jpg"),
                  Text("Item 1",textAlign:TextAlign.start,
                    style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
                  )
                ],
              ),
            ) ,
          ],
        ),*/

      /*
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        */
    );
  }
}
