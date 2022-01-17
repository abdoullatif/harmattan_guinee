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
            port: 3407,
            user: this.user,
            password: this.password,
            db: this.db_name_online));

        print("==========================Server to local start=============================================");

        print("-------------------Users Table-------------------------------");

        try{

          var get_users_rows = await conn.query(
              'SELECT * FROM  users ', []);
          counting = 0;
          for (var row in get_users_rows) {
            try{
              //
              var id = row['id'];
              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM users  where id=?',
                  [id]));
              if (exiting == 0)  {
                //insert
                await db.rawQuery(
                    'INSERT INTO `users` (`id`, `nom`, `prenom`, `email`, `password`, `role`, `avatar`,) VALUES (?,?,?,?,?,?,?)',
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
        print("-------------------End Users Table-------------------------------");

        print("-------------------Theme Table-------------------------------");

        try {
          //theme
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
                  'SELECT COUNT(*) FROM users  where id=?', [id]));
              if (exiting != 0) {
                //update
                List<Map> localite_update = await db.rawQuery(
                    'SELECT * FROM users where id=?', [id]);
                var users_update_time;
                if (localite_update.length == 0)
                  users_update_time = "";
                else
                  users_update_time = localite_update.first['flagtransmis'];
                if ((users_update_time).toString().compareTo(
                    row['flagtransmis']) <
                    0) {
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
              } else {
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
            }catch(e){
              print("error "+e.toString());
            }
          }

          print('users ${counting}');
          //end users
        } catch (e) {
          print("error from users table" + e.toString());
        }

        print("-------------------End Theme Table-------------------------------");

        print("-------------------livre Table-------------------------------");

        try {

          var get_livre_rows = await conn.query(
              'SELECT * FROM  livre', []);

          counting = 0;
          for (var row in get_livre_rows) {
            try{

              var id = row['id'];

              int exiting = Sqflite.firstIntValue(await db.rawQuery(
                  'SELECT COUNT(*) FROM personne  where id_personne=?',
                  [id]));

              if (exiting != 0) {
                //update
                List<Map> personne_update = await db.rawQuery(
                    'SELECT * FROM livre where id=?',
                    [id]);
                var livre_update_time;
                if (personne_update.length == 0)
                  livre_update_time = "";
                else
                  livre_update_time = personne_update.first['flagtransmis'];
                if(livre_update_time.toString().compareTo("")!=0) {
                  if ((livre_update_time)
                      .toString()
                      .compareTo(row['flagtransmis']) <
                      0) {
                    print("download livre dossier" + row['titre']);
                    var dossierName;
                    if (row['titre'].toString().startsWith("\\"))
                      dossierName = row['titre']
                          .toString()
                          .replaceFirst(new RegExp(r'\\'), '');
                    else
                      dossierName = row['titre'];
                    // print(dossierName);
                    Response response = await Dio().download(
                        this.online_link + this.onlinePath + dossierName,
                        this.localPath + "/livre/" + dossierName);
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

                print("download livre dossier "+row['titre']);
                var dossierName;
                if (row['images'].toString().startsWith("\\"))
                  dossierName = row['titre']
                      .toString()
                      .replaceFirst(new RegExp(r'\\'), '');
                else
                  dossierName = row['titre'];
                // print(imageName);
                print(this.online_link + this.onlinePath + dossierName.toString());

                Response response = await Dio().download(
                    this.online_link + this.onlinePath + dossierName,
                    this.localPath + "/livre/" +dossierName);
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