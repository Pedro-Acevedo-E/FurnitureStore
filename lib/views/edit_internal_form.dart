import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../app_state.dart';
import '../controllers/internal_furniture_controller.dart';
import '../models.dart';

class EditInternalView extends StatelessWidget {
  final User user;
  final User? selectedUser;
  final EquipmentInt selectedInt;
  final EquipmentCategory? selectedCategory;
  final InternalController internalController;
  final List<User> userList;
  final List<EquipmentCategory> categoryList;
  final Function(User user) selectUser;
  final Function(EquipmentCategory category) selectCategory;
  final VoidCallback logout;
  final Function(AppState val) changeState;

  EditInternalView({
    super.key,
    required this.user,
    required this.selectedUser,
    required this.selectedInt,
    required this.selectedCategory,
    required this.internalController,
    required this.userList,
    required this.categoryList,
    required this.selectUser,
    required this.selectCategory,
    required this.logout,
    required this.changeState,
  }){
    internalController.name.text = selectedInt.name;
    internalController.productId.text = selectedInt.productId;
    internalController.notes.text = selectedInt.notes;
    internalController.dimensions.text = selectedInt.dimensions;
    internalController.weight.text = selectedInt.weight;
    internalController.status.text = selectedInt.status;
    internalController.color2.text = selectedInt.color_2;
    internalController.color1.text = selectedInt.color_1;
    internalController.model.text = selectedInt.model;
    internalController.description.text = selectedInt.description;
    internalController.location.text = selectedInt.location;
  }

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
              Text("Edit: ${selectedInt.name}"),
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
              Text(selectedInt.user.isNotEmpty ? "Current user: ${selectedInt.user}" : ""),
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
              Text(selectedInt.category.isNotEmpty ? "Current category: ${selectedInt.category}" : ""),
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
                controller: internalController.location,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Location"
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
                controller: internalController.model,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    hintText: "Model"
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
                onPressed: editInternal,
                child: const Text("Update", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  void editInternal() {
    final selectedUser = this.selectedUser;
    final selectedCategory = this.selectedCategory;
    if (selectedUser != null && selectedCategory != null) {
      internalController.update(selectedInt, selectedUser.username, selectedCategory.name);
    }
    else if (selectedUser != null) {
      internalController.update(selectedInt, selectedUser.username, "Other");
    }
    else if (selectedCategory != null) {
      internalController.update(selectedInt, "", selectedCategory.name);
    }
    else {
      internalController.update(selectedInt, "", "Other");
    }
    changeState(AppState.internalFurniture);
  }
}