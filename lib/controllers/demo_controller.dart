import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class DemoController {
  void loadItemsDemo() async {
    final userData = await SQLHelper.getList("user");
    final intFurnitureData = await SQLHelper.getList("equipment_int");
    final extFurnitureData = await SQLHelper.getList("equipment_ext");
    final categoryData = await SQLHelper.getList("category");
    final userLogData = await SQLHelper.getList("user_log");
    final incidentsLogData = await SQLHelper.getList("incident_log");
    if (kDebugMode) {
      print("We have ${userData.length} users in our database");
      print("We have ${categoryData.length} categories in our database");
      print("We have ${intFurnitureData.length} internal furniture in our database");
      print("We have ${extFurnitureData.length} external furniture in our database");
      print("We have ${userLogData.length} user logs in our database");
      print("We have ${incidentsLogData.length} incidents logs in our database");
    }
  }

  void createDemo() async {
    final phoneCategoryData = await SQLHelper.createCategory("Phone", "Mobile phone devices");
    final pcCategoryData = await SQLHelper.createCategory("PC", "Personal computer");
    final laptopCategoryData = await SQLHelper.createCategory("Laptop", "Portable personal computers");
    final user1 = await SQLHelper.createUser(User.demo1());
    final user2 = await SQLHelper.createUser(User.demo2());
    final user3 = await SQLHelper.createUser(User.demo3());
    final extDevice1 = await SQLHelper.createEquipmentExt(EquipmentExt.demo1());
    final extDevice2 = await SQLHelper.createEquipmentExt(EquipmentExt.demo2());
    final intDevice1 = await SQLHelper.createEquipmentInt(EquipmentInt.demo1());
    final intDevice2 = await SQLHelper.createEquipmentInt(EquipmentInt.demo2());
    final intDevice3 = await SQLHelper.createEquipmentInt(EquipmentInt.demo3());
    final intDevice4 = await SQLHelper.createEquipmentInt(EquipmentInt.demo4());

    if (kDebugMode) {
      print("Created category $phoneCategoryData in database");
      print("Created category $pcCategoryData in database");
      print("Created category $laptopCategoryData in database");
      print("Created user $user1 in database");
      print("Created user $user2 in database");
      print("Created user $user3 in database");
      print("Created ext device $extDevice1 in database");
      print("Created ext device $extDevice2 in database");
      print("Created int device $intDevice1 in database");
      print("Created int device $intDevice2 in database");
      print("Created int device $intDevice3 in database");
      print("Created int device $intDevice4 in database");
    }
  }
}