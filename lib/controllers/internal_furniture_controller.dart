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
}