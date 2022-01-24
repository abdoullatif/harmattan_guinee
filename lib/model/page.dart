import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:sqflite/sqflite.dart';

class Pages {

  //Database
  static Database _db = DB.daba;

  //attributs
  var id;
  var page_livre;
  var livre_id;

  //methode

  //-Query---------------------------------------------------------------------------------------------------------------------
  //Select
  static Future<List<Map<String, dynamic>>> Select() async => await _db.rawQuery('SELECT * FROM page');

  //Select where id
  static Future<List<Map<String, dynamic>>> SelectWhere(int livre_id) async => await _db.rawQuery('SELECT * FROM page WHERE livre_id = $livre_id');

  //Select where id
  static Future<List<Map<String, dynamic>>> SelectWherePageLivre(int livre_id) async => await _db.rawQuery('SELECT * FROM livre,page WHERE livre.id = $livre_id and livre.id = page.livre_id');

}