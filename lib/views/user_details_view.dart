import 'package:flutter/material.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class UserDetailsView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final List<EquipmentExt> extList;
  final List<EquipmentInt> intList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final AppState lastState;

  const UserDetailsView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.extList,
    required this.intList,
    required this.changeState,
    required this.logout,
    required this.lastState,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => changeState(lastState),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Details of: ${selectedUser.username}"),
              const Spacer(),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text("User Data:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                DetailsRowView(field: "ID", value: selectedUser.id.toString()),
                DetailsRowView(field: "Username", value: selectedUser.username),
                DetailsRowView(field: "FirstName", value: selectedUser.firstName),
                DetailsRowView(field: "LastName", value: selectedUser.lastName),
                DetailsRowView(field: "Entrance Time", value: selectedUser.entranceTime),
                const Text("Internal equipment:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                getIntEquipmentListWidgets(intList),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                const Text("External equipment:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                getExtEquipmentListWidgets(extList),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                DetailsRowView(field: "Access", value: selectedUser.access),
              ],
            ),
          ),
      ),
    );
  }


  Widget getExtEquipmentListWidgets(List<EquipmentExt> equipmentList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < equipmentList.length; i++){
      if (equipmentList[i].user == selectedUser.username) {
        list.add(
            Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(flex: 6, child: Text("Equipment ${equipmentList[i].id}: ${equipmentList[i].name} ")),
                  const Spacer(flex: 1),
                  Expanded(flex: 10, child: Text("Description: ${equipmentList[i].description}")),
                  const Spacer(flex: 1),
                ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getIntEquipmentListWidgets(List<EquipmentInt> equipmentList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < equipmentList.length; i++){
      if (equipmentList[i].user == selectedUser.username) {
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(flex: 6, child: Text("Equipment ${equipmentList[i].id}: ${equipmentList[i].name} ")),
              const Spacer(flex: 1),
              Expanded(flex: 10, child: Text("Description: ${equipmentList[i].description}")),
              const Spacer(flex: 1),
            ])
        );
      }
    }
    return Column(children: list);
  }
}