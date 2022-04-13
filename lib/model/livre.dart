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




  //-Query---------------------------------------------------------------------------------------------------------------------
  //Select
  static Future<List<Map<String, dynamic>>> Select() async => await _db.rawQuery('SELECT * FROM livre');

  //Select where id
  static Future<List<Map<String, dynamic>>> SelectWhere(int id) async => await _db.rawQuery('SELECT * FROM page WHERE livre_id = $id');

  //Select where titre
  static Future<List<Map<String, dynamic>>> SelectWhereTitre(String titre) async => await _db.rawQuery('SELECT * FROM livre WHERE titre = "' + titre + '"');

  //Select where type
  static Future<List<Map<String, dynamic>>> SelectWhereType(String type_vente) async => await _db.rawQuery('SELECT * FROM livre WHERE type_vente = "' + type_vente + '"');

  //Select where titre
  static Future<List<Map<String, dynamic>>> SelectWhereTypeTheme(int id,String type_vente) async => await _db.rawQuery('SELECT * FROM livre WHERE type_vente = "' + type_vente + '" or theme_id = $id');

  //Select where Theme_id
  static Future<List<Map<String, dynamic>>> SelectWhereTheme(int id) async => await _db.rawQuery('SELECT * FROM livre WHERE theme_id = $id');

  //insert
  static Future<int> insert(String table, Map<String, dynamic> model) async => await _db.insert(table, model);

  //Update
  static Future<int> update(String table, Map<String, dynamic> model,String id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

}