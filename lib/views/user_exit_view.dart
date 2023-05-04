import 'package:flutter/material.dart';
import 'package:furniture_store/views/external_furniture_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class UserExitView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final List<EquipmentInt> intList;
  final List<EquipmentExt> extList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final VoidCallback createExit;
  final VoidCallback toggleIncidentForm;
  final bool showIncidentForm;
  final TextEditingController incidentTitleController;
  final TextEditingController incidentDescriptionController;

  const UserExitView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.intList,
    required this.extList,
    required this.changeState,
    required this.logout,
    required this.createExit,
    required this.toggleIncidentForm,
    required this.showIncidentForm,
    required this.incidentTitleController,
    required this.incidentDescriptionController,
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
              Text("Create new entrance ${user.username}"),
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
              Row(
                  children: [
                    const Spacer(),
                    Text("User ${selectedUser.username} is about to exit office"),
                    const Spacer(),
                  ]),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text("Internal equipment:"),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              getIntListWidgets(),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text("External equipment:"),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              getExtListWidgets(),
              getIncidentWidget(),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              ElevatedButton(
                onPressed: createExit,
                child: const Text("Register Exit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getIntListWidgets() {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < intList.length; i++){
      if (selectedUser.username == intList[i].user) {
        list.add(
            Row(children: [
              const Spacer(),
              Text("Item ${intList[i].id}: ${intList[i].name} ${intList[i].description}"),
              const Spacer(),
            ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getExtListWidgets() {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < extList.length; i++){
      if (selectedUser.username == extList[i].user) {
        list.add(
            Row(children: [
              const Spacer(),
              Text("Item ${extList[i].id}: ${extList[i].name} ${extList[i].description}"),
              const Spacer(),
            ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getIncidentWidget() {
    if (showIncidentForm) {
      return Column(
        children: [
          Row(children: [
            const Spacer(),
            const Text("Incident?"),
            IconButton(onPressed: toggleIncidentForm, icon: const Icon(Icons.close)),
            const Spacer(),
          ]),
          ExternalFurnitureForm(
              nameController: incidentTitleController,
              descriptionController: incidentDescriptionController
          ),
        ],
      );
    } else {
      return Row(children: [
        const Spacer(),
        const Text("Incident?"),
        IconButton(onPressed: toggleIncidentForm, icon: const Icon(Icons.check)),
        const Spacer(),
      ]);
    }
  }
}