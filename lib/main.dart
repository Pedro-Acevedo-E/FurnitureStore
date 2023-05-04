import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/admin_main_view.dart';
import 'package:furniture_store/views/entrance_exits_view.dart';
import 'package:furniture_store/views/external_furniture_form.dart';
import 'package:furniture_store/views/login_view.dart';
import 'package:furniture_store/views/main_view.dart';
import 'package:furniture_store/views/security_main_view.dart';
import 'package:furniture_store/views/user_details_view.dart';
import 'package:furniture_store/views/user_entrance_view.dart';
import 'package:furniture_store/views/user_main_view.dart';

import 'models.dart';

void main() {
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
  List<User> userList = [];
  List<EquipmentExt> extList = [];
  List<EquipmentInt> intList = [];
  User loginUser = User.empty();
  User selectedUser = User.empty();

  //login
  AppState appState = AppState.loginScreen;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var alertText = "";

  //entrance user
  List<User> filteredUserList = [];
  List<Widget> formList = [];
  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> descriptionControllerList = [];

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
    final userData = await SQLHelper.getList("user");
    final intFurnitureData = await SQLHelper.getList("equipment_int");
    final extFurnitureData = await SQLHelper.getList("equipment_ext");
    final categoryData = await SQLHelper.getList("category");
    if (kDebugMode) {
      print("We have ${userData.length} users in our database");
      print("We have ${categoryData.length} categories in our database");
      print("We have ${intFurnitureData.length} internal furniture in our database");
      print("We have ${extFurnitureData.length} external furniture in our database");
    }
  }

  void createDemo() async {
    final phoneCategoryData = await SQLHelper.createCategory("Phone", "Mobile phone devices");
    final pcCategoryData = await SQLHelper.createCategory("PC", "Personal computer");
    final laptopCategoryData = await SQLHelper.createCategory("Laptop", "Portable personal computers");
    final adminData = await SQLHelper.createUser(User.demo1());
    final userData = await SQLHelper.createUser(User.demo2());
    final securityData = await SQLHelper.createUser(User.demo3());
    final user1 = await SQLHelper.createUser(User.demo4());
    final user2 = await SQLHelper.createUser(User.demo5());
    final user3 = await SQLHelper.createUser(User.demo6());
    final extDevice1 = await SQLHelper.createEquipmentExt(EquipmentExt.demo1());
    final extDevice2 = await SQLHelper.createEquipmentExt(EquipmentExt.demo2());
    final intDevice1 = await SQLHelper.createEquipmentInt(EquipmentInt.demo1());
    final intDevice2 = await SQLHelper.createEquipmentInt(EquipmentInt.demo2());
    final intDevice3 = await SQLHelper.createEquipmentInt(EquipmentInt.demo3());
    final intDevice4 = await SQLHelper.createEquipmentInt(EquipmentInt.demo4());

    if (kDebugMode) {
      print("Created category $phoneCategoryData in database");
      print("Created category $pcCategoryData in database");
      print("Created category $laptopCategoryData in database");
      print("Created user $adminData in database");
      print("Created user $userData in database");
      print("Created user $securityData in database");
      print("Created user $user1 in database");
      print("Created user $user2 in database");
      print("Created user $user3 in database");
      print("Created ext device $extDevice1 in database");
      print("Created ext device $extDevice2 in database");
      print("Created int device $intDevice1 in database");
      print("Created int device $intDevice2 in database");
      print("Created int device $intDevice3 in database");
      print("Created int device $intDevice4 in database");
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
      case AppState.mainView: {
        return MainView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      } break;
      case AppState.entrancesAndExits: {
        return EntranceAndExitsView(
            user: loginUser,
            userList: userList,
            changeState: (AppState state) => changeState(state),
            viewUserDetails: (User user) => viewUserDetails(user),
            viewUserEntrance: () => viewUserEntrance(),
            logout: () => logout());
      } break;
      case AppState.userDetails: {
        return UserDetailsView(
            user: loginUser,
            selectedUser: selectedUser,
            extList: extList,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      } break;
      case AppState.userEntrance: {
        return UserEntranceView(
            user: loginUser,
            selectedUser: selectedUser,
            userList: filteredUserList,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            selectUser: (User user) => selectUser(user),
            logout: () => logout(),
            addForm: () => addForm(),
            removeForm: () => removeForm(),
            formList: formList,
            nameControllerList: nameControllerList,
            descriptionControllerList: descriptionControllerList);
      } break;
      case AppState.userExit: {
        return Text("User exit");
      } break;
      default: {
        return Text(appState.toString());
      } break;
    }
  }

  void changeState(AppState state) {
   refreshList();
    setState(() {
      appState = state;
      alertText = "";
    });
  }

  void login() async {
    List<Map<String, dynamic>> data = await SQLHelper.loginUser(usernameController.text, passwordController.text);
    if(data.length == 1) {
      setUserInfo(data[0]);
      setState(() {
        appState = AppState.mainView;
        alertText = "";
      });
    } else {
      setState(() {
        alertText = "Login Failed: Your user ID or password is incorrect";
      });
    }
  }

  void logout() {
    setState(() {
      loginUser = User.empty();
      selectedUser = User.empty();
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

  void refreshList() async {
    final data = await SQLHelper.getList("user");
    final ext = await SQLHelper.getList("equipment_ext");
    final intE = await SQLHelper.getList("equipment_int");

    List<User> tempUserList = [];
    for(var i = 0; i < data.length; i++) {
      tempUserList.add(User(
          id: data.elementAt(i)["id"],
          username: data.elementAt(i)["username"],
          firstName: data.elementAt(i)["first_name"],
          lastName: data.elementAt(i)["last_name"],
          password: data.elementAt(i)["password"],
          entranceTime: data.elementAt(i)["entrance_time"],
          internal: data.elementAt(i)["internal"],
          external: data.elementAt(i)["external"],
          access: data.elementAt(i)["access"]));
    }
    List<EquipmentExt> tempExtList = [];
    for(var i = 0; i < ext.length; i++) {
      tempExtList.add(EquipmentExt(
          id: ext.elementAt(i)["id"],
          user: ext.elementAt(i)["user"],
          name: ext.elementAt(i)["name"],
          description: ext.elementAt(i)["description"],
          createdAt: ext.elementAt(i)["created_at"].toString()));
    }
    List<EquipmentInt> tempIntList = [];
    for(var i = 0; i < intE.length; i++) {
      tempIntList.add(EquipmentInt(
          id: intE.elementAt(i)["id"],
          user: intE.elementAt(i)["user"],
          location: intE.elementAt(i)["location"],
          status: intE.elementAt(i)["status"],
          productId: intE.elementAt(i)["product_id"],
          name: intE.elementAt(i)["name"],
          description: intE.elementAt(i)["description"],
          category: intE.elementAt(i)["category"],
          model: intE.elementAt(i)["model"],
          weight: intE.elementAt(i)["weight"],
          dimensions: intE.elementAt(i)["dimensions"],
          color_1: intE.elementAt(i)["color_1"],
          color_2: intE.elementAt(i)["color_2"],
          notes: intE.elementAt(i)["notes"],
          createdAt: intE.elementAt(i)["created_at"].toString()));
    }

    setState(() {
      userList = tempUserList;
      extList = tempExtList;
      intList = tempIntList;
    });
  }

  void viewUserDetails(User user) {
    selectUser(user);
    changeState(AppState.userDetails);
  }

  void viewUserEntrance() async {
    final data = await SQLHelper.filteredUserList();
    List<User> tempUserList = [];
    for(var i = 0; i < data.length; i++) {
      tempUserList.add(User(
          id: data.elementAt(i)["id"],
          username: data.elementAt(i)["username"],
          firstName: data.elementAt(i)["first_name"],
          lastName: data.elementAt(i)["last_name"],
          password: data.elementAt(i)["password"],
          entranceTime: data.elementAt(i)["entrance_time"],
          internal: data.elementAt(i)["internal"],
          external: data.elementAt(i)["external"],
          access: data.elementAt(i)["access"]));
    }

    setState(() {
      filteredUserList = tempUserList;
      selectedUser = filteredUserList[0];
      formList = [];
      nameControllerList = [];
      descriptionControllerList = [];
    });
    //add if to check if filtered list is empty
    changeState(AppState.userEntrance);
  }

  void addForm() {
    setState(() {
      nameControllerList.add(TextEditingController());
      descriptionControllerList.add(TextEditingController());
      formList.add(ExternalFurnitureForm(nameController: nameControllerList.last, descriptionController: descriptionControllerList.last));
    });
  }

  void removeForm() {
    setState(() {
      nameControllerList.removeAt(nameControllerList.length - 1);
      descriptionControllerList.removeAt(descriptionControllerList.length - 1);
      formList.removeAt(formList.length - 1);
    });
  }

  void selectUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }
}

