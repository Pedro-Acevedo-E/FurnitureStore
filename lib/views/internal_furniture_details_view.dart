import 'package:flutter/material.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class InternalDetailsView extends StatelessWidget {
  final User user;
  final EquipmentInt selectedInt;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const InternalDetailsView({
    super.key,
    required this.user,
    required this.selectedInt,
    required this.changeState,
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
              Text("Details of: ${selectedInt.name}"),
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
              const Text("Equipment Data:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              DetailsRowView(field: "ID", value: selectedInt.id.toString()),
              DetailsRowView(field: "User", value: selectedInt.user),
              DetailsRowView(field: "Location", value: selectedInt.location),
              DetailsRowView(field: "Status", value: selectedInt.status),
              DetailsRowView(field: "Product ID", value: selectedInt.productId),
              DetailsRowView(field: "Name", value: selectedInt.name),
              DetailsRowView(field: "Description", value: selectedInt.description),
              DetailsRowView(field: "Category", value: selectedInt.category),
              DetailsRowView(field: "Model", value: selectedInt.model),
              DetailsRowView(field: "Weight", value: selectedInt.weight),
              DetailsRowView(field: "Dimensions", value: selectedInt.dimensions),
              DetailsRowView(field: "Color 1", value: selectedInt.color_1),
              DetailsRowView(field: "Color 2", value: selectedInt.color_2),
              DetailsRowView(field: "Notes", value: selectedInt.notes),
              DetailsRowView(field: "Created At", value: selectedInt.createdAt),
            ],
          ),
        ),
      ),
    );
  }
}