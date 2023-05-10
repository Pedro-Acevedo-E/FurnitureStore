import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../app_state.dart';
import '../sql_helper.dart';

class InternalController {
  User? selectedUser;
  EquipmentInt? selectedInt;
  EquipmentCategory? selectedBrand;
  EquipmentCategory? selectedCategory;
  final status = TextEditingController();
  final productId = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  final weight = TextEditingController();
  final dimensions = TextEditingController();
  final color1 = TextEditingController();
  final color2 = TextEditingController();
  final notes = TextEditingController();
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  InternalController(this.changeState, this.refresh);

  void reset() {
    status.text = "";
    productId.text = "";
    name.text = "";
    description.text = "";
    weight.text = "";
    dimensions.text = "";
    color1.text = "";
    color2.text = "";
    notes.text = "";
  }

  void create(User? user, String category, String model) async {
    if (user != null) {
      final data = EquipmentInt(
          id: 0,
          user: user.username,
          location: user.entranceTime != "" ? "Office with ${user.username}" : "Outside with ${user.username}",
          status: status.text,
          productId: productId.text,
          name: name.text,
          description: description.text,
          category: category,
          model: model,
          weight: weight.text,
          dimensions: dimensions.text,
          color_1: color1.text,
          color_2: color2.text,
          notes: notes.text,
          createdAt: "");
      final internalData = await SQLHelper.createEquipmentInt(data);
      if (kDebugMode) {
        print("Created ExtEquipment $internalData");
      }
    } else {
      final data = EquipmentInt(
          id: 0,
          user: "",
          location: "Office",
          status: status.text,
          productId: productId.text,
          name: name.text,
          description: description.text,
          category: category,
          model: model,
          weight: weight.text,
          dimensions: dimensions.text,
          color_1: color1.text,
          color_2: color2.text,
          notes: notes.text,
          createdAt: "");
      final internalData = await SQLHelper.createEquipmentInt(data);
      if (kDebugMode) {
        print("Created ExtEquipment $internalData");
      }
    }
  }

  void delete(EquipmentInt? intEquipment) async {
    if (intEquipment != null) {
      final delete = await SQLHelper.deleteItem(intEquipment.id, "equipment_int");
    }
  }

  void update(EquipmentInt selectedInt, String user, String category, String model) async {
    final data = EquipmentInt(
        id: selectedInt.id,
        user: user,
        location: user == selectedInt.user ? selectedInt.location : user != "" ? "Office with $user" : "Office",
        status: status.text,
        productId: productId.text,
        name: name.text,
        description: description.text,
        category: category,
        model: model,
        weight: weight.text,
        dimensions: dimensions.text,
        color_1: color1.text,
        color_2: color2.text,
        notes: notes.text,
        createdAt: selectedInt.createdAt
    );

    final result = await SQLHelper.updateEquipmentInt(selectedInt.id, data);
  }

  //Internal
  void viewInternalFurnitureDetails(EquipmentInt data) {
    selectedInt = data;
    changeState(AppState.internalDetails);
  }
  void viewEditInternalFurniture(EquipmentInt data) {
      reset();
      selectedInt = data;
      selectedUser = null;
      selectedCategory = null;
      selectedBrand = null;
      changeState(AppState.internalEdit);
  }
  void viewDeleteInternalFurniture(EquipmentInt data) {
      selectedInt = data;
      changeState(AppState.internalDelete);
  }
  void viewCreateInternalFurniture() {
      selectedUser = null;
      selectedCategory = null;
      selectedBrand = null;
      reset();
      changeState(AppState.internalCreate);
  }

  void selectUser(User user) {
    selectedUser = user;
    refresh();
  }

  void selectCategory(EquipmentCategory category) {
    selectedCategory = category;
    refresh();
  }

  void selectBrand(EquipmentCategory category) {
    selectedBrand = category;
    refresh();
  }
}