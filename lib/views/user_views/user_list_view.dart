import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../models.dart';

class UserListView extends StatelessWidget {
  final List<User> userList;
  final Function(AppState val) changeState;
  final Function(User item) viewUserDetails;
  final Function(User item) viewDeleteUser;
  final Function(User item) viewEditUser;
  final VoidCallback viewCreateUser;
  final VoidCallback logout;

  const UserListView({
    super.key,
    required this.userList,
    required this.changeState,
    required this.viewUserDetails,
    required this.viewDeleteUser,
    required this.viewEditUser,
    required this.viewCreateUser,
    required this.logout,
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
              const Text("User list"),
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
              const Padding(padding: EdgeInsets.only(top: 20)),
              getTitleListWidgets(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              getUserListWidgets(userList),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: viewCreateUser,
            tooltip: "New User",
            child: const Icon(Icons.add)
        ),
      ),
    );
  }

  Widget getUserListWidgets(List<User> uList) {
    List<Widget> list = <Widget>[];
      for(var i = 0; i < uList.length; i++){
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                  flex: 7,
                  child: Text(uList[i].username)),
              const Spacer(),
              Expanded(
                  flex: 7,
                  child: Text(uList[i].access)),
              const Spacer(),
              Expanded(
                  flex: 3,
                  child: IconButton(
                    onPressed: () => viewDetails(uList[i]),
                    icon: const Icon(Icons.find_in_page),
                  )
              ),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => edit(uList[i]),
                    icon: const Icon(Icons.edit),
                  )
              ),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => delete(uList[i]),
                    icon: const Icon(Icons.delete),
                  )
              ),
              const Spacer(),
            ])
        );
      }

    return Column(children: list);
  }

  Widget getTitleListWidgets() {
    List<Widget> list = <Widget>[];
      return Row(
          children: const [
            Spacer(flex: 1),
            Expanded(
              flex: 7,
              child: Text("UserName"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 7,
              child: Text("Access"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 3,
              child: Text("Details"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 2,
              child: Text("Edit"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 3,
              child: Text("Delete"),
            ),
          ]
      );
  }

  void viewDetails(User item) {
    viewUserDetails(item);
  }

  void delete(User item) {
    viewDeleteUser(item);
  }

  void edit(User item) {
    viewEditUser(item);
  }

}