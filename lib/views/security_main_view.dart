import 'package:flutter/material.dart';

import '../app_state.dart';

class SecurityMainView extends StatelessWidget {
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const SecurityMainView({
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
            onPressed: () => changeState(AppState.entrancesAndExits),
            child: const Text("Entrances and exits")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.createIncident),
            child: const Text("Create Incident")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.incidentLog),
            child: const Text("Incident Log")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.userLog),
            child: const Text("Entrance and Exits Log")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.externalFurniture),
            child: const Text("External furniture")
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
            onPressed: () => changeState(AppState.internalFurniture),
            child: const Text("Internal furniture")
        ),
      ],
    );
  }
}