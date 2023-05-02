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
                      changeState(AppState.userView);
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
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: viewDatabase,
                      child: const Text("Database")
                  ),
                  ElevatedButton(
                      onPressed: createUser,
                      child: const Text("Create user")
                  ),
                  ElevatedButton(
                      onPressed: createFurniture,
                      child: const Text("Create furniture")
                  ),
                  ElevatedButton(
                      onPressed: createCategory,
                      child: const Text("Create category")
                  ),
                  ElevatedButton(
                      onPressed: viewLogs,
                      child: const Text("View Logs")
                  ),
                ],
              ),
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

  void createCategory() {
    changeState(AppState.createCategory);
  }

  void viewLogs() {
    changeState(AppState.equipmentLogView);
  }
}