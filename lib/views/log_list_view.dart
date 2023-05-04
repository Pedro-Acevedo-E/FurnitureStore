import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';

import '../app_state.dart';
import '../models.dart';

class LogListView extends StatelessWidget {
  final String title;
  final User user;
  final List<Log> logList;
  final Function(AppState val) changeState;
  final Function(Log log) viewLogDetails;
  final VoidCallback logout;

  const LogListView({
    super.key,
    required this.title,
    required this.user,
    required this.logList,
    required this.changeState,
    required this.viewLogDetails,
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
              Text("$title Log"),
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
              Row(
                  children: const [
                    Spacer(flex: 1),
                    Text("Name"),
                    Spacer(flex: 2),
                    Text("CreatedAt"),
                    Spacer(flex: 3),
                    Text("Details"),
                    Spacer(),
                  ]),
              const Padding(padding: EdgeInsets.only(top: 20)),
              getUserListWidgets(logList),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserListWidgets(List<Log> logList) {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < logList.length; i++){
        list.add(Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Text(logList[i].title)),
              const Spacer(flex: 1),
              Expanded(
                  flex: 5,
                  child: Text(logList[i].createdAt)),
              const Spacer(),
              TextButton(
                  onPressed: () => viewDetails(logList[i]),
                  child: const Text("Details")
              ),
              const Spacer(),
            ])
        );
    }
    return Column(children: list);
  }

  void viewDetails(Log log) {
    viewLogDetails(log);
  }
}