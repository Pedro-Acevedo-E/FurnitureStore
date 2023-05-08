import 'package:flutter/material.dart';
import 'package:furniture_store/controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController;
  final VoidCallback login;

  const LoginView({
    super.key,
    required this.loginController,
    required this.login
  });

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
                        controller: loginController.usernameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Username"
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      TextField(
                        controller: loginController.passwordController,
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
                      Text(loginController.alertText, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    ],
                  ),
              ),
            ),
          ),
      ),
    );
  }
}