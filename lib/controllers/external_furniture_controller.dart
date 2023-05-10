import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';
import '../app_state.dart';
import '../sql_helper.dart';

class ExternalController {
  User? selectedUser;
  EquipmentExt? selectedExt;
  final name = TextEditingController();
  final description = TextEditingController();
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  ExternalController(this.changeState, this.refresh);

  void reset() {
    name.text = "";
    description.text = "";
  }

  void create(User user) async {
    final data = EquipmentExt(id: 0, user: user.username, name: name.text, description: description.text, createdAt: "");
    final externalData = await SQLHelper.createEquipmentExt(data);
    if (kDebugMode) {
      print("Created ExtEquipment $externalData");
    }
  }

  void delete(EquipmentExt? extEquipment) async {
    if (extEquipment != null) {
       final delete = await SQLHelper.deleteItem(extEquipment.id, "equipment_ext");
    }
  }

  void update(EquipmentExt? selectedExt, String user) async {
    if (selectedExt != null) {
      final data = EquipmentExt(
        id: selectedExt.id,
        user: user,
        name: name.text,
        description: description.text,
        createdAt: selectedExt.createdAt,
      );
      final result = await SQLHelper.updateEquipmentExt(data.id, data);
    }
  }

  void viewExternalFurnitureDetails(EquipmentExt data) {
    selectedExt = data;
    changeState(AppState.externalDetails);
  }
  void viewEditExternalFurniture(EquipmentExt data) {
    reset();
    selectedUser = null;
    selectedExt = data;
    changeState(AppState.externalEdit);
  }
  void viewDeleteExternalFurniture(EquipmentExt data) {
    selectedExt = data;
    changeState(AppState.externalDelete);
  }
  void viewCreateExternalFurniture() {
    reset();
    selectedUser = null;
    changeState(AppState.externalCreate);
  }

  void selectUser(User user) {
    selectedUser = user;
    refresh();
  }
}