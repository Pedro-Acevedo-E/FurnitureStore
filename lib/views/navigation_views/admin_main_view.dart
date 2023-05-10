import 'package:flutter/material.dart';
import '../../app_state.dart';

class AdminMainView extends StatelessWidget {
  final Function(AppState val) changeState;

  const AdminMainView({
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
            onPressed: () => changeState(AppState.userList),
            child: const Text("Users")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.categoryList),
            child: const Text("Categories")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.brandList),
            child: const Text("Brands")
        ),
      ],
    );
  }
}