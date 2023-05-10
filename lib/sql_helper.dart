import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        first_name TEXT,
        last_name TEXT,
        password TEXT NOT NULL,
        entrance_time TEXT,
        access TEXT
      )
      """);
    await database.execute("""CREATE TABLE equipment_ext(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user TEXT,
        name TEXT,
        description TEXT,
        created_at DATE DEFAULT (datetime('now','localtime'))
      )
      """);
    await database.execute("""CREATE TABLE equipment_int(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user TEXT,
        location TEXT,
        status TEXT,
        product_id TEXT,
        name TEXT,
        description TEXT,
        category TEXT,
        model TEXT,
        weight TEXT,
        dimensions TEXT,
        color_1 TEXT,
        color_2 TEXT,
        notes TEXT,
        created_at DATE DEFAULT (datetime('now','localtime'))
      )
      """);
    await database.execute("""CREATE TABLE user_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        created_by TEXT,
        description TEXT,
        created_at DATE DEFAULT (datetime('now','localtime'))
      )
      """);
    await database.execute("""CREATE TABLE incident_log(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        created_by TEXT,
        description TEXT,
        created_at DATE DEFAULT (datetime('now','localtime'))
      )
      """);
    await database.execute("""CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        description TEXT
      )
      """);
    await database.execute("""CREATE TABLE brand(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        description TEXT
      )
      """);
    final dataAdmin = {
      'username': "admin",
      'first_name': "admin",
      'last_name': "",
      'password': "1234",
      'entrance_time': "",
      'access': "admin"
    };
    final dataSecurity = {
      'username': "security",
      'first_name': "security",
      'last_name': "",
      'password': "1234",
      'entrance_time': "",
      'access': "security"
    };
    final dataUser = {
      'username': "user",
      'first_name': "user",
      'last_name': "",
      'password': "1234",
      'entrance_time': "",
      'access': "user"
    };
    final dataCategory = {
      "name" : "Other",
      "description" : "Other registered equipment"
    };
    final dataBrand = {
      "name" : "Other",
      "description" : "Other registered equipment"
    };
    await database.insert(
        'user',
        dataAdmin,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    await database.insert(
        'user',
        dataSecurity,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );await database.insert(
        'user',
        dataUser,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    await database.insert(
        'category',
        dataCategory,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    await database.insert(
        'brand',
        dataBrand,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'furniture.db',
      version: 2,
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
      'entrance_time': user.entranceTime,
      'access': user.access
    };

    final id = await db.insert(
        'user',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createEquipmentExt(EquipmentExt equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user': equipment.user,
      'name': equipment.name,
      'description': equipment.description,
    };

    final id = await db.insert(
        'equipment_ext',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createEquipmentInt(EquipmentInt equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user': equipment.user,
      'location': equipment.location,
      'status': equipment.status,
      'product_id': equipment.productId,
      'name': equipment.name,
      'description': equipment.description,
      'category': equipment.category,
      'model': equipment.model,
      'weight': equipment.weight,
      'dimensions': equipment.dimensions,
      'color_1': equipment.color_1,
      'color_2': equipment.color_2,
      'notes': equipment.notes
    };

    final id = await db.insert(
        'equipment_int',
        data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<int> createLog(Log log, String table) async {
    final db = await SQLHelper.db();

    final data = {
      'title': log.title,
      'created_by': log.createdBy,
      'description': log.description,
    };

    final id = await db.insert(
        table,
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

  static Future<int> createBrand(String name, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description
    };

    final id = await db.insert(
        'brand',
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

  static Future<List<Map<String, dynamic>>> getUser(String username) async {
    final db = await SQLHelper.db();
    return db.query("user", where: "username = ?", whereArgs: [username], limit: 1);
  }

  static Future<bool> userExists(String username) async {
    final db = await SQLHelper.db();
    final query = await db.query("user", where: "username = ?", whereArgs: [username], limit: 1);
    if (query.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  
  //UPDATE ITEM
  static Future<int> updateUser(int id, User user) async {
    final db = await SQLHelper.db();

    final data = {
      'username': user.username,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'password': user.password,
      'entrance_time': user.entranceTime,
      'access': user.access
    };
    
    final result = await db.update('user', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateEquipmentInt(int id, EquipmentInt equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user': equipment.user,
      'location': equipment.location,
      'status': equipment.status,
      'product_id': equipment.productId,
      'name': equipment.name,
      'description': equipment.description,
      'category': equipment.category,
      'model': equipment.model,
      'weight': equipment.weight,
      'dimensions': equipment.dimensions,
      'color_1': equipment.color_1,
      'color_2': equipment.color_2,
      'notes': equipment.notes
    };

    final result = await db.update('equipment_int', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateEquipmentExt(int id, EquipmentExt equipment) async {
    final db = await SQLHelper.db();

    final data = {
      'user': equipment.user,
      'name': equipment.name,
      'description': equipment.description
    };

    final result = await db.update('equipment_ext', data, where: "id = ?", whereArgs: [id]);
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

  static Future<int> updateBrand(int id, String name, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'description': description
    };

    final result = await db.update('brand', data, where: "id = ?", whereArgs: [id]);
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

  static Future<List<Map<String, dynamic>>> filteredUserList() async {
    final db = await SQLHelper.db();
    return db.rawQuery('SELECT * FROM user WHERE entrance_time=?', [""]);
  }
}
