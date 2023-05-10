import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class BrandController {
  final name = TextEditingController();
  final description = TextEditingController();
  String alertText = "";

  void reset() {
    name.text = "";
    description.text = "";
    alertText = "";
  }

  void create() async {
    final createBrand = await SQLHelper.createBrand(name.text, description.text);
    if (kDebugMode) {
      print("Created Brand $createBrand");
    }
  }

  void delete(int id) async {
    final deleteBrand = SQLHelper.deleteItem(id, "brand");
    if (kDebugMode) {
      print("Deleted Brand $deleteBrand");
    }
  }

  void update(EquipmentCategory cat) async {
    final updateBrand = await SQLHelper.updateBrand(cat.id, name.text, description.text);
    if (kDebugMode) {
      print("Updated Brand $updateBrand");
    }
  }
}