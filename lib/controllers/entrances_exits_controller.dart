import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/controllers/incident_controller.dart';
import 'package:furniture_store/models.dart';
import 'package:furniture_store/views/entrances_and_exits/entrance_exits_view.dart';

import '../app_state.dart';
import '../sql_helper.dart';
import '../views/input_form.dart';

class EntrancesAndExitsController {
  late final User loginUser;
  List<User> filteredUserList = [];
  List<Widget> formList = [];
  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> descriptionControllerList = [];
  IncidentController incidentController = IncidentController();
  User? selectedUser;
  bool showIncidentForm = false;
  late final Function(AppState state) changeState;
  late final VoidCallback refresh;

  EntrancesAndExitsController(this.loginUser, this.changeState, this.refresh);

  void reset() {
    filteredUserList = [];
    formList = [];
    nameControllerList = [];
    descriptionControllerList = [];
    showIncidentForm = false;
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
          access: data.elementAt(i)["access"]));
    }
    showIncidentForm = false;
    filteredUserList = tempUserList;
    selectedUser = null;
    formList = [];
    nameControllerList = [];
    descriptionControllerList = [];
    incidentController.reset();

    changeState(AppState.userEntrance);
  }

  void addForm() {
      nameControllerList.add(TextEditingController());
      descriptionControllerList.add(TextEditingController());
      formList.add(ExternalFurnitureForm(nameController: nameControllerList.last, descriptionController: descriptionControllerList.last));
      refresh();
  }

  void removeForm() {
      nameControllerList.removeAt(nameControllerList.length - 1);
      descriptionControllerList.removeAt(descriptionControllerList.length - 1);
      formList.removeAt(formList.length - 1);
      refresh();
  }

  void createEntrance() async {
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      selectedUser.entranceTime = "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}";
      var descriptionString = "User entered Office";

      if (formList.isNotEmpty) {
        for (var i = 0; i < formList.length; i++) {
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
          title: "${selectedUser.username} Has entered Office at ${selectedUser
              .entranceTime}",
          createdBy: loginUser.username,
          description: descriptionString,
          createdAt: ""
      );
      final userLogData = await SQLHelper.createLog(logData, "user_log");

      incidentController.create(loginUser);

      if (kDebugMode) {
        print("Updated User $userData");
        print("Created User Log $userLogData");
      }

      changeState(AppState.entrancesAndExits);
    }
  }

  void viewUserExit(User user) async {
    selectedUser = user;
    showIncidentForm = false;
    incidentController.reset();
    changeState(AppState.userExit);
  }

  void createExit() async {
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      selectedUser.entranceTime = "";
      var descriptionString = "User Exited Office";
      final extList = await SQLHelper.getList("equipment_ext");
      for (var i = 0; i < extList.length; i++) {
        if (extList.elementAt(i)["user"] == selectedUser.username) {
          descriptionString = "$descriptionString \nExited with ${extList.elementAt(i)["name"]}";
          SQLHelper.deleteItem(extList.elementAt(i)["id"], "equipment_ext");
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
          createdBy: loginUser.username,
          description: descriptionString,
          createdAt: ""
      );
      final userLogData = await SQLHelper.createLog(logData, "user_log");

      incidentController.create(loginUser);

      if (kDebugMode) {
        print("Updated User $userData");
        print("Created User Log $userLogData");
      }

      changeState(AppState.entrancesAndExits);
    }
  }

  void updateInternal(User user, String location) async {
    final intList = await SQLHelper.getList("equipment_int");
    for (var i = 0; i < intList.length; i++) {
      if(intList.elementAt(i)["user"] == user.username) {
        final temp = EquipmentInt(
            id: intList.elementAt(i)["id"],
            user: intList.elementAt(i)["user"],
            location: "$location with ${user.username}",
            status: intList.elementAt(i)["status"],
            productId: intList.elementAt(i)["product_id"],
            name: intList.elementAt(i)["name"],
            description: intList.elementAt(i)["description"],
            category: intList.elementAt(i)["category"],
            model: intList.elementAt(i)["model"],
            weight: intList.elementAt(i)["weight"],
            dimensions: intList.elementAt(i)["dimensions"],
            color_1: intList.elementAt(i)["color_1"],
            color_2: intList.elementAt(i)["color_2"],
            notes: intList.elementAt(i)["notes"],
            createdAt: intList.elementAt(i)["created_at"].toString()
        );
        final data = await SQLHelper.updateEquipmentInt(intList.elementAt(i)["id"], temp);
        if (kDebugMode) {
          print("Updated Internal Equipment $data");
        }
      }
    }
  }

  void toggleIncidentForm() {
      incidentController.reset();
      if (showIncidentForm == true) {
        showIncidentForm = false;
      } else {
        showIncidentForm = true;
      }
      refresh();
  }

  void selectUser(User user) {
      selectedUser = user;
      refresh();
  }
}