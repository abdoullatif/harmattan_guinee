import 'dart:async';
import 'package:sqflite/sqflite.dart';


class DB{
  //
  static Database _db;
  static int get _version => 1;

  //init
  static Future<void> init() async{
    if (_db != null) return;
    try{
      String _path = await getDatabasesPath() + 'harmattan';
      print("succes");
      print(_path);
      _db = (await openDatabase(_path, version: _version, onCreate: onCreate)) as Database;
    } catch (ex){
      print(ex);
    }
  }

  //onCreate
  static void onCreate(Database db, int version) async{
    //------------------------------Parametre de la tablette------------------------
    //table parametre
    await db.execute('''
    CREATE TABLE parametre(
    id INTEGER PRIMARY KEY,
    device TEXT,
    dbname TEXT,
    user TEXT,
    mdp TEXT,
    adresse_server TEXT,
    ip_server TEXT,
    site_harmattan TEXT)
    ''');
    //----------------------------------------------------------------------------
    //table users
    await db.execute('''
    CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    nom TEXT,
    prenom TEXT,
    email TEXT,
    password TEXT,
    role TEXT,
    avatar TEXT,
    flagtransmis TEXT)
    ''');
    //table livre
    await db.execute('''
    CREATE TABLE livre(
    id TEXT,
    titre TEXT,
    resume_livre TEXT,
    biographie_auteur TEXT,
    statut TEXT,
    categorie TEXT,
    prix TEXT,
    couverture_livre TEXT,
    date_publication TEXT,
    theme_id TEXT,
    users_id TEXT,
    flagtransmis TEXT)
    ''');
    //table theme
    await db.execute('''
    CREATE TABLE theme(
    id TEXT PRIMARY KEY,
    nom_theme TEXT,
    couverture_theme TEXT,
    flagtransmis TEXT)
    ''');
    //Table audio
    await db.execute('''
    CREATE TABLE audio(
    id TEXT PRIMARY KEY,
    contenue_audio TEXT,
    livre_id TEXT,
    flagtransmis TEXT)
    ''');
    //personne page
    await db.execute('''
    CREATE TABLE page(
    id TEXT PRIMARY KEY,
    page_livre TEXT,
    livre_id TEXT,
    flagtransmis TEXT)
    ''');
  }

  //Query
  //----------------------------------------------------------------------------------------------------------------------------------------
  //Update
  static Future<int> update(String table, Map<String, dynamic> model,String id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

  //Update
  static Future<int> updateTable(String table, Map<String, dynamic> model,int id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

  //Query
  static Future<List<Map<String, dynamic>>> query() async => await _db.rawQuery('SELECT  FROM  WHERE ');

  //insert
  static Future<int> insert(String table, Map<String, dynamic> model) async => await _db.insert(table, model);

  //update
  //static Future<int> update(String table, Map<String, dynamic> model,int id) async => await _db.update(table, model, where: 'id = ?', whereArgs: [id]);

  //Query Select All
  static Future<List<Map<String, dynamic>>> querySelect(String table) async => await _db.rawQuery('SELECT * FROM $table');

  //Drop or delect table
  static Future<List<Map<String, dynamic>>> troncateTable(String table) async => await _db.rawQuery('DELETE from "$table"');

}