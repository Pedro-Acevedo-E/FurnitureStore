import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../controllers/external_furniture_controller.dart';
import '../../models.dart';

class CreateExternalView extends StatelessWidget {
  final ExternalController externalController;
  final List<User> userList;
  final VoidCallback logout;
  final Function(AppState val) changeState;

  const CreateExternalView({
    super.key,
    required this.externalController,
    required this.userList,
    required this.logout,
    required this.changeState,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => changeState(AppState.externalFurniture),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              const Text("New External Furniture"),
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
                      value: externalController.selectedUser,
                      icon: const Icon(Icons.arrow_downward),
                      items: userList.map((User value) {
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
              TextField(
                  controller: externalController.name,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      hintText: "Name"
                  ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: externalController.description,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Add Description"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: voidCreateExternal,
                child: const Text("Create", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  voidCreateExternal() {
    final selectedUser = externalController.selectedUser;
    if (selectedUser != null) {
      externalController.create(selectedUser);
      externalController.reset();
      changeState(AppState.externalFurniture);
    }
  }

  void electUser(User? value) {
    if(value != null) {
      externalController.selectUser(value);
    }
  }
}