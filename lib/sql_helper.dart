import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        password TEXT,
        access TEXT,
      )
      """);
    await database.execute("""CREATE TABLE equipment(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
        user_id INTEGER,
        location TEXT,
        status TEXT,
        category TEXT,
        equipment_info TEXT,
        external TEXT,
        notes TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE equipment_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        equipment_id INTEGER,
        user_id INTEGER,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE equipment_info(
        id TEXT,
        model TEXT,
        description TEXT,
        weight TEXT,
        dimensions TEXT,
        color_1 TEXT,
        color_2 TEXT,
      )
      """);
    await database.execute("""CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT,
      )
      """);
  }
  //We try to open "furniture.db" database,
  //If database does not exist it creates it with that name.
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'furniture.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createEquipment(String name) async {
    final db = await SQLHelper.db();

  }
}