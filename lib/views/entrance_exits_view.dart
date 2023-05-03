import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';

class EntranceAndExitsView extends StatelessWidget {
  final User user;
  final List<Map<String, dynamic>> userList;
  final Function(AppState val) changeState;
  final Function(Map<String, dynamic> data) viewUserDetails;
  final VoidCallback logout;
  final VoidCallback returnToMain;


  const EntranceAndExitsView({
    super.key,
    required this.user,
    required this.userList,
    required this.changeState,
    required this.viewUserDetails,
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
              Text("Welcome ${user.username}"),
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
                Row(
                    children: const [
                      Spacer(),
                      Text("Username"),
                      Spacer(),
                      Text("Internal"),
                      Spacer(),
                      Text("External"),
                      Spacer(),
                      Text("Entrance"),
                      Spacer(),
                      Text("Details"),
                      Spacer(),
                      Text("Exits"),
                      Spacer(),
                    ]),
                getUserListWidgets(userList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getUserListWidgets(List<Map<String, dynamic>> users) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < users.length; i++){
      if (users.elementAt(i)["entrance_time"] != "") {
        list.add(Row(
          children: [
            Text(users.elementAt(i)["username"]),
            const Spacer(),
            Text(users.elementAt(i)["internal"]),
            const Spacer(),
            Text(users.elementAt(i)["external"]),
            const Spacer(),
            Text(users.elementAt(i)["entrance_time"]),
            const Spacer(),
            TextButton(
                onPressed: () => userDetails(users.elementAt(i)),
                child: const Text("Details")
            ),
            TextButton(
                onPressed: () {},
                child: const Text("Exit")
            ),
          ])
        );
      }
    }
    return Column(children: list);
  }

  void userDetails(Map<String, dynamic> user) {
    viewUserDetails(user);
  }
}