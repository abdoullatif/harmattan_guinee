import 'package:Harmattan_guinee/databases/sqflite_db.dart';
import 'package:sqflite/sqflite.dart';

class User {
  //database
  static Database _db = DB.daba;

  //attributs
  var id;
  var nom;
  var prenom;
  var email;
  var password;
  var role;
  var avatar;
  var flagtransmis;



  //methode




  //-Query---------------------------------------------------------------------------------------------------------------------
  //Update
  static Future<int> update(String table, Map<String, dynamic> model,String id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

  //Query
  static Future<List<Map<String, dynamic>>> query() async => await _db.rawQuery('SELECT * FROM table WHERE ');

  //insert
  static Future<int> insert(String table, Map<String, dynamic> model) async => await _db.insert(table, model);

}