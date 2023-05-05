import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/create_incident_view.dart';
import 'package:furniture_store/views/entrance_exits_view.dart';
import 'package:furniture_store/views/input_form.dart';
import 'package:furniture_store/views/int_furniture_list_view.dart';
import 'package:furniture_store/views/log_details_view.dart';
import 'package:furniture_store/views/log_list_view.dart';
import 'package:furniture_store/views/login_view.dart';
import 'package:furniture_store/views/main_view.dart';
import 'package:furniture_store/views/user_details_view.dart';
import 'package:furniture_store/views/user_entrance_view.dart';
import 'package:furniture_store/views/user_exit_view.dart';

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
  AppState lastState = AppState.loginScreen;

  //login
  AppState appState = AppState.loginScreen;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var alertText = "";

  //entrance & exits
  List<User> filteredUserList = [];
  List<Widget> formList = [];
  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> descriptionControllerList = [];
  bool showIncidentForm = false;
  final incidentTitleController = TextEditingController();
  final incidentDescriptionController = TextEditingController();

  //logs
  List<Log> incidentsList = [];
  List<Log> userLogList = [];
  Log selectedLog = Log.empty();

  EquipmentInt selectedInt = EquipmentInt.empty();
  EquipmentInt selectedExt = EquipmentInt.empty();

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
    final userLogData = await SQLHelper.getList("user_log");
    final incidentsLogData = await SQLHelper.getList("incident_log");
    if (kDebugMode) {
      print("We have ${userData.length} users in our database");
      print("We have ${categoryData.length} categories in our database");
      print("We have ${intFurnitureData.length} internal furniture in our database");
      print("We have ${extFurnitureData.length} external furniture in our database");
      print("We have ${userLogData.length} user logs in our database");
      print("We have ${incidentsLogData.length} incidents logs in our database");
    }
  }

  void createDemo() async {
    final phoneCategoryData = await SQLHelper.createCategory("Phone", "Mobile phone devices");
    final pcCategoryData = await SQLHelper.createCategory("PC", "Personal computer");
    final laptopCategoryData = await SQLHelper.createCategory("Laptop", "Portable personal computers");
    final user1 = await SQLHelper.createUser(User.demo1());
    final user2 = await SQLHelper.createUser(User.demo2());
    final user3 = await SQLHelper.createUser(User.demo3());
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
      }
      case AppState.mainView: {
        return MainView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      }
      case AppState.entrancesAndExits: {
        return EntranceAndExitsView(
            user: loginUser,
            userList: userList,
            changeState: (AppState state) => changeState(state),
            viewUserDetails: (User user) => viewUserDetails(user),
            viewUserEntrance: () => viewUserEntrance(),
            viewUserExit: (User user) => viewUserExit(user),
            logout: () => logout());
      }
      case AppState.userDetails: {
        return UserDetailsView(
            user: loginUser,
            selectedUser: selectedUser,
            extList: extList,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            lastState: lastState);
      }
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
            createEntrance: () => createEntrance(),
            toggleIncidentForm: () => toggleIncidentForm(),
            showIncidentForm: showIncidentForm,
            incidentTitleController: incidentTitleController,
            incidentDescriptionController: incidentDescriptionController,
            formList: formList,
            nameControllerList: nameControllerList,
            descriptionControllerList: descriptionControllerList);
      }
      case AppState.userExit: {
        return UserExitView(
            user: loginUser,
            selectedUser: selectedUser,
            intList: intList,
            extList: extList,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            createExit: () => createExit(),
            toggleIncidentForm: () => toggleIncidentForm(),
            showIncidentForm: showIncidentForm,
            incidentTitleController: incidentTitleController,
            incidentDescriptionController: incidentDescriptionController
        );
      }
      case AppState.createIncident: {
        return CreateIncidentView(
            user: loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            incidentTitleController: incidentTitleController,
            incidentDescriptionController: incidentDescriptionController,
            createIncident: () => createIncident()
        );
      }
      case AppState.incidentLog: {
        return LogListView(
            title: "Incidents",
            user: loginUser,
            logList: incidentsList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => logout()
        );
      }
      case AppState.userLog: {
        return LogListView(
            title: "Entrance and Exit",
            user: loginUser,
            logList: userLogList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => logout()
        );
      }
      case AppState.logDetails: {
        return LogDetailsView(
            user: loginUser,
            selectedLog: selectedLog,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            lastState: lastState,
        );
      }
      case AppState.internalFurniture: {
        return IntFurnitureView(
            user: loginUser,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            viewInternalFurnitureDetails: viewInternalFurnitureDetails,
            deleteInternalFurniture: deleteInternalFurniture,
            editInternalFurniture: editInternalFurniture,
            createInternalFurniture: () => createInternalFurniture(),
            logout: () => logout()
        );
      }
      default: {
        return Text(appState.toString());
      }
    }
  }

  void changeState(AppState state) {
    refreshList();
    setState(() {
      lastState = appState;
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
    final iLog = await SQLHelper.getList("incident_log");
    final uLog = await SQLHelper.getList("user_log");

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
    List<Log> uTempLog = [];
    for(var i = 0; i < uLog.length; i++) {
      uTempLog.add(Log(
          id: uLog.elementAt(i)["id"],
          title: uLog.elementAt(i)["title"],
          createdBy: uLog.elementAt(i)["created_by"],
          description: uLog.elementAt(i)["description"],
          createdAt: uLog.elementAt(i)["created_at"].toString()));
    }
    List<Log> iTempLog = [];
    for(var i = 0; i < iLog.length; i++) {
      iTempLog.add(Log(
          id: iLog.elementAt(i)["id"],
          title: iLog.elementAt(i)["title"],
          createdBy: iLog.elementAt(i)["created_by"],
          description: iLog.elementAt(i)["description"],
          createdAt: iLog.elementAt(i)["created_at"].toString()));
    }

    setState(() {
      userList = tempUserList;
      extList = tempExtList;
      intList = tempIntList;
      incidentsList = iTempLog;
      userLogList = uTempLog;
    });
  }

  void viewUserDetails(User user) {
    selectUser(user);
    changeState(AppState.userDetails);
  }

  void viewLogDetails(Log log) {
    setState(() {
      selectedLog = log;
    });
    changeState(AppState.logDetails);
  }

  void viewInternalFurnitureDetails(EquipmentInt data) {
    setState(() {
       selectedInt = data;
    });
    changeState(AppState.internalDetails);
  }

  void editInternalFurniture(EquipmentInt data) {
    setState(() {
      selectedInt = data;
    });
    changeState(AppState.internalEdit);
  }

  void deleteInternalFurniture(EquipmentInt data) {
    setState(() {
      selectedInt = data;
    });
    changeState(AppState.internalDelete);
  }

  void createInternalFurniture() {
    changeState(AppState.internalCreate);
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
      showIncidentForm = false;
      filteredUserList = tempUserList;
      selectedUser = filteredUserList[0];
      formList = [];
      nameControllerList = [];
      descriptionControllerList = [];
      incidentTitleController.text = "";
      incidentDescriptionController.text = "";
    });
    //add if to check if filtered list is empty to show that there R no members outside
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

  void createEntrance() async {
    selectedUser.entranceTime = "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}";
    var descriptionString = "User entered Office";

    if (formList.isNotEmpty) {
      selectedUser.external = "yes";
      for(var i = 0; i < formList.length;i++) {
        final tempEquipmentExt = EquipmentExt(
            id: 0,
            user: selectedUser.username,
            name: nameControllerList[i].text,
            description: descriptionControllerList[i].text,
            createdAt: ""
        );
        descriptionString = "$descriptionString \nWith external equipment ${tempEquipmentExt.name}";
        final data = await SQLHelper.createEquipmentExt(tempEquipmentExt);
        if (kDebugMode) {
          print("Created External Equipment $data");
        }
      }
    }

    updateInternal(selectedUser, "Office");

    final userData = await SQLHelper.updateUser(selectedUser.id, selectedUser);

    final logData = Log(
        id: 0,
        title: "${selectedUser.username} Has entered Office at ${selectedUser.entranceTime}",
        createdBy: loginUser.username,
        description: descriptionString,
        createdAt: ""
    );
    final userLogData = await SQLHelper.createLog(logData, "user_log");

    createIncident();

    if (kDebugMode) {
      print("Updated User $userData");
      print("Created User Log $userLogData");
    }

    changeState(AppState.entrancesAndExits);
  }

  void viewUserExit(User user) async {
    setState(() {
      selectedUser = user;
      showIncidentForm = false;
      incidentDescriptionController.text = "";
      incidentDescriptionController.text = "";
    });

    changeState(AppState.userExit);
  }

  void createExit() async {
    selectedUser.entranceTime = "";
    var descriptionString = "User Exited Office";
    if(selectedUser.external == "yes" || selectedUser.external == "Yes") {
      selectedUser.external = "no";
      for(var i = 0; i < extList.length; i++) {
        if(extList[i].user == selectedUser.username) {
          descriptionString = "$descriptionString \nExited with ${extList[i].name}";
          SQLHelper.deleteItem(extList[i].id, "equipment_ext");
        }
      }
    }

    updateInternal(selectedUser, "Outside");

    final userData = await SQLHelper.updateUser(selectedUser.id, selectedUser);

    final logData = Log(
        id: 0,
        title: "${selectedUser.username} Has exited Office at ${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}",
        createdBy: loginUser.username,
        description: descriptionString,
        createdAt: ""
    );
    final userLogData = await SQLHelper.createLog(logData, "user_log");

    createIncident();

    if (kDebugMode) {
      print("Updated User $userData");
      print("Created User Log $userLogData");
    }

    changeState(AppState.entrancesAndExits);
  }

  void updateInternal(User user, String location) async {
    for (var i = 0; i < intList.length; i++) {
      if(intList[i].user == user.username) {
        intList[i].location = "$location with ${user.username}";
        final data = await SQLHelper.updateEquipmentInt(intList[i].id, intList[i]);
        if (kDebugMode) {
          print("Updated Internal Equipment $data");
        }
      }
    }
  }

  void createIncident() async {
    if(incidentTitleController.text.isNotEmpty && incidentDescriptionController.text.isNotEmpty) {
      final incidentLogData = Log(
          id: 0,
          title: incidentTitleController.text,
          createdBy: loginUser.username,
          description: incidentDescriptionController.text,
          createdAt: ""
      );
      final incidentData = await SQLHelper.createLog(incidentLogData, "incident_log");
      if (kDebugMode) {
        print("Created Incident Log $incidentData");
      }
    }
  }

  void toggleIncidentForm() {
    setState(() {
      incidentDescriptionController.text = "";
      incidentTitleController.text = "";
      if (showIncidentForm == true) {
        showIncidentForm = false;
      } else {
        showIncidentForm = true;
      }
    });
  }

  void selectUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }
}

