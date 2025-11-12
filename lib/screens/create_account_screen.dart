import 'package:firebaseauth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebaseauth/main.dart';
import 'package:firebaseauth/screens/login_screen.dart';
import 'dart:io';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({super.key});

  final AuthService authService = AuthService();

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // Form state key
  final _formKey = GlobalKey<FormState>();

  // Hardcoded login details
  final String adminUsername = 'admin';
  final String adminPassword = 'admin';
  final String viewerUsername = 'viewer';
  final String viewerPassword = 'viewer';

  // Text field controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Track password visibility for the "show password" toggle
  bool _isPasswordVisible = false;

  void _submitForm() async {
    String emailAddress = _usernameController.text;
    String password = _passwordController.text;

    await widget.authService.createAccount(emailAddress, password);

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

  void _nextScreen() {
    Navigator.pushReplacement(
      context,
      //MaterialPageRoute(builder: (context) => InventoryHomePage()),
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Firebase Auth Demo'),
      ),
    );
  }

  void _loginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create an Account')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(64.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 24.0,
              children: [
                // Username field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                // Submit button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Create Account')],
                  ),
                ),

                // Switch to login screen button
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loginScreen,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Go to log into an existing account')],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
