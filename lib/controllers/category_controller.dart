import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class CategoryController {
  final name = TextEditingController();
  final description = TextEditingController();
  String alertText = "";

  void reset() {
    name.text = "";
    description.text = "";
    alertText = "";
  }

  void create() async {
    final createCategory = await SQLHelper.createCategory(name.text, description.text);
    if (kDebugMode) {
      print("Created Category $createCategory");
    }
  }

  void delete(int id) async {
    final deleteCategory = SQLHelper.deleteItem(id, "category");
    if (kDebugMode) {
      print("Deleted Category $deleteCategory");
    }
  }

  void update(EquipmentCategory cat) async {
    final updateCategory = await SQLHelper.updateCategory(cat.id, name.text, description.text);
    if (kDebugMode) {
      print("Updated Category $updateCategory");
    }
  }
}