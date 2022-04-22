import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:sqflite/sqflite.dart';

class Langue {

  //Database
  static Database _db = DB.daba;

  //attributs
  var id;
  var page_livre;
  var livre_id;

  //methode

  //-Query---------------------------------------------------------------------------------------------------------------------
  //Select
  static Future<List<Map<String, dynamic>>> Select() async => await _db.rawQuery('SELECT * FROM langue');

  //Select Audio
  static Future<List<Map<String, dynamic>>> SelectLangue() async => await _db.rawQuery('SELECT * FROM livre,audio WHERE livre.id = audio.livre_id');

  //Select where id
  static Future<List<Map<String, dynamic>>> SelectWhere(int livre_id) async => await _db.rawQuery('SELECT * FROM audio WHERE livre_id = $livre_id');

  //Select where id
  static Future<List<Map<String, dynamic>>> SelectWhereLangueAudio(int livre_id) async => await _db.rawQuery('SELECT * FROM livre,audio WHERE livre.id = $livre_id and livre.id = audio.livre_id');

}