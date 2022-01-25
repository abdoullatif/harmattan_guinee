import 'dart:async';
import 'dart:io';

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


  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';



  @override
  Widget build(BuildContext context) {
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
              )
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



//////////////////////////////////////////////////////////

class AlicePage extends StatelessWidget {
  final int page;

  const AlicePage({Key key, this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: 16.0),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "CHAPTER $page",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Down the Rabbit-Hole",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                        "Alice was beginning to get very tired of sitting by her sister on the bank, and of"
                            " having nothing to do: once or twice she had peeped into the book her sister was "
                            "reading, but it had no pictures or conversations in it, `and what is the use of "
                            "a book,' thought Alice `without pictures or conversation?'"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0),
                    color: Colors.black26,
                    width: 160.0,
                    height: 220.0,
                    child: Placeholder(),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                "So she was considering in her own mind (as well as she could, for the hot day made her "
                    "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
                    "worth the trouble of getting up and picking the daisies, when suddenly a White "
                    "Rabbit with pink eyes ran close by her.\n"
                    "\n"
                    "There was nothing so very remarkable in that; nor did Alice think it so very much out "
                    "of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be "
                    "late!' (when she thought it over afterwards, it occurred to her that she ought to "
                    "have wondered at this, but at the time it all seemed quite natural); but when the "
                    "Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then "
                    "hurried on, Alice started to her feet, for it flashed across her mind that she had "
                    "never before seen a rabbit with either a waistcoat-pocket, or a watch to take out "
                    "of it, and burning with curiosity, she ran across the field after it, and fortunately "
                    "was just in time to see it pop down a large rabbit-hole under the hedge.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
