import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class ExternalController {
  final name = TextEditingController();
  final description = TextEditingController();

  void reset() {
    name.text = "";
    description.text = "";
  }

  void create(User user) async {
    user.external = "yes";
    final data = EquipmentExt(id: 0, user: user.username, name: name.text, description: description.text, createdAt: "");
    final update = await SQLHelper.updateUser(user.id, user);
    final externalData = await SQLHelper.createEquipmentExt(data);
    if (kDebugMode) {
      print("Updated user $update");
      print("Created ExtEquipment $externalData");
    }
  }

  void delete(EquipmentExt? extEquipment) async {
    if (extEquipment != null) {
      final delete = await SQLHelper.deleteItem(extEquipment.id, "equipment_ext");
      if (extEquipment.user != "") {
        final userData = await SQLHelper.getUser(extEquipment.user);
        final equipmentList = await SQLHelper.getList("equipment_ext");
        var hasExternal = false;
        for(var i = 0;  i < equipmentList.length; i++) {
          if (userData.elementAt(0)["username"] == equipmentList.elementAt(i)["user"]) {
            hasExternal = true;
          }
        }
        if(hasExternal == false) {
          final update = await SQLHelper.updateUser(userData.elementAt(0)["id"], User(
              id: userData.elementAt(0)["id"],
              username: userData.elementAt(0)["username"],
              firstName: userData.elementAt(0)["first_name"],
              lastName: userData.elementAt(0)["last_name"],
              password: userData.elementAt(0)["password"],
              entranceTime: userData.elementAt(0)["entrance_time"],
              internal: userData.elementAt(0)["internal"],
              external: "no",
              access: userData.elementAt(0)["access"]
          ));
        }
      }
    }
  }

  void update(EquipmentExt selectedExt, String user) async {
    final data = EquipmentExt(
        id: selectedExt.id,
        user: user,
        name: name.text,
        description: description.text,
        createdAt: selectedExt.createdAt,
    );
    final result = await SQLHelper.updateEquipmentExt(data.id, data);

    final userData = await SQLHelper.getUser(selectedExt.user);
    final equipmentList = await SQLHelper.getList("equipment_ext");
    var hasExternal = false;
    for(var i = 0;  i < equipmentList.length; i++) {
      if (userData.elementAt(0)["username"] == equipmentList.elementAt(i)["user"]) {
        hasExternal = true;
      }
    }
    if(hasExternal == false) {
      final update = await SQLHelper.updateUser(userData.elementAt(0)["id"], User(
          id: userData.elementAt(0)["id"],
          username: userData.elementAt(0)["username"],
          firstName: userData.elementAt(0)["first_name"],
          lastName: userData.elementAt(0)["last_name"],
          password: userData.elementAt(0)["password"],
          entranceTime: userData.elementAt(0)["entrance_time"],
          internal: userData.elementAt(0)["internal"],
          external: "no",
          access: userData.elementAt(0)["access"]
      ));
    }
  }
}