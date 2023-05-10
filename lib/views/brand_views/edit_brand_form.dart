import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/brand_controller.dart';
import '../../models.dart';

class EditBrandView extends StatelessWidget {
  final EquipmentCategory selectedCategory;
  final BrandController brandController;
  final VoidCallback logout;
  final Function(AppState val) changeState;

  EditBrandView({
    super.key,
    required this.selectedCategory,
    required this.brandController,
    required this.logout,
    required this.changeState,
  }) {
    brandController.name.text = selectedCategory.name;
    brandController.description.text = selectedCategory.description;
  }

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
              const Text("Edit Brand"),
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
              const SizedBox(height: 90),
              TextField(
                controller: brandController.name,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Name"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: brandController.description,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Add Description"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: voidEditCategory,
                child: const Text("Update", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  voidEditCategory() {
    brandController.update(selectedCategory);
    changeState(AppState.brandList);
  }
}