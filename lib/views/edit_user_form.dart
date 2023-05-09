import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../app_state.dart';
import '../controllers/user_controller.dart';
import '../models.dart';

class EditUserView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final UserController userController;
  final VoidCallback logout;
  final Function(AppState val) changeState;
  final Function(String val) selectAccess;
  final List<String> accessList = ["user", "admin", "security"];

  EditUserView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.userController,
    required this.logout,
    required this.changeState,
    required this.selectAccess,
  }){
    userController.username.text = selectedUser.username;
    userController.firstName.text = selectedUser.firstName;
    userController.lastName.text = selectedUser.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => changeState(AppState.userList),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Edit: ${selectedUser.username}"),
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
                    const Text("Select Access: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton(
                      value: userController.access.text,
                      icon: const Icon(Icons.arrow_downward),
                      items: accessList.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        electAccess(value);
                      },
                    ),
                    const Spacer(),
                  ]),
              const SizedBox(height: 20),
              TextField(
                controller: userController.username,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Username"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: userController.firstName,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "First Name"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: userController.lastName,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Last Name"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUser,
                child: const Text("Update", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  void electAccess(String? value) {
    if (value != null) {
      selectAccess(value);
    }
  }

  void updateUser() {
    userController.update(selectedUser);
    changeState(AppState.userList);
  }
}