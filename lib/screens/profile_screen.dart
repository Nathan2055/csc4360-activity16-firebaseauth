import 'package:firebaseauth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebaseauth/main.dart';
import 'package:firebaseauth/screens/login_screen.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.emailAddress});

  final String emailAddress;

  final AuthService authService = AuthService();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout() async {
    await widget.authService.logout();

    print('are we logged in?');
    print(widget.authService.isLoggedIn());

    /*
    while (true) {
      if (widget.authService.isLoggedIn()) {
        _nextScreen();
      } else {
        //sleep(Duration(seconds: 1)); // wait 1 second
      }
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            children: [
              Text('Welcome! Your email is ${widget.emailAddress}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Log out')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
