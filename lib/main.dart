import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/controllers/demo_controller.dart';
import 'package:furniture_store/controllers/external_furniture_controller.dart';
import 'package:furniture_store/controllers/internal_furniture_controller.dart';
import 'package:furniture_store/controllers/login_controller.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/create_external_form.dart';
import 'package:furniture_store/views/create_incident_view.dart';
import 'package:furniture_store/views/create_internal_form.dart';
import 'package:furniture_store/views/delete_internal_furniture_view.dart';
import 'package:furniture_store/views/entrance_exits_view.dart';
import 'package:furniture_store/views/ext_furniture_list_view.dart';
import 'package:furniture_store/views/external_furniture_details.dart';
import 'package:furniture_store/views/internal_furniture_details_view.dart';
import 'package:furniture_store/views/input_form.dart';
import 'package:furniture_store/views/int_furniture_list_view.dart';
import 'package:furniture_store/views/log_details_view.dart';
import 'package:furniture_store/views/log_list_view.dart';
import 'package:furniture_store/views/login_view.dart';
import 'package:furniture_store/views/main_view.dart';
import 'package:furniture_store/views/user_details_view.dart';
import 'package:furniture_store/views/user_entrance_view.dart';
import 'package:furniture_store/views/user_exit_view.dart';

import 'controllers/incident_controller.dart';
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
  AppState appState = AppState.loginScreen;
  AppState lastState = AppState.loginScreen;
  List<User> userList = [];
  List<EquipmentExt> extList = [];
  List<EquipmentInt> intList = [];
  List<EquipmentCategory> categoryList = [];
  List<Log> incidentsList = [];
  List<Log> userLogList = [];

  User? selectedUser;
  EquipmentInt? selectedInt;
  EquipmentExt? selectedExt;
  EquipmentCategory? selectedCategory;
  Log? selectedLog;

  final demoController = DemoController();
  final loginController = LoginController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var alertText = "";

  //entrance & exits
  List<User> filteredUserList = [];
  List<Widget> formList = [];
  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> descriptionControllerList = [];
  bool showIncidentForm = false;

  final externalController = ExternalController();
  final incidentController = IncidentController();
  final internalController = InternalController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainView(),
    );
  }

  @override
  void initState() {
    super.initState();
    //demoController.createDemo();
    demoController.loadItemsDemo();
  }

  Widget mainView() {
    switch(appState){
      case AppState.loginScreen: {
        return LoginView(
            loginController: loginController,
            login: () => login(),
        );
      }
      case AppState.mainView: {
        return MainView(
            user: loginController.loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout());
      }
      case AppState.entrancesAndExits: {
        return EntranceAndExitsView(
            user: loginController.loginUser,
            userList: userList,
            changeState: (AppState state) => changeState(state),
            viewUserDetails: (User user) => viewUserDetails(user),
            viewUserEntrance: () => viewUserEntrance(),
            viewUserExit: (User user) => viewUserExit(user),
            logout: () => logout());
      }
      case AppState.userDetails: {
        final selectedUser = this.selectedUser;
        if (selectedUser != null) {
          return UserDetailsView(
              user: loginController.loginUser,
              selectedUser: selectedUser,
              extList: extList,
              intList: intList,
              changeState: (AppState state) => changeState(state),
              logout: () => logout(),
              lastState: lastState);
        } else {
          return const Text("Error");
        }
      }
      case AppState.userEntrance: {
        return UserEntranceView(
            user: loginController.loginUser,
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
            incidentController: incidentController,
            formList: formList,
            nameControllerList: nameControllerList,
            descriptionControllerList: descriptionControllerList);
      }
      case AppState.userExit: {
        final selectedUser = this.selectedUser;
        if (selectedUser != null) {
          return UserExitView(
              user: loginController.loginUser,
              selectedUser: selectedUser,
              intList: intList,
              extList: extList,
              changeState: (AppState state) => changeState(state),
              logout: () => logout(),
              createExit: () => createExit(),
              toggleIncidentForm: () => toggleIncidentForm(),
              showIncidentForm: showIncidentForm,
              incidentController: incidentController,
          );
        } else {
          return const Text("Error");
        }
      }
      case AppState.createIncident: {
        return CreateIncidentView(
            user: loginController.loginUser,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            incidentController: incidentController,
        );
      }
      case AppState.incidentLog: {
        return LogListView(
            title: "Incidents",
            user: loginController.loginUser,
            logList: incidentsList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => logout()
        );
      }
      case AppState.userLog: {
        return LogListView(
            title: "Entrance and Exit",
            user: loginController.loginUser,
            logList: userLogList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => logout()
        );
      }
      case AppState.logDetails: {
        final selectedLog = this.selectedLog;
        if(selectedLog != null) {
          return LogDetailsView(
            user: loginController.loginUser,
            selectedLog: selectedLog,
            changeState: (AppState state) => changeState(state),
            logout: () => logout(),
            lastState: lastState,
          );
        } else {
          return const Text("Error");
        }
      }
      case AppState.internalFurniture: {
        return IntFurnitureView(
            user: loginController.loginUser,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            viewInternalFurnitureDetails: viewInternalFurnitureDetails,
            viewDeleteInternalFurniture: viewDeleteInternalFurniture,
            editInternalFurniture: editInternalFurniture,
            viewCreateInternalFurniture: viewCreateInternalFurniture,
            logout: () => logout()
        );
      }
      case AppState.externalFurniture: {
        return ExtFurnitureView(
            user: loginController.loginUser,
            extList: extList,
            changeState: changeState,
            viewExternalFurnitureDetails: viewExternalFurnitureDetails,
            deleteExternalFurniture: deleteExternalFurniture,
            editExternalFurniture: editExternalFurniture,
            viewCreateExternalFurniture: viewCreateExternalFurniture,
            logout: logout);
      }
      case AppState.externalCreate: {
        return CreateExternalView(
            user: loginController.loginUser,
            selectedUser: selectedUser,
            externalController: externalController,
            userList: userList,
            createExternalFurniture: createExternalFurniture,
            selectUser: (User user) => selectUser(user),
            logout: logout,
            changeState: changeState);
      }
      case AppState.internalCreate: {
        return CreateInternalView(
            user: loginController.loginUser,
            selectedUser: selectedUser,
            selectedCategory: selectedCategory,
            internalController: internalController,
            userList: userList,
            categoryList: categoryList,
            createInternalFurniture: createInternalFurniture,
            selectUser: (User user) => selectUser(user),
            selectCategory: (EquipmentCategory cat) => selectCategory(cat),
            logout: logout,
            changeState: changeState
        );
      }
      case AppState.internalDetails: {
        final selectedInt = this.selectedInt;
        if (selectedInt != null) {
          return InternalDetailsView(
              user: loginController.loginUser,
              selectedInt: selectedInt,
              changeState: changeState,
              logout: logout
          );
        } else {
          return const Text("Error");
        }
      }
      case AppState.externalDetails: {
        final selectedExt = this.selectedExt;
        if (selectedExt != null) {
          return ExternalDetailsView(
              user: loginController.loginUser,
              selectedExt: selectedExt,
              changeState: changeState,
              logout: logout
          );
        } else {
          return const Text("Error");
        }
      }
      case AppState.internalDelete: {
        final selectedInt = this.selectedInt;
        if (selectedInt != null) {
          return DeleteInternalView(
              user: loginController.loginUser,
              selectedInt: selectedInt,
              changeState: changeState,
              deleteInternalFurniture: deleteInternalFurniture,
              logout: logout);
        } else {
          return const Text("Error");
        }
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
      incidentController.reset();
    });
  }

  void login() async {
    final logged = await loginController.login();
    if (logged) {
      changeState(AppState.mainView);
    } else {
      setState(() {});
    }
  }

  void logout() {
    loginController.logout();
    changeState(AppState.loginScreen);
  }

  void refreshList() async {
    final data = await SQLHelper.getList("user");
    final ext = await SQLHelper.getList("equipment_ext");
    final intE = await SQLHelper.getList("equipment_int");
    final iLog = await SQLHelper.getList("incident_log");
    final uLog = await SQLHelper.getList("user_log");
    final cat = await SQLHelper.getList("category");

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
    List<EquipmentCategory> tempCatList = [];
    for(var i = 0; i < cat.length; i++) {
      tempCatList.add(EquipmentCategory(
          id: cat.elementAt(i)["id"],
          name: cat.elementAt(i)["name"],
          description: cat.elementAt(i)["description"])
      );
    }

    setState(() {
      userList = tempUserList;
      extList = tempExtList;
      intList = tempIntList;
      incidentsList = iTempLog;
      userLogList = uTempLog;
      categoryList = tempCatList;
    });
  }

  //CRUD operations############################################################
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

  void viewDeleteInternalFurniture(EquipmentInt data) {
    setState(() {
      selectedInt = data;
    });
    changeState(AppState.internalDelete);
  }

  void deleteInternalFurniture(EquipmentInt data) {
    internalController.delete(data);
    changeState(AppState.internalFurniture);
  }

  void viewCreateInternalFurniture() {
    setState(() {
      selectedUser = null;
      selectedCategory = null;
    });
    changeState(AppState.internalCreate);
  }

  void createInternalFurniture() {
    final selectedCategory = this.selectedCategory;
    if (selectedCategory != null) {
      internalController.create(selectedUser, selectedCategory);
      internalController.reset();
      changeState(AppState.internalFurniture);
    }
  }

  void viewExternalFurnitureDetails(EquipmentExt data) {
    setState(() {
      selectedExt = data;
    });
    changeState(AppState.externalDetails);
  }

  void editExternalFurniture(EquipmentExt data) {
    setState(() {
      selectedExt = data;
    });
    changeState(AppState.externalEdit);
  }
  void deleteExternalFurniture(EquipmentExt data) {
    setState(() {
      selectedExt = data;
    });
    changeState(AppState.externalDelete);
  }

  void viewCreateExternalFurniture() {
    setState(() {
      selectedUser = null;
    });
    changeState(AppState.externalCreate);
  }

  void createExternalFurniture() {
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      externalController.create(selectedUser);
      externalController.reset();
      changeState(AppState.externalFurniture);
    }
  }

  //End CRUD operations ############################################################

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
      selectedUser = null;
      formList = [];
      nameControllerList = [];
      descriptionControllerList = [];
      incidentController.reset();
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
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      selectedUser.entranceTime = "${DateTime
          .now()
          .hour
          .toString()}:${DateTime
          .now()
          .minute
          .toString()}";
      var descriptionString = "User entered Office";

      if (formList.isNotEmpty) {
        selectedUser.external = "yes";
        for (var i = 0; i < formList.length; i++) {
          final tempEquipmentExt = EquipmentExt(
              id: 0,
              user: selectedUser.username,
              name: nameControllerList[i].text,
              description: descriptionControllerList[i].text,
              createdAt: ""
          );
          descriptionString =
          "$descriptionString \nWith external equipment ${tempEquipmentExt
              .name}";
          final data = await SQLHelper.createEquipmentExt(tempEquipmentExt);
          if (kDebugMode) {
            print("Created External Equipment $data");
          }
        }
      }

      updateInternal(selectedUser, "Office");

      final userData = await SQLHelper.updateUser(
          selectedUser.id, selectedUser);

      final logData = Log(
          id: 0,
          title: "${selectedUser.username} Has entered Office at ${selectedUser
              .entranceTime}",
          createdBy: loginController.loginUser.username,
          description: descriptionString,
          createdAt: ""
      );
      final userLogData = await SQLHelper.createLog(logData, "user_log");

      incidentController.create(loginController.loginUser);

      if (kDebugMode) {
        print("Updated User $userData");
        print("Created User Log $userLogData");
      }

      changeState(AppState.entrancesAndExits);
    }
  }

  void viewUserExit(User user) async {
    setState(() {
      selectedUser = user;
      showIncidentForm = false;
      incidentController.reset();
    });
    changeState(AppState.userExit);
  }

  void createExit() async {
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      selectedUser.entranceTime = "";
      var descriptionString = "User Exited Office";
      if (selectedUser.external == "yes" || selectedUser.external == "Yes") {
        selectedUser.external = "no";
        for (var i = 0; i < extList.length; i++) {
          if (extList[i].user == selectedUser.username) {
            descriptionString =
            "$descriptionString \nExited with ${extList[i].name}";
            SQLHelper.deleteItem(extList[i].id, "equipment_ext");
          }
        }
      }

      updateInternal(selectedUser, "Outside");

      final userData = await SQLHelper.updateUser(
          selectedUser.id, selectedUser);

      final logData = Log(
          id: 0,
          title: "${selectedUser.username} Has exited Office at ${DateTime
              .now()
              .hour
              .toString()}:${DateTime
              .now()
              .minute
              .toString()}",
          createdBy: loginController.loginUser.username,
          description: descriptionString,
          createdAt: ""
      );
      final userLogData = await SQLHelper.createLog(logData, "user_log");

      incidentController.create(loginController.loginUser);

      if (kDebugMode) {
        print("Updated User $userData");
        print("Created User Log $userLogData");
      }

      changeState(AppState.entrancesAndExits);
    }
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

  void toggleIncidentForm() {
    setState(() {
      incidentController.reset();
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

  void selectCategory(EquipmentCategory category) {
    setState(() {
      selectedCategory = category;
    });
  }
}

