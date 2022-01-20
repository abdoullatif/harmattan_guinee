import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:sqflite/sqflite.dart';

class Themes{
  //database
  static Database _db = DB.daba;

  //attributs
  var id;
  var nom_theme;
  var couverture_theme;


  //methode


  //-Query---------------------------------------------------------------------------------------------------------------------
  //Select all
  static Future<List<Map<String, dynamic>>> Select() async => await _db.rawQuery('SELECT * FROM theme');

  //Select where
  static Future<List<Map<String, dynamic>>> SelectWere(int id) async => await _db.rawQuery('SELECT * FROM theme where id = $id');

  //insert
  static Future<int> insert(String table, Map<String, dynamic> model) async => await _db.insert(table, model);

  //Update
  static Future<int> update(String table, Map<String, dynamic> model,String id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

}