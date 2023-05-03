import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class UserDetailsView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final List<Map<String, dynamic>> extList;
  final List<Map<String, dynamic>> intList;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const UserDetailsView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.extList,
    required this.intList,
    required this.changeState,
    required this.logout
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => changeState(AppState.entrancesAndExits),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Details of: ${selectedUser.username}"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: logout),
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
              Text("Equipment ${equipmentList.elementAt(i)["id"]}: ${equipmentList.elementAt(i)["name"]} "),
              Text("Description: ${equipmentList.elementAt(i)["description"]}"),
            ])
        );
      }
    }
    return Column(children: list);
  }
}