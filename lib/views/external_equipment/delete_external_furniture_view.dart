import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/external_furniture_controller.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../models.dart';

class DeleteExternalView extends StatelessWidget {
  final User user;
  final EquipmentExt selectedExt;
  final Function(AppState val) changeState;
  final ExternalController externalController;
  final VoidCallback logout;

  const DeleteExternalView({
    super.key,
    required this.user,
    required this.selectedExt,
    required this.changeState,
    required this.externalController,
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
                  onPressed: () => changeState(AppState.externalFurniture),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Delete: ${selectedExt.name}"),
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
              const Text("Are you sure you want to delete?:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              DetailsRowView(field: "ID", value: selectedExt.id.toString()),
              DetailsRowView(field: "Name", value: selectedExt.name),
              DetailsRowView(field: "Description", value: selectedExt.description),
              ElevatedButton(
                onPressed: deleteInternal,
                child: const Text("Delete", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  void deleteInternal() {
    externalController.delete(selectedExt);
    changeState(AppState.externalFurniture);
  }
}