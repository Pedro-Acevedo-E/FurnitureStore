import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../app_state.dart';
import '../models.dart';

class IntFurnitureView extends StatelessWidget {
  final User user;
  final List<EquipmentInt> intList;
  final Function(AppState val) changeState;
  final Function(EquipmentInt item) viewInternalFurnitureDetails;
  final Function(EquipmentInt item) deleteInternalFurniture;
  final Function(EquipmentInt item) editInternalFurniture;
  final VoidCallback viewCreateInternalFurniture;
  final VoidCallback logout;

  const IntFurnitureView({
    super.key,
    required this.user,
    required this.intList,
    required this.changeState,
    required this.viewInternalFurnitureDetails,
    required this.deleteInternalFurniture,
    required this.editInternalFurniture,
    required this.viewCreateInternalFurniture,
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
              const Text("Internal Furniture"),
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
              getIntListWidgets(intList),
            ],
          ),
        ),
        floatingActionButton: user.access == "admin" ? FloatingActionButton(
          onPressed: viewCreateInternalFurniture,
          tooltip: "New Internal furniture",
          child: const Icon(Icons.add)
        ): const SizedBox.shrink(),
      ),
    );
  }

  Widget getIntListWidgets(List<EquipmentInt> eqList) {
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

  void viewDetails(EquipmentInt item) {
    viewInternalFurnitureDetails(item);
  }
  void delete(EquipmentInt item) {
    deleteInternalFurniture(item);
  }

  void edit(EquipmentInt item) {
    editInternalFurniture(item);
  }

}