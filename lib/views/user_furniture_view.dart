import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models.dart';

class UserFurnitureView extends StatelessWidget {
  final User user;
  final List<EquipmentExt> extList;
  final List<EquipmentInt> intList;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const UserFurnitureView({
    super.key,
    required this.user,
    required this.extList,
    required this.intList,
    required this.changeState,
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
              Text("${user.username} Registered items"),
              const Spacer(),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text("Your Registered Equipment:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text("Internal equipment:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 20)),
              getIntEquipmentListWidgets(intList),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text("External equipment:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.only(top: 20)),
              getExtEquipmentListWidgets(extList),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }


  Widget getExtEquipmentListWidgets(List<EquipmentExt> equipmentList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < equipmentList.length; i++){
      if (equipmentList[i].user == user.username) {
        list.add(
            Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                      flex: 6,
                      child: Text("Equipment ${equipmentList[i].id}: ${equipmentList[i].name} ",
                        style: const TextStyle(fontSize: 20)
                      ),
                  ),
                  const Spacer(flex: 1),
                  Expanded(flex: 10, child: Text("Description: ${equipmentList[i].description}",
                      style: const TextStyle(fontSize: 20)
                    ),
                  ),
                  const Spacer(flex: 1),
                ])
        );
      }
    }
    return Column(children: list);
  }

  Widget getIntEquipmentListWidgets(List<EquipmentInt> equipmentList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < equipmentList.length; i++){
      if (equipmentList[i].user == user.username) {
        list.add(Row(
            children: [
              const Spacer(flex: 1),
              Expanded(flex: 6, child: Text("Equipment ${equipmentList[i].id}: ${equipmentList[i].name} ",
                  style: const TextStyle(fontSize: 20)
                ),
              ),
              const Spacer(flex: 1),
              Expanded(flex: 10, child: Text("Description: ${equipmentList[i].description}",
                  style: const TextStyle(fontSize: 20)
                ),
              ),
              const Spacer(flex: 1),
            ])
        );
      }
    }
    return Column(children: list);
  }
}