import 'package:flutter/material.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/login_view.dart';

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
    //final data = await SQLHelper.createUser(User(id: 0, username: "admin", firstName: "", lastName: "", password: "12345678", access: "admin"));
    final userData = await SQLHelper.createUser(User(id: 0, username: "user", firstName: "", lastName: "", password: "12345678", access: "user"));
    final securityData = await SQLHelper.createUser(User(id: 0, username: "security", firstName: "", lastName: "", password: "12345678", access: "security"));
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
        return const Text("user Main view");
      } break;
      case AppState.adminMainView: {
        return const Text("Admin Main view");
      } break;
      case AppState.securityMainView: {
        return const Text("Security Main view");
      } break;
      default: {
        return Text(appState.toString());
      } break;
    }
  }

  void login() async {
    List<Map<String, dynamic>> data = await SQLHelper.loginUser(usernameController.text, passwordController.text);
    if(data.length == 1) {
      print("Succesfull log in");
      setState(() {
        print("set appstate to use main view");
        appState = AppState.adminMainView;
        alertText = "";
      });
    } else if (data.length != 1) {
      setState(() {
        alertText = "Login Failed: Your user ID or password is incorrect";
      });
        print("multiple users found");
    } else {
      setState(() {
        alertText = "Login Failed: Your user ID or password is incorrect";
      });
        print("Login failed");
    }

  }
}
