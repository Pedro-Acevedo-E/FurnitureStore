import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/external_furniture_controller.dart';
import '../../models.dart';

class EditExternalView extends StatelessWidget {
  final User user;
  final User? selectedUser;
  final EquipmentExt selectedExt;
  final List<User> userList;
  final ExternalController externalController;
  final VoidCallback logout;
  final Function(AppState val) changeState;
  final Function(User user) selectUser;

  EditExternalView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.selectedExt,
    required this.userList,
    required this.externalController,
    required this.logout,
    required this.changeState,
    required this.selectUser,
  }){
    externalController.name.text = selectedExt.name;
    externalController.description.text = selectedExt.description;
  }

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
              Text("Edit: ${selectedExt.name}"),
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
              Text("Current user: ${selectedExt.user}"),
              Row(
                  children: [
                    const Spacer(),
                    const Text("Select User: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton(
                      value: selectedUser,
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
                decoration: const InputDecoration(
                    hintText: "Description"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: editExternal,
                child: const Text("Update", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  void electUser(User? value) {
    if(value != null) {
      selectUser(value);
    }
  }

  void editExternal() async {
    final selectedUser = this.selectedUser;
    if (selectedUser != null) {
      externalController.update(selectedExt, selectedUser.username);
      changeState(AppState.externalFurniture);
    }
  }
}