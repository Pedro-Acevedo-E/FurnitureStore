import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/admin_main_view.dart';
import 'package:furniture_store/views/login_view.dart';
import 'package:furniture_store/views/security_main_view.dart';
import 'package:furniture_store/views/user_main_view.dart';

import 'models.dart';

void main() {
  //Were ensuring the app can only run in landscape
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
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
    //createDemo();
    loadItemsDemo();
  }

  void loadItemsDemo() async {
    final data = await SQLHelper.getList("user");
    final categoryData = await SQLHelper.getList("category");
    setState(() {
      items = data;
    });
    final exists = await SQLHelper.userExists("pedro");
    if (kDebugMode) {
      print("We have ${items.length} users in our database");
      for(int i = 0; i < items.length; i++) {
        print(items.elementAt(i)["username"]);
        print(items.elementAt(i)["id"]);
      }
      print("We have ${categoryData.length} categories in our database");
      for(int i = 0; i < categoryData.length; i++) {
        print(categoryData.elementAt(i)["name"]);
        print(categoryData.elementAt(i)["id"]);
      }
      if(exists) {
        print("Test User exists in database");
      } else {
        print("Test User does not exist in database");
      }
    }
  }

  void createDemo() async {
    final phoneCategoryData = await SQLHelper.createCategory("Phone", "Mobile phone devices");
    final pcCategoryData = await SQLHelper.createCategory("PC", "Personal computer");
    final laptopCategoryData = await SQLHelper.createCategory("Laptop", "Portable personal computers");
    final adminData = await SQLHelper.createUser(User.demo1());
    final userData = await SQLHelper.createUser(User.demo2());
    final securityData = await SQLHelper.createUser(User.demo3());
    if (kDebugMode) {
      print("Created category $phoneCategoryData in database");
      print("Created category $pcCategoryData in database");
      print("Created category $laptopCategoryData in database");
      print("Created user $adminData in database");
      print("Created user $userData in database");
      print("Created user $securityData in database");
    }
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
          entranceTime: data["entrance_time"],
          internal: data["internal"],
          external: data["external"],
          access: data["access"]
      );
    });
  }

}

