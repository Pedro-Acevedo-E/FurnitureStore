import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';
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
        id INTEGER PRIMARY KEY,
        product_id TEXT,
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

  static Future<int> createEquipment(Equipment equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'name': equipment.name,
      'description': equipment.description,
      'location': equipment.location,
      'status': equipment.status,
      'category': equipment.category,
      'equipment_info': equipment.equipmentInfo,
      'external': equipment.external,
      'notes': equipment.notes
    };

    final id = await db.insert(
        'equipment',
        data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createEquipmentInfo(EquipmentInfo info, int equipmentId) async {
    final db = await SQLHelper.db();

    final data = {
      'id': equipmentId,
      'product_id': info.productId,
      'model': info.model,
      'description': info.description,
      'weight': info.weight,
      'dimensions': info.dimensions,
      'color_1': info.color1,
      'color_2': info.color2
    };

    final id = await db.insert(
        'equipment_info',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createLog(Users user, String description, int equipmentId) async {
    final db = await SQLHelper.db();

    final data = {
      'equipment_id': equipmentId,
      'user_id': user.id,
      'description': description
    };

    final id = await db.insert(
        'equipment_info',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }
}



