import 'package:flutter/material.dart';
import 'package:furniture_store/views/popup_menu_button.dart';
import '../app_state.dart';
import '../models.dart';
import 'details_row.dart';

class LogDetailsView extends StatelessWidget {
  final User user;
  final Log selectedLog;
  final Function(AppState val) changeState;
  final VoidCallback logout;

  const LogDetailsView({
    super.key,
    required this.user,
    required this.selectedLog,
    required this.changeState,
    required this.logout
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
              const Text("Log details"),
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
                const Text("Log Data:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                DetailsRowView(field: "ID", value: selectedLog.id.toString()),
                DetailsRowView(field: "Title", value: selectedLog.title),
                DetailsRowView(field: "Created By", value: selectedLog.createdBy),
                DetailsRowView(field: "Description", value: selectedLog.description),
                DetailsRowView(field: "Created At", value: selectedLog.createdAt),
              ],
            ),
          ),
      ),
    );
  }
}