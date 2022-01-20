import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:sqflite/sqflite.dart';

class Livre {
  //Database
  static Database _db = DB.daba;

  //attributs
  var id;
  var titre;
  var resume_livre;
  var biographie_auteur;
  var statut;
  var categorie;
  var prix;
  var couverture_livre;
  var date_publication;
  var theme_id;
  var users_id;


  //methode




  //----------------------------------------------------------------------------------------------------------------------
  //Update
  static Future<int> update(String table, Map<String, dynamic> model,String id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

  //Query
  static Future<List<Map<String, dynamic>>> query() async => await _db.rawQuery('SELECT * FROM table WHERE ');

  //insert
  static Future<int> insert(String table, Map<String, dynamic> model) async => await _db.insert(table, model);

}