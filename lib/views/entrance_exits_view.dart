import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class EntranceAndExitsView extends StatelessWidget {
  final User user;
  final List<User> userList;
  final Function(AppState val) changeState;
  final Function(User user) viewUserDetails;
  final VoidCallback viewUserEntrance;
  final Function(User user) viewUserExit;
  final VoidCallback logout;

  const EntranceAndExitsView({
    super.key,
    required this.user,
    required this.userList,
    required this.changeState,
    required this.viewUserDetails,
    required this.viewUserEntrance,
    required this.viewUserExit,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => changeState(AppState.mainView),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Welcome ${user.username}"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: logout),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
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

        floatingActionButton: FloatingActionButton(
          onPressed: viewUserEntrance,
          tooltip: "New entrance",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget getUserListWidgets(List<User> users) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < users.length; i++){
      if (users[i].entranceTime != "") {
        list.add(Row(
          children: [
            Text(users[i].username),
            const Spacer(),
            Text(users[i].internal),
            const Spacer(),
            Text(users[i].external),
            const Spacer(),
            Text(users[i].entranceTime),
            const Spacer(),
            TextButton(
                onPressed: () => userDetails(users[i]),
                child: const Text("Details")
            ),
            TextButton(
                onPressed: () => viewUserExit(users[i]),
                child: const Text("Exit")
            ),
          ])
        );
      }
    }
    return Column(children: list);
  }

  void userDetails(User user) {
    viewUserDetails(user);
  }

  void userExit(User user) {
    viewUserExit(user);
  }
}