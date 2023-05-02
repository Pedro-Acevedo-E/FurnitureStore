import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';

class AdminMainView extends StatelessWidget {
  final User user;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const AdminMainView({
    super.key,
    required this.user,
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewDatabase,
                          child: const Text("Database")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createUser,
                          child: const Text("Create user")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createFurniture,
                          child: const Text("Create furniture")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: assignFurniture,
                          child: const Text("Assign furniture")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: furnitureList,
                          child: const Text("Furniture List")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createCategory,
                          child: const Text("Create Category")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewLogs,
                          child: const Text("View Logs")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createIncident,
                          child: const Text("Create Incident")
                      ),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: furnitureEntrance,
                          child: const Text("Furniture entrance")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: furnitureExit,
                          child: const Text("Furniture exit")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: userListView,
                          child: const Text("User List")
                      ),
                    ],
                  ),
            ),
        ),
      ),
    );
  }

  void viewDatabase() {
    changeState(AppState.databaseView);
  }

  void createUser() {
    changeState(AppState.createUser);
  }

  void createFurniture() {
    changeState(AppState.createFurniture);
  }

  void assignFurniture() {
    changeState(AppState.assignFurniture);
  }

  void furnitureList() {
    changeState(AppState.furnitureList);
  }

  void createCategory() {
    changeState(AppState.createCategory);
  }

  void viewLogs() {
    changeState(AppState.equipmentLogListView);
  }

  void createIncident() {
    changeState(AppState.createIncident);
  }

  void furnitureExit() {
    changeState(AppState.furnitureExit);
  }

  void furnitureEntrance() {
    changeState(AppState.furnitureEntrance);
  }

  void userListView() {
    changeState(AppState.userList);
  }
}