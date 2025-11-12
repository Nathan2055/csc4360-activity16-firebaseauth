import 'package:firebaseauth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:firebaseauth/main.dart';
import 'package:firebaseauth/screens/create_account_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final AuthService authService = AuthService();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  Future<void> _submitForm() async {
    String emailAddress = _usernameController.text;
    String password = _passwordController.text;

    await widget.authService.login(emailAddress, password);

    while (true) {
      if (widget.authService.isLoggedIn()) {
        _nextScreen();
      } else {
        await Future.delayed(const Duration(seconds: 1)); // wait 1 second
      }
    }

    /*
    if (_usernameController.text == adminUsername &&
        _passwordController.text == adminPassword) {
      // Login as admin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InventoryHomePage()),
      );
    } else if (_usernameController.text == viewerUsername &&
        _passwordController.text == viewerPassword) {
      // Login as viewer
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InventoryHomePage(readOnly: true),
        ),
      );
    } else {
      // Show error for incorrect credentials
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect username and/or password')),
      );
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

  void _createScreen() {
    Navigator.pushReplacement(
      context,
      //MaterialPageRoute(builder: (context) => InventoryHomePage()),
      MaterialPageRoute(builder: (context) => CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Inventory Management')),
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
                    children: [Text('Login')],
                  ),
                ),

                // Switch to login screen button
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createScreen,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Go to create a new account')],
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
