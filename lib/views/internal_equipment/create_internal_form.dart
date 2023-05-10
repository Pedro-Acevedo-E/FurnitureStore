import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../../app_state.dart';
import '../../controllers/internal_furniture_controller.dart';
import '../../models.dart';

class CreateInternalView extends StatelessWidget {
  final User? selectedUser;
  final EquipmentCategory? selectedCategory;
  final EquipmentCategory? selectedBrand;
  final InternalController internalController;
  final List<User> userList;
  final List<EquipmentCategory> categoryList;
  final List<EquipmentCategory> brandList;
  final Function(User user) selectUser;
  final Function(EquipmentCategory category) selectCategory;
  final Function(EquipmentCategory category) selectBrand;
  final VoidCallback logout;
  final Function(AppState val) changeState;

  const CreateInternalView({
    super.key,
    required this.selectedUser,
    required this.selectedCategory,
    required this.selectedBrand,
    required this.internalController,
    required this.userList,
    required this.categoryList,
    required this.brandList,
    required this.selectUser,
    required this.selectCategory,
    required this.selectBrand,
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
                  onPressed: () => changeState(AppState.internalFurniture),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white
              ),
              const Text("New Internal Furniture"),
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
              Row(
                  children: [
                    const Spacer(),
                    const Text("Select User: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton(
                      value: selectedUser,
                      icon: const Icon(Icons.arrow_downward),
                      items: userList.map((User value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.username),
                        );
                      }).toList(),
                      onChanged: (User? value) {
                        electUser(value);
                      },
                    ),
                    const Spacer(),
                  ]),
              const SizedBox(height: 20),
              Row(
                  children: [
                    const Spacer(),
                    const Text("Select Category: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton(
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_downward),
                      items: categoryList.map((EquipmentCategory value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (EquipmentCategory? value) {
                        electCategory(value);
                      },
                    ),
                    const Spacer(),
                  ]),
              const SizedBox(height: 20),
              Row(
                  children: [
                    const Spacer(),
                    const Text("Select Brand: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton(
                      value: selectedBrand,
                      icon: const Icon(Icons.arrow_downward),
                      items: brandList.map((EquipmentCategory value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (EquipmentCategory? value) {
                        electBrand(value);
                      },
                    ),
                    const Spacer(),
                  ]),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.status,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Condition"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.productId,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Equipment ID"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.name,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Name"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.description,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Add Description"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.dimensions,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Dimensions"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.weight,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Weight"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.color1,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Color 1"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.color2,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Color 2"
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: internalController.notes,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: "Notes"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: createInternal,
                child: const Text("Create", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  void electUser(User? value) {
    if(value != null) {
      selectUser(value);
    }
  }

  void electCategory(EquipmentCategory? value) {
    if(value != null) {
      selectCategory(value);
    }
  }

  void electBrand(EquipmentCategory? value) {
    if(value != null) {
      selectBrand(value);
    }
  }

  void createInternal() async {
    internalController.create(
        selectedUser,
        selectedCategory != null ? selectedCategory!.name : "Other",
        selectedBrand != null ? selectedBrand!.name : "Other"
    );
    changeState(AppState.internalFurniture);
  }
}