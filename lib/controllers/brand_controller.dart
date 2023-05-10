import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../app_state.dart';
import '../sql_helper.dart';

class BrandController {
  EquipmentCategory? selectedCategory;
  final name = TextEditingController();
  final description = TextEditingController();
  String alertText = "";
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  BrandController(this.changeState, this.refresh);

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

  void viewBrandDetails(EquipmentCategory brand) {
    selectedCategory = brand;
    changeState(AppState.brandDetails);
  }
  void viewEditBrand(EquipmentCategory? brand) {
    reset();
    selectedCategory = brand;
    name.text = selectedCategory!.name;
    description.text = selectedCategory!.description;
    changeState(AppState.brandEdit);
  }
  void viewDeleteBrand(EquipmentCategory? brand) {
    selectedCategory = brand;
    changeState(AppState.brandDelete);
  }
  void viewCreateBrand() {
    reset();
    changeState(AppState.brandCreate);
  }
}