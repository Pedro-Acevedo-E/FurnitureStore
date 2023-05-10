import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../models.dart';

class CategoryView extends StatelessWidget {
  final List<EquipmentCategory> categoryList;
  final Function(AppState val) changeState;
  final Function(EquipmentCategory item) viewCategoryDetails;
  final Function(EquipmentCategory item) viewDeleteCategory;
  final Function(EquipmentCategory item) viewEditCategory;
  final VoidCallback viewCreateCategory;
  final VoidCallback logout;

  const CategoryView({
    super.key,
    required this.categoryList,
    required this.changeState,
    required this.viewCategoryDetails,
    required this.viewDeleteCategory,
    required this.viewEditCategory,
    required this.viewCreateCategory,
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
              onPressed: viewCreateCategory,
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
    viewCategoryDetails(item);
  }

  void delete(EquipmentCategory item) {
    viewDeleteCategory(item);
  }

  void edit(EquipmentCategory item) {
    viewEditCategory(item);
  }

}