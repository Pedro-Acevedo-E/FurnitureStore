import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: entranceAndExits,
                          child: const Text("Entrances and exits")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createFurniture,
                          child: const Text("Create Internal furniture")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: assignFurniture,
                          child: const Text("Assign furniture")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: createIncident,
                          child: const Text("Create Incident")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewIncidentLogs,
                          child: const Text("Incident Log")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewUserLogs,
                          child: const Text("User Log")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewExternalFurniture,
                          child: const Text("External furniture")
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                          onPressed: viewInternalFurniture,
                          child: const Text("Internal furniture")
                      ),
                    ],
                  ),
            ),
        ),
      ),
    );
  }

  void entranceAndExits() {
    changeState(AppState.entrancesAndExits);
  }

  void createFurniture() {
    changeState(AppState.createInternalFurniture);
  }

  void assignFurniture() {
    changeState(AppState.assignFurniture);
  }

  void createIncident() {
    changeState(AppState.createIncident);
  }

  void viewIncidentLogs() {
    changeState(AppState.incidentLog);
  }

  void viewUserLogs() {
    changeState(AppState.userLog);
  }

  void viewInternalFurniture() {
    changeState(AppState.internalFurniture);
  }

  void viewExternalFurniture() {
    changeState(AppState.externalFurniture);
  }
}