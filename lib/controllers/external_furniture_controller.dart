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

  void update(EquipmentExt selectedExt, String user) async {
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