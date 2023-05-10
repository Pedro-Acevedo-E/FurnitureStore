import 'package:flutter/material.dart';
import 'package:furniture_store/views/navigation_views/admin_main_view.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import 'package:furniture_store/views/navigation_views/security_main_view.dart';
import 'package:furniture_store/views/navigation_views/user_main_view.dart';

import '../../app_state.dart';
import '../../models.dart';

class MainView extends StatelessWidget {
  final User user;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const MainView({
    super.key,
    required this.user,
    required this.changeState,
    required this.logout
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Welcome ${user.username}"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: logout),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: getListWidgets(user),
          ),
        ),
      ),
    );
  }

  Widget getListWidgets(User user) {
    List<Widget> list = <Widget>[];
    if (user.access == "admin") {
      list.add(Column(children: [
        AdminMainView(changeState: changeState, logout: logout),
        SecurityMainView(changeState: changeState, logout: logout),
        UserMainView(changeState: changeState, logout: logout)
      ]));
    }
    if (user.access == "security") {
      list.add(Column(children: [
        SecurityMainView(changeState: changeState, logout: logout),
        UserMainView(changeState: changeState, logout: logout)
      ]));
    }
    if (user.access == "user") {
      list.add(Column(children: [
        UserMainView(changeState: changeState, logout: logout)
      ]));
    }
    return Column(children: list);
  }
}