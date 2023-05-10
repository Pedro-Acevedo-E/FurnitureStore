import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/category_controller.dart';
import '../../models.dart';

class CreateCategoryView extends StatelessWidget {
  final CategoryController categoryController;
  final VoidCallback logout;
  final Function(AppState val) changeState;

  const CreateCategoryView({
    super.key,
    required this.categoryController,
    required this.logout,
    required this.changeState,
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
              const Text("New Category"),
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
                controller: categoryController.name,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Name"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: categoryController.description,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Add Description"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: voidCreateCategory,
                child: const Text("Create", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  voidCreateCategory() {
    categoryController.create();
    changeState(AppState.categoryList);
  }
}