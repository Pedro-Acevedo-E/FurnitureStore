import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/category_controller.dart';
import '../../models.dart';

class CategoryView extends StatelessWidget {
  final List<EquipmentCategory> categoryList;
  final Function(AppState val) changeState;
  final CategoryController categoryController;
  final VoidCallback logout;

  const CategoryView({
    super.key,
    required this.categoryList,
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
                    onPressed: () => changeState(AppState.mainView),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white
                ),
                const Text("Category List"),
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
                getTitleListWidgets(),
                const Padding(padding: EdgeInsets.only(top: 20)),
                getCategoryListWidgets(categoryList),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: categoryController.viewCreateCategory,
              tooltip: "New Internal furniture",
              child: const Icon(Icons.add)
          )
      ),
    );
  }

  Widget getCategoryListWidgets(List<EquipmentCategory> eqList) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < eqList.length; i++) {
      list.add(Row(
          children: [
            const Spacer(flex: 1),
            Expanded(
                flex: 7,
                child: Text(eqList[i].name)),
            const Spacer(),
            Expanded(
                flex: 3,
                child: IconButton(
                  onPressed: () => viewDetails(eqList[i]),
                  icon: const Icon(Icons.find_in_page),
                )
            ),
            const Spacer(),
            Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () => edit(eqList[i]),
                  icon: const Icon(Icons.edit),
                )
            ),
            const Spacer(),
            Expanded(
                flex: 2,
                child: IconButton(
                  onPressed: () => delete(eqList[i]),
                  icon: const Icon(Icons.delete),
                )
            ),
            const Spacer(),
          ])
      );
    }
    return Column(children: list);
  }

  Widget getTitleListWidgets() {
    List<Widget> list = <Widget>[];
    return Row(
        children: const [
          Spacer(flex: 1),
          Expanded(
            flex: 7,
            child: Text("Name"),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 3,
            child: Text("Details"),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: Text("Edit"),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 3,
            child: Text("Delete"),
          ),
        ]
    );
  }


  void viewDetails(EquipmentCategory item) {
    categoryController.viewCategoryDetails(item);
  }

  void delete(EquipmentCategory item) {
    categoryController.viewDeleteCategory(item);
  }

  void edit(EquipmentCategory item) {
    categoryController.viewEditCategory(item);
  }

}