import 'package:flutter/material.dart';

import '../app_state.dart';

class PopupMenuButtonView extends StatelessWidget {
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const PopupMenuButtonView({
    super.key,
    required this.changeState,
    required this.logout
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupSelection>(
        initialValue: PopupSelection.profile,
        onSelected: (PopupSelection item) {
          switch(item) {
            case PopupSelection.profile: {
              changeState(AppState.profile);
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
              value: PopupSelection.logout,
              child: Text("Logout")),
        ],
    );
  }
}