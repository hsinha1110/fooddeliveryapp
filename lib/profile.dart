import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/login.dart';
import 'package:fooddeliveryapp/services/database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  Future<void> logout() async {
    await databaseMethods.logOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: ElevatedButton(
          onPressed: logout,
          child: const Text("Logout"),
        ),
      ),
    );
  }
}