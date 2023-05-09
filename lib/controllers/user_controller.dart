import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class UserController {
  final username = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final entranceTime = TextEditingController();
  final access = TextEditingController();
  String alertText = "";

  void reset() {
    username.text = "";
    firstName.text = "";
    lastName.text = "";
    password.text = "";
    passwordConfirm.text = "";
    entranceTime.text = "";
    access.text = "";
    alertText = "";
  }

  void create() async {
      final data = User(
          id: 0,
          username: username.text,
          firstName: firstName.text,
          lastName: lastName.text,
          password: password.text,
          entranceTime: entranceTime.text,
          access: access.text
      );
      final createUser = await SQLHelper.createUser(data);
      if (kDebugMode) {
        print("Created User $createUser");
      }
  }

  void delete(int id) async {
    final del = SQLHelper.deleteItem(id, "user");
    if (kDebugMode) {
      print("Deleted User $del");
    }
  }

  void update(int id, String password) async {
    final data = User(
        id: 0,
        username: username.text,
        firstName: firstName.text,
        lastName: lastName.text,
        password: password,
        entranceTime: entranceTime.text,
        access: access.text
    );
    final result = await SQLHelper.updateUser(id, data);
    if (kDebugMode) {
      print("Updated User $result");
    }
  }
}