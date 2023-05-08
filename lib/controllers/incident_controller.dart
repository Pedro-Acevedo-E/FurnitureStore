import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_store/models.dart';

import '../sql_helper.dart';

class IncidentController {
  final incidentTitleController = TextEditingController();
  final incidentDescriptionController = TextEditingController();

  void reset() {
    incidentTitleController.text = "";
    incidentDescriptionController.text = "";
  }

  void create(User user) async {
    if(incidentTitleController.text.isNotEmpty && incidentDescriptionController.text.isNotEmpty) {
      final incidentLogData = Log(
          id: 0,
          title: incidentTitleController.text,
          createdBy: user.username,
          description: incidentDescriptionController.text,
          createdAt: ""
      );
      final incidentData = await SQLHelper.createLog(incidentLogData, "incident_log");
      if (kDebugMode) {
        print("Created Incident Log $incidentData");
      }
    }
  }
}