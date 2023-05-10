import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/entrances_exits_controller.dart';
import 'package:furniture_store/controllers/incident_controller.dart';
import 'package:furniture_store/views/input_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../models.dart';

class UserEntranceView extends StatelessWidget {
  final User user;
  final List<EquipmentInt> intList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final EntrancesAndExitsController entrancesAndExitsController;

  const UserEntranceView({
    super.key,
    required this.user,
    required this.intList,
    required this.changeState,
    required this.logout,
    required this.entrancesAndExitsController
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
              const Text("New entrance"),
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
                  const SizedBox(height: 90),
                  Row(
                    children: [
                      const Spacer(),
                      const Text("Select User: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      DropdownButton(
                          value: entrancesAndExitsController.selectedUser,
                          icon: const Icon(Icons.arrow_downward),
                          items: entrancesAndExitsController.filteredUserList.map((User value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value.username),
                            );
                          }).toList(),
                          onChanged: (User? value) {
                            electUser(value);
                          },
                      ),
                      const Spacer(),
                    ]),
                  const SizedBox(height: 20),
                  const Text("Internal equipment:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  getIntListWidgets(),
                  const SizedBox(height: 20),
                  Row(children: [
                    const Spacer(),
                    const Text("External Equipment?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(onPressed: entrancesAndExitsController.addForm, icon: const Icon(Icons.add)),
                    IconButton(onPressed: entrancesAndExitsController.removeForm, icon: const Icon(Icons.remove)),
                    const Spacer(),
                  ]),
                  getFormListWidgets(),
                  getIncidentWidget(),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ElevatedButton(
                      onPressed: entrancesAndExitsController.createEntrance,
                      child: const Text("Register Entrance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 90),
              ],
            ),
          ),
      ),
    );
  }

  Widget getFormListWidgets() {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < entrancesAndExitsController.formList.length; i++){
        list.add(
            ExternalFurnitureForm(
                nameController: entrancesAndExitsController.nameControllerList[i],
                descriptionController: entrancesAndExitsController.descriptionControllerList[i])
        );
        list.add(const Padding(padding: EdgeInsets.only(top: 10)));
    }
    return Column(children: list);
  }

  Widget getIntListWidgets() {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < intList.length; i++){
      if (entrancesAndExitsController.selectedUser?.username == intList[i].user) {
        list.add(
            Row(children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Text("Item ${intList[i].id}: ${intList[i].name}\n${intList[i].description}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
              ),
              const Spacer(),
            ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getIncidentWidget() {
    if (entrancesAndExitsController.showIncidentForm) {
      return Column(
        children: [
          Row(children: [
            const Spacer(),
            const Text("Incident?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(onPressed: entrancesAndExitsController.toggleIncidentForm, icon: const Icon(Icons.close)),
            const Spacer(),
          ]),
          ExternalFurnitureForm(
              nameController: entrancesAndExitsController.incidentController.incidentTitleController,
              descriptionController: entrancesAndExitsController.incidentController.incidentDescriptionController
          ),
        ],
      );
    } else {
      return Row(children: [
        const Spacer(),
        const Text("Incident?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(onPressed: entrancesAndExitsController.toggleIncidentForm, icon: const Icon(Icons.check)),
        const Spacer(),
      ]);
    }
  }


  void electUser(User? value) {
    if(value != null) {
      entrancesAndExitsController.selectUser(value);
    }
  }
}