import 'package:flutter/cupertino.dart';
import 'package:furniture_store/models.dart';

import '../app_state.dart';
import '../sql_helper.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var alertText = "";
  User loginUser = User.empty();
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  LoginController(this.changeState, this.refresh);

  LoginController.empty();

  void logout() {
    usernameController.text = "";
    passwordController.text = "";
    alertText = "";
    changeState(AppState.loginScreen);
  }

  void login() async {
    List<Map<String, dynamic>> data = await SQLHelper.loginUser(usernameController.text, passwordController.text);
    if(data.length == 1) {
      setUserInfo(data[0]);
      changeState(AppState.mainView);
    } else {
      alertText = "Login Failed: Your user ID or password is incorrect";
      refresh();
    }
  }

  void setUserInfo(Map<String, dynamic> data) {
    loginUser = User(
          id: data["id"],
          username: data["username"],
          firstName: data["first_name"],
          lastName: data["last_name"],
          password: data["password"],
          entranceTime: data["entrance_time"],
          access: data["access"]
      );
    }

}