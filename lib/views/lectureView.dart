import 'dart:async';
import 'dart:io';

import 'package:Harmattan_guinee/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';


import 'package:page_turn/page_turn.dart';



class LectureView extends StatefulWidget {
  final page;

  const LectureView(this.page, {Key key}) : super(key: key);

  @override
  _LectureViewState createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> with WidgetsBindingObserver {
  //final _controller = GlobalKey<PageTurnState>();

  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";

  @override
  void initState() {
    /*
    super.initState();
    fromAsset('assets/corrupted.pdf', 'corrupted.pdf').then((f) {
      setState(() {
        corruptedPathPDF = f.path;
      });
    });
    fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
    fromAsset('assets/demo-landscape.pdf', 'landscape.pdf').then((f) {
      setState(() {
        landscapePathPdf = f.path;
      });
    });

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
    */
  }

  //Fonction
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }


  bool isReady = false;
  String errorMessage = '';
  //
  bool light = box.get('currentTheme');

  //fonction
  setLightorDark () {
    setState(() {
      //
      print(light);
      light = !light;
      //box.put('currentTheme', light);
      print(light);
    });
  }


  @override
  Widget build(BuildContext context) {
    //
    final Completer<PDFViewController> _controller =
    Completer<PDFViewController>();
    int pages = 0;
    int currentPage = 0;

    //


    return FutureBuilder(
      future: widget.page,
      builder: (context, AsyncSnapshot snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.connectionState == ConnectionState.done) {

        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          //
          var data = snapshot.data;


          return Stack(
            children: <Widget>[
              PDFView(
                filePath: "/storage/emulated/0/Android/data/com.tulipindustries.Harmattan_guinee/files/uploads/livres/${data[0]['titre']}/${data[0]['page_livre']}",
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                defaultPage: currentPage,
                fitPolicy: FitPolicy.BOTH,
                nightMode: light,
                preventLinkNavigation:
                false, // if set to true the link is handled in flutter
                onRender: (_pages) {
                  setState(() {
                    pages = _pages;
                    isReady = true;
                  });
                },
                onError: (error) {
                  setState(() {
                    errorMessage = error.toString();
                  });
                  print(error.toString());
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage = '$page: ${error.toString()}';
                  });
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onLinkHandler: (String uri) {
                  print('goto uri: $uri');
                },
                onPageChanged: (int page, int total) {
                  print('page change: $page/$total');
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
              errorMessage.isEmpty? !isReady
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Container()
                  : Center(
                child: Text(errorMessage),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                //bottom: 2,
                child: FloatingActionButton.extended(
                  label: Text('Changer de mode'),
                  icon: Icon(Icons.brightness_6_rounded, size: 35,),
                  backgroundColor: Theme.of(context).backgroundColor,
                  onPressed: (){
                    //
                    setLightorDark();
                  },
                  heroTag: null,
                ),
              ),
            ],
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
}

