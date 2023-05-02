import 'package:flutter/material.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/admin_main_view.dart';
import 'package:furniture_store/views/login_view.dart';
import 'package:furniture_store/views/security_main_view.dart';
import 'package:furniture_store/views/user_main_view.dart';

import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> items = [];

  User loginUser = User.empty();
  AppState appState = AppState.loginScreen;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var alertText = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainView(),
    );
  }

  @override
  void initState() {
    super.initState();
    //createUser();
    loadUsers();
  }

  void loadUsers() async {
    final data = await SQLHelper.getList("user");
    setState(() {
      items = data;
    });
    print("We have ${items.length} users in our database");
  }

  void createUser() async {
    final adminData = await SQLHelper.createUser(User(id: 0, username: "admin", firstName: "", lastName: "", password: "12345678", access: "admin"));
    final userData = await SQLHelper.createUser(User(id: 0, username: "user", firstName: "", lastName: "", password: "12345678", access: "user"));
    final securityData = await SQLHelper.createUser(User(id: 0, username: "security", firstName: "", lastName: "", password: "12345678", access: "security"));
    print("User $adminData created succesfully");
    print("User $userData created succesfully");
    print("User $securityData created succesfully");
  }

  Widget mainView() {
    switch(appState){
      case AppState.loginScreen: {
        return LoginView(
            alertText: alertText,
            login: () => login(),
            usernameController: usernameController,
            passwordController: passwordController);
      } break;
      case AppState.userMainView: {
        return UserMainView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      } break;
      case AppState.adminMainView: {
        return AdminMainView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      } break;
      case AppState.securityMainView: {
        return SecurityMainView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      } break;
      default: {
        return Text(appState.toString());
      } break;
    }
  }

  void changeState(AppState state) {
    setState(() {
      appState = state;
      alertText = "";
    });
  }

  void login() async {
    List<Map<String, dynamic>> data = await SQLHelper.loginUser(usernameController.text, passwordController.text);
    if(data.length == 1) {
      setUserInfo(data[0]);
      switch(loginUser.access) {
        case "admin": {
          setState(() {
            appState = AppState.adminMainView;
            alertText = "";
          });
        } break;
        case "user": {
          setState(() {
            appState = AppState.userMainView;
            alertText = "";
          });
        } break;
        case "security": {
          setState(() {
            appState = AppState.securityMainView;
            alertText = "";
          });
        } break;
        default: {
          setState(() {
            appState = AppState.error;
            alertText = "";
          });
        } break;
      }
    } else {
      setState(() {
        alertText = "Login Failed: Your user ID or password is incorrect";
      });
    }
  }

  void logout() {
    setState(() {
      loginUser = User.empty();
      appState = AppState.loginScreen;
      usernameController.text = "";
      passwordController.text = "";
      alertText = "";
    });
  }

  void setUserInfo(Map<String, dynamic> data) {
    setState(() {
      loginUser = User(
          id: data["id"],
          username: data["username"],
          firstName: data["first_name"],
          lastName: data["last_name"],
          password: data["password"],
          access: data["access"]
      );
    });
  }

}
