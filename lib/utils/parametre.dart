import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class Parametre {
  //attribut
  final statusPermission = 0;

  //Methode
  static createFolder()async {
    //
    final uploads = "uploads";
    final livres = "livres";
    final theme = "themes";
    final utilisateur = "utilisateur";
    //
    final appPath = (await getExternalStorageDirectory()).path;
    //print(appPath);
    final uploadsPath = Directory("$appPath/$uploads");
    final livresPath = Directory("$appPath/$uploads/$livres");
    final themePath = Directory("$appPath/$uploads/$theme");
    final utilisateurPath = Directory("$appPath/$uploads/$utilisateur");
    //checking
    if ((await uploadsPath.exists())) {
      // TODO:
      print("folder exist");
      //
      if((await livresPath.exists()) && (await themePath.exists()) && (await utilisateurPath.exists())) {
        // TODO:
        print("livre,theme,utilisateur folder exist");
      } else {
        // TODO:
        print("not exist other folder : create");
        var status = await Permission.manageExternalStorage.status;
        if (status.isDenied) {
          //
        } else {
          livresPath.create();
          themePath.create();
          utilisateurPath.create();
        }

      }

    } else {
      // TODO:
      print("not exist folder : create");
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
      } else {
        uploadsPath.create();
        livresPath.create();
        themePath.create();
        utilisateurPath.create();
      }

    }
  }

}