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
        status TEXT,
        type TEXT,
        equipment_info TEXT,
        external TEXT,
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
        description INTEGER,
        specs TEXT,
      )
      """);
  }
}