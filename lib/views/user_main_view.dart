import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';

class AdminMainView extends StatelessWidget {
  final User user;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const AdminMainView({
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
              PopupMenuButton<PopupSelection>(
                initialValue: PopupSelection.profile,
                onSelected: (PopupSelection item) {
                  switch(item) {
                    case PopupSelection.profile: {
                      changeState(AppState.profile);
                    } break;
                    case PopupSelection.settings: {
                      changeState(AppState.settings);
                    } break;
                    case PopupSelection.logout: {
                      logout();
                    } break;
                    default: {
                      changeState(AppState.error);
                    } break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupSelection>>[
                  const PopupMenuItem(
                      value: PopupSelection.profile,
                      child: Text("Profile")),
                  const PopupMenuItem(
                      value: PopupSelection.settings,
                      child: Text("Settings")),
                  const PopupMenuItem(
                      value: PopupSelection.logout,
                      child: Text("Logout")),
                ],
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Your furniture"),
                Text("Your furniture will be here"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}