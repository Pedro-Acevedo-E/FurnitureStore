import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class UserMainView extends StatelessWidget {
  final User user;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const UserMainView({
    super.key,
    required this.user,
    required this.changeState,
    required this.logout
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.registeredFurniture),
            child: const Text("Check Registered Furniture")
        ),
      ],
    );
  }
}