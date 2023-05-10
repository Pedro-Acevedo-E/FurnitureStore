import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/login_controller.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../controllers/entrances_exits_controller.dart';
import '../../models.dart';

class EntranceAndExitsView extends StatelessWidget {
  final List<User> userList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final Function(User user) viewUserDetails;
  final EntrancesAndExitsController entrancesAndExitsController;

  const EntranceAndExitsView({
    super.key,
    required this.userList,
    required this.changeState,
    required this.logout,
    required this.viewUserDetails,
    required this.entrancesAndExitsController,
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
              const Text("Entrances & Exits"),
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
                const SizedBox(height: 20),
                Row(
                    children: const [
                      Spacer(),
                      Expanded(
                          flex: 18,
                          child: Text("Username")
                      ),
                      Spacer(flex: 1),
                      Expanded(
                          flex: 6,
                          child: Text("Entrance")
                      ),
                      Spacer(),
                      Expanded(
                          flex: 5,
                          child: Text("Details")
                      ),
                      Spacer(),
                      Expanded(
                          flex: 4,
                          child: Text("Exits")
                      ),
                      Spacer(),
                    ]),
                const SizedBox(height: 20),
                getUserListWidgets(userList),
              ],
            ),
          ),

        floatingActionButton: FloatingActionButton(
          onPressed: entrancesAndExitsController.viewUserEntrance,
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
            const Spacer(),
            Expanded(
                flex: 18,
                child: Text(users[i].username)
            ),
            const Spacer(flex: 5),
            Expanded(
                flex: 6,
                child: Text(users[i].entranceTime)
            ),
            const Spacer(),
            Expanded(
                flex: 5,
                child: IconButton(
                    onPressed: () => userDetails(users[i]),
                    icon: const Icon(Icons.find_in_page)
                ),
            ),
            const Spacer(flex: 1),
            Expanded(
                flex: 6,
                child: TextButton(
                    onPressed: () => entrancesAndExitsController.viewUserExit(users[i]),
                    child: const Text("Exit")
                ),
            ),
            const Spacer(),
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
    entrancesAndExitsController.viewUserExit(user);
    //viewUserExit(user);
  }
}