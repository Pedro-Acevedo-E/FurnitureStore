import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../models.dart';
import '../details_row.dart';

class BrandDetailsView extends StatelessWidget {
  final User user;
  final EquipmentCategory selectedCategory;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const BrandDetailsView({
    super.key,
    required this.user,
    required this.selectedCategory,
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
                  onPressed: () => changeState(AppState.brandList),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              const Text("Brand details"),
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
              const Text("Brand Data:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              DetailsRowView(field: "ID", value: selectedCategory.id.toString()),
              DetailsRowView(field: "Title", value: selectedCategory.name),
              DetailsRowView(field: "Description", value: selectedCategory.description),
            ],
          ),
        ),
      ),
    );
  }
}