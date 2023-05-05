import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../app_state.dart';
import '../models.dart';

class ExtFurnitureView extends StatelessWidget {
  final User user;
  final List<EquipmentExt> extList;
  final Function(AppState val) changeState;
  final Function(EquipmentExt item) viewExternalFurnitureDetails;
  final Function(EquipmentExt item) deleteExternalFurniture;
  final Function(EquipmentExt item) editExternalFurniture;
  final VoidCallback logout;

  const ExtFurnitureView({
    super.key,
    required this.user,
    required this.extList,
    required this.changeState,
    required this.viewExternalFurnitureDetails,
    required this.deleteExternalFurniture,
    required this.editExternalFurniture,
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
              const Text("External Furniture"),
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
              getExtListWidgets(extList),
            ],
          ),
        ),
        floatingActionButton: user.access == "admin" ? FloatingActionButton(
            onPressed: () => changeState(AppState.internalCreate),
            tooltip: "New External furniture",
            child: const Icon(Icons.add)
        ): const SizedBox.shrink(),
      ),
    );
  }

  Widget getExtListWidgets(List<EquipmentExt> eqList) {
    List<Widget> list = <Widget>[];
    if(user.access == "admin") {
      for(var i = 0; i < eqList.length; i++){
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                  flex: 7,
                  child: Text(eqList[i].name)),
              const Spacer(),
              Expanded(
                  flex: 7,
                  child: Text(eqList[i].user)),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => viewDetails(eqList[i]),
                    icon: const Icon(Icons.search),
                  )
              ),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => viewDetails(eqList[i]),
                    icon: const Icon(Icons.edit),
                  )
              ),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => viewDetails(eqList[i]),
                    icon: const Icon(Icons.delete),
                  )
              ),
              const Spacer(),
            ])
        );
      }
    } else {
      for(var i = 0; i < eqList.length; i++){
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                  flex: 5,
                  child: Text(eqList[i].name)),
              const Spacer(flex: 1),
              Expanded(
                  flex: 5,
                  child: Text(eqList[i].user)),
              const Spacer(),
              Expanded(
                  flex: 5,
                  child: IconButton(
                    onPressed: () => viewDetails(eqList[i]),
                    icon: const Icon(Icons.search),
                  )
              ),
              const Spacer(),
            ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getTitleListWidgets() {
    List<Widget> list = <Widget>[];
    if(user.access == "admin") {
      return Row(
          children: const [
            Spacer(flex: 1),
            Expanded(
              flex: 7,
              child: Text("Name"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 7,
              child: Text("User"),
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
    } else {
      return Row(
          children: const [
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Text("Name"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Text("User"),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Text("         Details"),
            ),
            Spacer(flex: 1),
          ]
      );
    }
  }

  void viewDetails(EquipmentExt item) {
    viewExternalFurnitureDetails(item);
  }
  void delete(EquipmentExt item) {
    deleteExternalFurniture(item);
  }

  void edit(EquipmentExt item) {
    editExternalFurniture(item);
  }

}