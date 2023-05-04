import 'package:flutter/material.dart';
import 'package:furniture_store/views/external_furniture_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class CreateIncidentView extends StatelessWidget {
  final User user;
  final Function(AppState val) changeState;
  final VoidCallback logout;
  final TextEditingController incidentTitleController;
  final TextEditingController incidentDescriptionController;
  final VoidCallback createIncident;

  const CreateIncidentView({
    super.key,
    required this.user,
    required this.changeState,
    required this.logout,
    required this.incidentTitleController,
    required this.incidentDescriptionController,
    required this.createIncident
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
              const Text("New incident"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: logout),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getIncidentWidget(),
                ElevatedButton(
                    onPressed: registerIncident,
                    child: const Text("Register Incident")),
              ]
          ),
          ),
        ),
      ),
    );
  }

  Widget getIncidentWidget() {
    return ExternalFurnitureForm(
        nameController: incidentTitleController,
        descriptionController: incidentDescriptionController
    );
  }

  void registerIncident() async {
    createIncident();
    changeState(AppState.mainView);
  }
}