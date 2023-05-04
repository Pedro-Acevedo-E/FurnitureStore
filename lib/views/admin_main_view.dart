import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class AdminMainView extends StatelessWidget {
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const AdminMainView({
    super.key,
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
            onPressed: () => changeState(AppState.editUser),
            child: const Text("Edit Users")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.editExternal),
            child: const Text("Edit External Furniture")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.editInternal),
            child: const Text("Edit Internal Furniture")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.editCategory),
            child: const Text("Edit Categories")
        ),
      ],
    );
  }
}