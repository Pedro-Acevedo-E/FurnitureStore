import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/category_controller.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../models.dart';

class DeleteCategoryView extends StatelessWidget {
  final User user;
  final EquipmentCategory selectedCategory;
  final Function(AppState val) changeState;
  final CategoryController categoryController;
  final VoidCallback logout;

  const DeleteCategoryView({
    super.key,
    required this.user,
    required this.selectedCategory,
    required this.changeState,
    required this.categoryController,
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
                  onPressed: () => changeState(AppState.categoryList),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              Text("Delete: ${selectedCategory.name}"),
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
              DetailsRowView(field: "ID", value: selectedCategory.id.toString()),
              DetailsRowView(field: "Name", value: selectedCategory.name),
              ElevatedButton(
                onPressed: deleteCategory,
                child: const Text("Delete", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  void deleteCategory() {
    categoryController.delete(selectedCategory.id);
    changeState(AppState.categoryList);
  }
}