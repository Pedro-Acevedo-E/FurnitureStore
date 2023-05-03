import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';

class UserDetailsView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final List<Map<String, dynamic>> extList;
  final List<Map<String, dynamic>> intList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final VoidCallback returnToMain;


  const UserDetailsView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.extList,
    required this.intList,
    required this.changeState,
    required this.logout,
    required this.returnToMain
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: returnToMain,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Details of: ${selectedUser.username}"),
              const Spacer(),
              PopupMenuButton<PopupSelection>(
                initialValue: PopupSelection.profile,
                onSelected: (PopupSelection item) {
                  switch(item) {
                    case PopupSelection.profile: {
                      changeState(AppState.profile);
                    } break;
                    case PopupSelection.settings: {
                      changeState(AppState.settings);
                    } break;
                    case PopupSelection.logout: {
                      logout();
                    } break;
                    default: {
                      changeState(AppState.error);
                    } break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupSelection>>[
                  const PopupMenuItem(
                      value: PopupSelection.profile,
                      child: Text("Profile")),
                  const PopupMenuItem(
                      value: PopupSelection.settings,
                      child: Text("Settings")),
                  const PopupMenuItem(
                      value: PopupSelection.logout,
                      child: Text("Logout")),
                ],
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("""User Data: 
                Username: ${selectedUser.username}
                FirstName: ${selectedUser.firstName}
                LastName: ${selectedUser.lastName}
                Entrance: ${selectedUser.entranceTime}
                Access: ${selectedUser.access}
                """),
                const Text("Internal Equipment: "),
                getEquipmentListWidgets(intList),
                const Text("External Equipment: "),
                getEquipmentListWidgets(extList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getEquipmentListWidgets(List<Map<String, dynamic>> equipmentList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < equipmentList.length; i++){
      if (equipmentList.elementAt(i)["user"] == selectedUser.username) {
        list.add(Row(
            children: [
              Text("Equipment ${i + 1}: ${equipmentList.elementAt(i)["name"]}"),
            ])
        );
      }
    }
    return Column(children: list);
  }
}