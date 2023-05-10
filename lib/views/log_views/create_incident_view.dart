import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/incident_controller.dart';
import 'package:furniture_store/controllers/login_controller.dart';
import 'package:furniture_store/views/input_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';

class CreateIncidentView extends StatelessWidget {
  final LoginController loginController;
  final Function(AppState val) changeState;
  final IncidentController incidentController;

  const CreateIncidentView({
    super.key,
    required this.loginController,
    required this.changeState,
    required this.incidentController,
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
              const Text("New incident"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: loginController.logout),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                getIncidentWidget(),
                const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: registerIncident,
                    child: const Text("Register Incident", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ),
                const Spacer(flex: 6),
              ]
          ),
          ),
      ),
    );
  }

  Widget getIncidentWidget() {
    return ExternalFurnitureForm(
        nameController: incidentController.incidentTitleController,
        descriptionController: incidentController.incidentDescriptionController
    );
  }

  void registerIncident() async {
    incidentController.create(loginController.loginUser);
    changeState(AppState.mainView);
  }
}