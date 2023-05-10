import 'package:flutter/material.dart';
import 'package:furniture_store/views/input_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../controllers/entrances_exits_controller.dart';
import '../../models.dart';

class UserExitView extends StatelessWidget {
  final List<EquipmentInt> intList;
  final List<EquipmentExt> extList;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final EntrancesAndExitsController entrancesAndExitsController;

  const UserExitView({
    super.key,
    required this.intList,
    required this.extList,
    required this.changeState,
    required this.logout,
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
                  onPressed: () => changeState(AppState.entrancesAndExits),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              const Text("New exit"),
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
              const SizedBox(height: 50),
              Row(
                  children: [
                    const Spacer(),
                    Row(children: [
                      const Text("User ", style: TextStyle(fontSize: 18)),
                      Text(entrancesAndExitsController.selectedUser!.username, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text(" is about to exit office", style: TextStyle(fontSize: 18)),
                    ]),
                    const Spacer(),
                  ]),
              const SizedBox(height: 20),
              const Text("Internal equipment:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              getIntListWidgets(),
              const SizedBox(height: 20),
              const Text("External equipment:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              getExtListWidgets(),
              const SizedBox(height: 20),
              getIncidentWidget(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: entrancesAndExitsController.createExit,
                child: const Text("Register Exit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      if (entrancesAndExitsController.selectedUser!.username == intList[i].user) {
        list.add(
            Row(children: [
              const Spacer(),
              Expanded(
                  flex: 7,
                  child: Text("Item ${intList[i].id}: ${intList[i].name}\n${intList[i].description}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)
                  ),
              ),
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
      if (entrancesAndExitsController.selectedUser!.username == extList[i].user) {
        list.add(
            Row(children: [
              const Spacer(),
              Expanded(
                flex: 7,
                child: Text("Item ${extList[i].id}: ${extList[i].name}\n${extList[i].description}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)
                ),
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
}