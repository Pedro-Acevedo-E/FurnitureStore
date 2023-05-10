import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/internal_furniture_controller.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../models.dart';

class DeleteInternalView extends StatelessWidget {
  final User user;
  final EquipmentInt selectedInt;
  final Function(AppState val) changeState;
  final InternalController internalController;
  final VoidCallback logout;

  const DeleteInternalView({
    super.key,
    required this.user,
    required this.selectedInt,
    required this.changeState,
    required this.internalController,
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
                  onPressed: () => changeState(AppState.internalFurniture),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Delete: ${selectedInt.name}"),
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
              DetailsRowView(field: "ID", value: selectedInt.id.toString()),
              DetailsRowView(field: "Name", value: selectedInt.name),
              DetailsRowView(field: "Description", value: selectedInt.description),
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
    internalController.delete(selectedInt);
    changeState(AppState.internalFurniture);
  }
}