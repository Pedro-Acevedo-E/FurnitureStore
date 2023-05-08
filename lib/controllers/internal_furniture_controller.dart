import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class InternalController {
  final status = TextEditingController();
  final productId = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  final model = TextEditingController();
  final weight = TextEditingController();
  final dimensions = TextEditingController();
  final color1 = TextEditingController();
  final color2 = TextEditingController();
  final notes = TextEditingController();


  void reset() {
    status.text = "";
    productId.text = "";
    name.text = "";
    description.text = "";
    model.text = "";
    weight.text = "";
    dimensions.text = "";
    color1.text = "";
    color2.text = "";
    notes.text = "";
  }

  void create(User? user, EquipmentCategory category) async {
    if (user != null) {
      user.internal = "yes";
      final data = EquipmentInt(
          id: 0,
          user: user.username,
          location: "Office with ${user.username}",
          status: status.text,
          productId: productId.text,
          name: name.text,
          description: description.text,
          category: category.name,
          model: model.text,
          weight: weight.text,
          dimensions: dimensions.text,
          color_1: color1.text,
          color_2: color2.text,
          notes: notes.text,
          createdAt: "");
      final update = await SQLHelper.updateUser(user.id, user);
      final internalData = await SQLHelper.createEquipmentInt(data);
      if (kDebugMode) {
        print("Updated user $update");
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
          category: category.name,
          model: model.text,
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
      if (intEquipment.user != "") {
        final userData = await SQLHelper.getUser(intEquipment.user);
        final equipmentList = await SQLHelper.getList("equipment_int");
        var hasInternal = false;
        for(var i = 0;  i < equipmentList.length; i++) {
          if (userData.elementAt(0)["username"] == equipmentList.elementAt(i)["user"]) {
            hasInternal = true;
          }
        }
        if(hasInternal == false) {
          final update = await SQLHelper.updateUser(userData.elementAt(0)["id"], User(
              id: userData.elementAt(0)["id"],
              username: userData.elementAt(0)["username"],
              firstName: userData.elementAt(0)["first_name"],
              lastName: userData.elementAt(0)["last_name"],
              password: userData.elementAt(0)["password"],
              entranceTime: userData.elementAt(0)["entrance_time"],
              internal: "no",
              external: userData.elementAt(0)["external"],
              access: userData.elementAt(0)["access"]
          ));
        }
      }
    }
  }
}