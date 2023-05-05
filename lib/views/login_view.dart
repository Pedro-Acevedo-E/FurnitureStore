import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final String alertText;
  final VoidCallback login;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginView({super.key, required this.alertText, required this.login, required this.usernameController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Furniture Store"),
        ),
          body: Center(
            child: SizedBox(
              width: 300,
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: usernameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Username"
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      TextField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        obscureText: true,

                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Password"
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      ElevatedButton(
                          onPressed: login,
                          child: const Text("Login", style: TextStyle(fontSize: 18))
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(alertText, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    ],
                  ),
              ),
            ),
          ),
      ),
    );
  }
}