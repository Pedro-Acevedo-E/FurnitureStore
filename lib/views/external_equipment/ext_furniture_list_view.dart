import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/login_controller.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../../app_state.dart';
import '../../controllers/external_furniture_controller.dart';
import '../../models.dart';

class ExtFurnitureView extends StatelessWidget {
  final LoginController loginController;
  final ExternalController externalController;
  final List<EquipmentExt> extList;
  final Function(AppState val) changeState;

  const ExtFurnitureView({
    super.key,
    required this.loginController,
    required this.externalController,
    required this.extList,
    required this.changeState
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
              PopupMenuButtonView(changeState: changeState, logout: loginController.logout),
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
        floatingActionButton: loginController.loginUser.access == "admin" ? FloatingActionButton(
            onPressed: externalController.viewCreateExternalFurniture,
            tooltip: "New External furniture",
            child: const Icon(Icons.add)
        ): const SizedBox.shrink(),
      ),
    );
  }

  Widget getExtListWidgets(List<EquipmentExt> eqList) {
    List<Widget> list = <Widget>[];
    if(loginController.loginUser.access == "admin") {
      for(var i = 0; i < eqList.length; i++){
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(
                  flex: 7,
                  child: Text(eqList[i].name)),
              const Spacer(flex: 1),
              Expanded(
                  flex: 7,
                  child: Text(eqList[i].user)),
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
                    icon: const Icon(Icons.find_in_page),
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
    if(loginController.loginUser.access == "admin") {
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
    externalController.viewExternalFurnitureDetails(item);
  }

  void delete(EquipmentExt item) {
    externalController.viewDeleteExternalFurniture(item);
  }

  void edit(EquipmentExt item) {
    externalController.viewEditExternalFurniture(item);
  }

}