import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../app_state.dart';
import '../sql_helper.dart';

class UserController {
  User? selectedUser;
  final username = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final entranceTime = TextEditingController();
  final access = TextEditingController();
  String alertText = "";
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  UserController(this.changeState, this.refresh);

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

  void update() async {
    final data = User(
        id: 0,
        username: username.text,
        firstName: firstName.text,
        lastName: lastName.text,
        password: selectedUser!.password,
        entranceTime: selectedUser!.entranceTime,
        access: access.text
    );
    final result = await SQLHelper.updateUser(selectedUser!.id, data);
    if (kDebugMode) {
      print("Updated User $result");
    }
  }

  void viewUserDetails(User user) {
    selectedUser = user;
    changeState(AppState.userDetails);
  }
  void viewEditUser(User? user) {
      reset();
      selectedUser = user;
      access.text = selectedUser?.access != null ? selectedUser!.access : "user";
      username.text = selectedUser!.username;
      firstName.text = selectedUser!.firstName;
      lastName.text = selectedUser!.lastName;
      changeState(AppState.userEdit);
  }
  void viewDeleteUser(User? user) {
      selectedUser = user;
      changeState(AppState.userDelete);
  }
  void viewCreateUser() {
      reset();
      access.text = "user";
      changeState(AppState.userCreate);
  }

  void selectAccess(String text) {
    access.text = text;
    refresh();
  }
}