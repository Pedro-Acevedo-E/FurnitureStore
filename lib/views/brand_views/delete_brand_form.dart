import 'package:flutter/material.dart';
import 'package:furniture_store/views/details_row.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/brand_controller.dart';

class DeleteBrandView extends StatelessWidget {
  final Function(AppState val) changeState;
  final BrandController brandController;
  final VoidCallback logout;

  const DeleteBrandView({
    super.key,
    required this.changeState,
    required this.brandController,
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
              Text("Delete: ${brandController.selectedCategory!.name}"),
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
              DetailsRowView(field: "ID", value: brandController.selectedCategory!.id.toString()),
              DetailsRowView(field: "Name", value: brandController.selectedCategory!.name),
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
    brandController.delete(brandController.selectedCategory!.id);
    changeState(AppState.brandList);
  }
}