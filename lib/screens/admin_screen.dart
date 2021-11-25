import 'package:anubhuti/screens/admin_home_screen.dart';
import 'package:anubhuti/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController passwordController = TextEditingController();
  bool isAdminLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAdminLoggedIn ? AdminHomeScreen() : passwordWindow(),
    );
  }

  Widget passwordWindow() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Enter password"),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.dark,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please some text ...';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isAdminLoggedIn = true;
              });
              if (passwordController.text.isNotEmpty) {
                if (passwordController.text == "") {
                  setState(() {
                    isAdminLoggedIn = true;
                  });
                }
              }
            },
            child: const Text("Go ..."),
          ),
        ],
      ),
    );
  }
}
