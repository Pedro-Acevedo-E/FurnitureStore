import 'package:flutter/material.dart';
import 'package:furniture_store/views/external_furniture_form.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class UserEntranceView extends StatelessWidget {
  final User user;
  final User selectedUser;
  final List<User> userList;
  final List<EquipmentInt> intList;
  final Function(AppState val) changeState;
  final Function(User user) selectUser;
  final VoidCallback logout;
  final VoidCallback addForm;
  final VoidCallback removeForm;
  final List<Widget> formList;
  final List<TextEditingController> nameControllerList;
  final List<TextEditingController> descriptionControllerList;

  const UserEntranceView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.userList,
    required this.intList,
    required this.changeState,
    required this.selectUser,
    required this.logout,
    required this.addForm,
    required this.removeForm,
    required this.formList,
    required this.nameControllerList,
    required this.descriptionControllerList
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
                      const Text("Select User: "),
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
                  Row(children: [
                    const Spacer(),
                    const Text("External Equipment?"),
                    IconButton(onPressed: addForm, icon: const Icon(Icons.add)),
                    IconButton(onPressed: removeForm, icon: const Icon(Icons.remove)),
                    const Spacer(),
                  ]),
                  getFormListWidgets(),
              ],
            ),
          ),
      ),
    );
  }

  Widget getFormListWidgets() {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < formList.length; i++){
        list.add(
            ExternalFurnitureForm(
                nameController: nameControllerList[i],
                descriptionController: descriptionControllerList[i])
        );
    }
    return Column(children: list);
  }

  void electUser(User? value) {
    if(value != null) {
      selectUser(value);
    }
  }
}