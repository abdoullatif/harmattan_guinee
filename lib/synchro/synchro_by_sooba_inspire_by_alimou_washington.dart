import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import 'package:mysql1/mysql1.dart';


class Synchro {
  Database db;
  Context context;
  String localPath;
  String onlinePath;
  String db_name_local;
  String user;
  String db_name_online;
  String online_ip;
  String online_link;
  String password;
  var conn;

  Synchro(
      String db_name_local,
      String localPath,
      String onlinePath,
      String user,
      String password,
      String db_name_online,
      online_ip,
      online_link)
  {
    this.localPath = localPath;
    this.onlinePath = onlinePath;
    this.db_name_local = db_name_local;
    this.user = user;
    this.password = password;
    this.db_name_online = db_name_online;
    this.online_ip = online_ip;
    this.online_link = online_link;
  }

  //
  connect() async {
    //var init
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, this.db_name_local);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {

      //Base de donnees n'existe pas
      print("error database");

    } else {

      try{

        print("Opening local database");

        //open the database
        db = await openDatabase(path);

        //Utilisation des parametre locale pour la connexion online
        List<Map> ids = await db.rawQuery('SELECT * FROM parametre');
        var counting;

        //Connection to online database
        conn = await MySqlConnection.connect(ConnectionSettings(
            host: this.online_ip,
            port: 3306, //3407
            user: this.user,
            password: this.password,
            db: this.db_name_online));

        print("==========================Server to local start=============================================");

        //print("-------------------Users Table-------------------------------");
        /*
        try{

          var get_users_rows = await conn.query(
              'SELECT * FROM  users ', []);

          counting = 0;
          for (var row in get_users_rows) {
            print(row);
            try{
              //
              var id = row['id'];
              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM users  where id=?',
                  [id]));
              if (exiting == 0)  {
                //insert
                await db.rawQuery(
                    'INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `password`, `role`, `avatar`) VALUES (?,?,?,?,?,?,?)',
                    [
                      row['id'],
                      row['nom'],
                      row['prenom'],
                      row['email'],
                      row['password'],
                      row['role'],
                      row['avatar'],


                    ]);
                counting++;
              }
            }catch(e){
              print("error ");
            }

          }

        } catch (e) {
          print("error from  users table " + e.toString());
        }
        */

        print("-------------------User Table-------------------------------");

        try {
          //users
          var counting = 0;

          var get_users_rows =
          await conn.query('SELECT * FROM users ', []);

          //var codification_update_time = "";
          // print("flagtransmis" + localite_update_time);
          counting = 0;
          for (var row in get_users_rows) {

            try {
              var id = row['id'];
              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM users where id=?', [id]));
              if (exiting != 0) {
                //update
                List<Map> user_update = await db.rawQuery(
                    'SELECT * FROM users where id=?', [id]);
                var users_update_time;
                if (user_update.length == 0)
                  users_update_time = "";
                else
                  users_update_time = user_update.first['flagtransmis'];
                if ((users_update_time).toString().compareTo(
                    row['flagtransmis']) <
                    0) {

                  print("download users image" + row['avatar']);
                  var avatarName;
                  if (row['couverture_theme'].toString().startsWith("\\"))
                    avatarName = row['avatar']
                        .toString()
                        .replaceFirst(new RegExp(r'\\'), '');
                  else
                    avatarName = row['avatar'];
                  // print(dossierName);
                  Response response = await Dio().download(
                      this.online_link + "/hamattan/public/" + this.onlinePath + "/utilisateur/" + avatarName,
                      this.localPath + "/utilisateur/" + avatarName);
                  print("response" + response.statusCode.toString());
                  if (response.statusCode == 200) {
                    await db.rawUpdate(
                        'UPDATE `users` SET `nom`=?,`prenom`=?,`email`=?,`password`=?,`role`=?, `avatar`=?, `flagtransmis`=? WHERE `id`=?',
                        [
                          row['nom'],
                          row['prenom'],
                          row['email'],
                          row['password'],
                          row['role'],
                          row['avatar'],
                          row['flagtransmis'],
                          row['id']

                        ]);
                    counting++;
                  }

                }
              } else {

                print("download users image" + row['avatar']);
                var avatarName;
                if (row['couverture_theme'].toString().startsWith("\\"))
                  avatarName = row['avatar']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  avatarName = row['avatar'];
                // print(dossierName);
                Response response = await Dio().download(
                    this.online_link + "/hamattan/public/" + this.onlinePath + "/utilisateur/" + avatarName,
                    this.localPath + "/utilisateur/" + avatarName);
                print("response" + response.statusCode.toString());
                if (response.statusCode == 200) {
                  //insert
                  await db.rawQuery(
                      'INSERT INTO `users`(`id`, `nom`, `prenom`, `email`, `password`, `role`, `avatar`, `flagtransmis`) VALUES (?,?,?,?,?,?,?,?)',
                      [
                        row['id'],
                        row['nom'],
                        row['prenom'],
                        row['email'],
                        row['password'],
                        row['role'],
                        row['avatar'],
                        row['flagtransmis']
                      ]);
                  counting++;
                }

              }
            }catch(e){
              print("error "+e.toString());
            }
          }

          print('users : ${counting}');
          //end users
        } catch (e) {
          print("error from users table" + e.toString());
        }

        print("-------------------End User Table-----------------------------");


        print("-------------------Theme Table-------------------------------");

        try {

          var get_livre_rows = await conn.query(
              'SELECT * FROM theme', []);

          counting = 0;
          for (var row in get_livre_rows) {
            try{

              var id = row['id'];

              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM theme where id=?',
                  [id]));

              if (exiting != 0) {
                //update
                List<Map> theme_update = await db.rawQuery(
                    'SELECT * FROM theme where id=?',
                    [id]);
                var theme_update_time;
                if (theme_update.length == 0)
                  theme_update_time = "";
                else
                  theme_update_time = theme_update.first['flagtransmis'];
                if(theme_update_time.toString().compareTo("")!=0) {
                  if ((theme_update_time)
                      .toString()
                      .compareTo(row['flagtransmis']) <
                      0) {
                    print("download theme image" + row['couverture_theme']);
                    var couvertureName;
                    if (row['couverture_theme'].toString().startsWith("\\"))
                      couvertureName = row['couverture_theme']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      couvertureName = row['couverture_theme'];
                    // print(dossierName);
                    Response response = await Dio().download(
                        this.online_link + "/hamattan/public/" + this.onlinePath + "/themes/" + couvertureName,
                        this.localPath + "/themes/" + couvertureName);
                    print("response" + response.statusCode.toString());
                    if (response.statusCode == 200) {
                      counting++;
                      await db.rawUpdate(
                          'UPDATE `theme` SET `nom_theme`=?,`couverture_theme`=?,`flagtransmis`=? WHERE `id`=?',
                          [
                            row['nom_theme'],
                            row['couverture_theme'],
                            row['flagtransmis'],
                            row['id']
                          ]);
                    }
                  }
                }
              } else {

                //insert

                print("download theme couverture "+row['couverture_theme']);
                var couvertureName;
                if (row['couverture_theme'].toString().startsWith("\\"))
                  couvertureName = row['couverture_theme']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  couvertureName = row['couverture_theme'];
                print(this.online_link + "/hamattan/public/" + this.onlinePath + "/themes/" + couvertureName);
                Response response = await Dio().download(
                    this.online_link + "/hamattan/public/" + this.onlinePath + "/themes/" + couvertureName,
                    this.localPath + "/themes/" + couvertureName);
                print("response" + response.statusCode.toString());

                //response.statusCode
                if (response.statusCode == 200) {
                  await db.rawQuery(
                      'INSERT INTO `theme`(`id`,`nom_theme`, `couverture_theme`, `flagtransmis` )'
                          ' VALUES (?,?,?,?)',
                      [
                        row['id'],
                        row['nom_theme'],
                        row['couverture_theme'],
                        row['flagtransmis']

                      ]);
                  counting++;
                }
              }
            }catch(e){
              print('error theme row '+e.toString());
            }

          }

          print('theme ${counting}');
          //end personne

        } catch (e) {
          print("error from Theme table " + e.toString());
        }

        print("-------------------End Theme Table-------------------------------");


        print("-------------------livre Table-------------------------------");

        try {

          var get_livre_rows = await conn.query(
              'SELECT * FROM livre', []);

          counting = 0;
          for (var row in get_livre_rows) {
            try{

              var id = row['id'];

              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM livre where id=?',
                  [id]));

              if (exiting != 0) {
                //update
                List<Map> livre_update = await db.rawQuery(
                    'SELECT * FROM livre where id=?',
                    [id]);
                var livre_update_time;
                if (livre_update.length == 0)
                  livre_update_time = "";
                else
                  livre_update_time = livre_update.first['flagtransmis'];
                if(livre_update_time.toString().compareTo("")!=0) {
                  if ((livre_update_time)
                      .toString()
                      .compareTo(row['flagtransmis']) <
                      0) {
                    print("download livre dossier" + row['titre']);
                    var dossierName;
                    var couvertureName;
                    if (row['titre'].toString().startsWith("\\"))
                      dossierName = row['titre']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      dossierName = row['titre'];
                    //
                    if (row['couverture_livre'].toString().startsWith("\\"))
                      couvertureName = row['couverture_livre']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      couvertureName = row['couverture_livre'];
                    // print(dossierName);
                    Response response = await Dio().download(
                        this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + dossierName + "/" + couvertureName,
                        this.localPath + "/livres/" + dossierName + "/" + couvertureName);
                    print("response" + response.statusCode.toString());
                    if (response.statusCode == 200) {
                      counting++;
                      await db.rawUpdate(
                          'UPDATE `livre` SET `titre`=?,`resume_livre`=?,`biographie_auteur`=?,`statut`=?,`categorie`=?,`prix`=?,`couverture_livre`=?,`date_publication`=?,`theme_id`=?,`users_id`=?,`flagtransmis`=? WHERE `id`=?',
                          [
                            row['titre'],
                            row['resume_livre'],
                            row['biographie_auteur'],
                            row['statut'],
                            row['categorie'],
                            row['prix'],
                            row['couverture_livre'],
                            row['date_publication'],
                            //dossierName,
                            row['theme_id'],
                            row['users_id'],
                            row['flagtransmis'],
                            row['id']
                          ]);
                    }
                  }
                }
              } else {

                //insert

                print("download livre couverture "+row['titre']);
                var dossierName;
                var couvertureName;
                if (row['titre'].toString().startsWith("\\"))
                  dossierName = row['titre']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  dossierName = row['titre'];
                //
                if (row['couverture_livre'].toString().startsWith("\\"))
                  couvertureName = row['couverture_livre']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  couvertureName = row['couverture_livre'];
                // print(dossierName);
                Response response = await Dio().download(
                    this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + dossierName + "/" + couvertureName,
                    this.localPath + "/livres/" + dossierName + "/" + couvertureName);
                print("response" + response.statusCode.toString());

                //response.statusCode
                if (response.statusCode == 200) {
                  await db.rawQuery(
                      'INSERT INTO `livre`(`id`,`titre`, `resume_livre`, `biographie_auteur`, `statut`, '
                          ' `categorie`, `prix`, `couverture_livre`, `date_publication`, `theme_id`, users_id, `flagtransmis`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
                      [
                        row['id'],
                        row['titre'],
                        row['resume_livre'],
                        row['biographie_auteur'],
                        row['statut'],
                        row['categorie'],
                        row['prix'],
                        row['couverture_livre'],
                        row['date_publication'],
                        //dossierName,
                        row['theme_id'],
                        row['users_id'],
                        row['flagtransmis']

                      ]);
                  counting++;
                }
              }
            }catch(e){
              print('error livre row '+e.toString());
            }

          }

          print('livre ${counting}');
          //end personne

        } catch (e) {
          print("error from livre table " + e.toString());
        }

        print("-------------------End livre Table-------------------------------");


        print("-------------------Page Table-------------------------------");

        try {

          var get_livre_rows = await conn.query(
              'SELECT * FROM page', []);

          counting = 0;
          for (var row in get_livre_rows) {
            try{

              var id = row['id'];
              var livre_id = row['livre_id'];

              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM page where id=?',
                  [id]));

              if (exiting != 0) {
                //update
                List<Map> page_update = await db.rawQuery(
                    'SELECT * FROM page where id=?',
                    [id]);
                var page_update_time;
                if (page_update.length == 0)
                  page_update_time = "";
                else
                  page_update_time = page_update.first['flagtransmis'];
                if(page_update_time.toString().compareTo("")!=0) {
                  if ((page_update_time)
                      .toString()
                      .compareTo(row['flagtransmis']) <
                      0) {
                    print("download page pdf" + row['page_livre']);
                    var pageName;
                    if (row['page_livre'].toString().startsWith("\\"))
                      pageName = row['page_livre']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      pageName = row['page_livre'];
                    // Livre
                    List<Map> livreFolder = await db.rawQuery(
                        'SELECT * FROM livre where id=?',
                        [livre_id]);
                    //
                    Response response = await Dio().download(
                        this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + livreFolder.first['titre'] + "/" + pageName,
                        this.localPath + "/livres/" + livreFolder.first['titre'] + "/" + pageName);
                    print("response" + response.statusCode.toString());
                    if (response.statusCode == 200) {
                      counting++;
                      await db.rawUpdate(
                          'UPDATE `page` SET `page_livre`=?,`livre_id`=?,`flagtransmis`=? WHERE `id`=?',
                          [
                            row['page_livre'],
                            row['livre_id'],
                            row['flagtransmis'],
                            row['id']
                          ]);
                    }
                  }
                }
              } else {

                //insert

                print("download page pdf "+row['page_livre']);
                var pageName;
                if (row['page_livre'].toString().startsWith("\\"))
                  pageName = row['page_livre']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  pageName = row['page_livre'];
                // Livre
                List<Map> livreFolder = await db.rawQuery(
                    'SELECT * FROM livre where id=?',
                    [livre_id]);
                //
                Response response = await Dio().download(
                    this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + livreFolder.first['titre'] + "/" + pageName,
                    this.localPath + "/livres/" + livreFolder.first['titre'] + "/" + pageName);
                print("response" + response.statusCode.toString());

                //response.statusCode
                if (response.statusCode == 200) {
                  await db.rawQuery(
                      'INSERT INTO `page`(`id`,`page_livre`, `livre_id`, `flagtransmis` )'
                          ' VALUES (?,?,?,?)',
                      [
                        row['id'],
                        row['page_livre'],
                        row['livre_id'],
                        row['flagtransmis']

                      ]);
                  counting++;
                }
              }
            }catch(e){
              print('error page row '+e.toString());
            }

          }

          print('page ${counting}');
          //end personne

        } catch (e) {
          print("error from page table " + e.toString());
        }

        print("-------------------End Page Table-------------------------------");


        print("-------------------Audio Table-------------------------------");

        try {

          var get_livre_rows = await conn.query(
              'SELECT * FROM audio', []);

          counting = 0;
          for (var row in get_livre_rows) {
            try{

              var id = row['id'];
              var livre_id = row['livre_id'];

              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM audio where id=?',
                  [id]));

              if (exiting != 0) {
                //update
                List<Map> audio_update = await db.rawQuery(
                    'SELECT * FROM audio where id=?',
                    [id]);
                var audio_update_time;
                if (audio_update.length == 0)
                  audio_update_time = "";
                else
                  audio_update_time = audio_update.first['flagtransmis'];
                if(audio_update_time.toString().compareTo("")!=0) {
                  if ((audio_update_time)
                      .toString()
                      .compareTo(row['flagtransmis']) <
                      0) {
                    print("download audio" + row['contenue_audio']);
                    var audioName;
                    if (row['contenue_audio'].toString().startsWith("\\"))
                      audioName = row['contenue_audio']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      audioName = row['contenue_audio'];
                    // Livre
                    List<Map> livreFolder = await db.rawQuery(
                        'SELECT * FROM livre where id=?',
                        [livre_id]);
                    //
                    Response response = await Dio().download(
                        this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + livreFolder.first['titre'] + "/" + audioName,
                        this.localPath + "/livres/" + livreFolder.first['titre'] + "/" + audioName);
                    print("response" + response.statusCode.toString());
                    if (response.statusCode == 200) {
                      counting++;
                      await db.rawUpdate(
                          'UPDATE `audio` SET `contenue_audio`=?,`livre_id`=?,`flagtransmis`=? WHERE `id`=?',
                          [
                            row['contenue_audio'],
                            row['livre_id'],
                            row['flagtransmis'],
                            row['id']
                          ]);
                    }
                  }
                }
              } else {

                //insert

                print("download audio "+row['contenue_audio']);
                var audioName;
                if (row['contenue_audio'].toString().startsWith("\\"))
                  audioName = row['contenue_audio']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  audioName = row['contenue_audio'];
                // Livre
                List<Map> livreFolder = await db.rawQuery(
                    'SELECT * FROM livre where id=?',
                    [livre_id]);
                //
                Response response = await Dio().download(
                    this.online_link + "/hamattan/public/" + this.onlinePath + "/livres/" + livreFolder.first['titre'] + "/" + audioName,
                    this.localPath + "/livres/" + livreFolder.first['titre'] + "/" + audioName);
                print("response" + response.statusCode.toString());

                //response.statusCode
                if (response.statusCode == 200) {
                  await db.rawQuery(
                      'INSERT INTO `page`(`id`,`contenue_audio`, `livre_id`, `flagtransmis` )'
                          ' VALUES (?,?,?,?)',
                      [
                        row['id'],
                        row['contenue_audio'],
                        row['livre_id'],
                        row['flagtransmis']

                      ]);
                  counting++;
                }
              }
            }catch(e){
              print('error audio row '+e.toString());
            }

          }

          print('audio ${counting}');
          //end personne

        } catch (e) {
          print("error from audio table " + e.toString());
        }

        print("-------------------End Audio Table-------------------------------");



      } catch (e){
        print("error tables"+e.toString());
      } finally{
        //Execute la fonction apres 5 min apres finalisation
        Future.delayed(const Duration(seconds: 300),()=> connect());
      }


    }

  }

  synchronize() {
    //execute connect
    connect();
  }


}