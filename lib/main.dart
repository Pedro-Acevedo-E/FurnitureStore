import 'package:flutter/material.dart';
import 'package:furniture_store/sql_helper.dart';

import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> items = [];
  late final User myUser;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(child: Text("We have ${items.length} users in our database")),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //createUser();
    loadUsers();
  }

  void loadUsers() async {
    final data = await SQLHelper.getList("user");
    setState(() {
      items = data;
    });
    print("We have ${items.length} users in our database");
  }

  void createUser() async {
    final data = await SQLHelper.createUser(User(id: 0, username: "admin", firstName: "", lastName: "", password: "12345678", access: "admin"));
    print("User $data created succesfully");
  }
}
