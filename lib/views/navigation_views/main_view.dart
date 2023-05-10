import 'package:flutter/material.dart';
import 'package:furniture_store/views/navigation_views/admin_main_view.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import 'package:furniture_store/views/navigation_views/security_main_view.dart';
import 'package:furniture_store/views/navigation_views/user_main_view.dart';

import '../../app_state.dart';
import '../../controllers/login_controller.dart';
import '../../models.dart';

class MainView extends StatelessWidget {
  final LoginController loginController;
  final Function(AppState val) changeState;

  const MainView({
    super.key,
    required this.loginController,
    required this.changeState
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Welcome ${loginController.loginUser.username}"),
              const Spacer(),
              PopupMenuButtonView(changeState: changeState, logout: loginController.logout),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: getListWidgets(loginController.loginUser),
          ),
        ),
      ),
    );
  }

  Widget getListWidgets(User user) {
    List<Widget> list = <Widget>[];
    if (user.access == "admin") {
      list.add(Column(children: [
        AdminMainView(changeState: changeState),
        SecurityMainView(changeState: changeState),
        UserMainView(changeState: changeState)
      ]));
    }
    if (user.access == "security") {
      list.add(Column(children: [
        SecurityMainView(changeState: changeState),
        UserMainView(changeState: changeState)
      ]));
    }
    if (user.access == "user") {
      list.add(Column(children: [
        UserMainView(changeState: changeState)
      ]));
    }
    return Column(children: list);
  }
}