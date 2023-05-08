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
}