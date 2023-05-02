import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        first_name TEXT,
        last_name TEXT,
        password TEXT,
        access TEXT
      )
      """);
    await database.execute("""CREATE TABLE equipment(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user_id INTEGER,
        name TEXT,
        description TEXT,
        location TEXT,
        status TEXT,
        category TEXT,
        equipment_info_id INTEGER,
        external TEXT,
        notes TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE equipment_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title VARCHAR,
        equipment_id INTEGER,
        user_id INTEGER,
        description TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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
        color_2 TEXT
      )
      """);
    await database.execute("""CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT
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
        debugPrint("Created database");
        await createTables(database);
      },
    );
  }

  //CRUD

  //CREATE
  static Future<int> createUser(User user) async {
    final db = await SQLHelper.db();

    final data = {
      'username': user.username,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'password': user.password,
      'access': user.access
    };

    final id = await db.insert(
        'user',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createEquipment(Equipment equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user_id': equipment.userID,
      'name': equipment.name,
      'description': equipment.description,
      'location': equipment.location,
      'status': equipment.status,
      'category': equipment.category,
      'equipment_info_id': equipment.equipmentInfoID,
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

  static Future<int> createEquipmentLog(User user, String title, String description, int equipmentId) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'equipment_id': equipmentId,
      'user_id': user.id,
      'description': "User ${user.username}:\n $description"
    };

    final id = await db.insert(
        'equipment_log',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createCategory(String name, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description
    };

    final id = await db.insert(
        'category',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  //READ LIST
  static Future<List<Map<String, dynamic>>> getList(String from) async {
    final db = await SQLHelper.db();
    return db.query(from, orderBy: "id");
  }

  //READ ITEM
  static Future<List<Map<String, dynamic>>> getItem(int id, String from) async {
    final db = await SQLHelper.db();
    return db.query(from, where: "id = ?", whereArgs: [id], limit: 1);
  }
  
  //UPDATE ITEM
  static Future<int> updateUser(int id, User user) async {
    final db = await SQLHelper.db();

    final data = {
      'username': user.username,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'password': user.password,
      'access': user.access
    };
    
    final result = await db.update('user', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateEquipment(int id, Equipment equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user_id': equipment.userID,
      'name': equipment.name,
      'description': equipment.description,
      'location': equipment.location,
      'status': equipment.status,
      'category': equipment.category,
      'equipment_info_id': equipment.equipmentInfoID,
      'external': equipment.external,
      'notes': equipment.notes
    };

    final result = await db.update('equipment', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateEquipmentInfo(int id, EquipmentInfo info) async {
    final db = await SQLHelper.db();

    final data = {
      'product_id': info.productId,
      'model': info.model,
      'description': info.description,
      'weight': info.weight,
      'dimensions': info.dimensions,
      'color_1': info.color1,
      'color_2': info.color2
    };

    final result = await db.update('equipment_info', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateCategory(int id, String name, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description
    };

    final result = await db.update('category', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //DELETE ITEM
  static Future<void> deleteItem(int id, String from) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(from, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Deletion attempt of $from: $id failed,\n $err");
    }
  }

  static Future<List<Map<String, dynamic>>> loginUser(String username, String password) async {
    final db = await SQLHelper.db();
    return db.rawQuery('SELECT * FROM user WHERE username=? AND password=?', [username, password]);
  }
}
