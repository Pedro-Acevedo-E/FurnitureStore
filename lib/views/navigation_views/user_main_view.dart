import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../models.dart';

class UserMainView extends StatelessWidget {
  final Function(AppState val) changeState;

  const UserMainView({
    super.key,
    required this.changeState
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.checkFurniture),
            child: const Text("Your Furniture")
        ),
      ],
    );
  }
}