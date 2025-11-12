import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauth/firebase_options.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createAccount(String emailAddress, String password) async {
    print('creating account');
    try {
      var state = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(state.toString);
      print('created account');
      login(emailAddress, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String emailAddress, String password) {
    print('logging in');
    try {
      _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      print('logged in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    print('signing out');
    try {
      _auth.signOut();
      print('signed out');
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  bool isLoggedIn() {
    if (_auth.currentUser != null) {
      print('current user:');
      print(_auth.currentUser?.uid);
      return true;
    } else {
      print('not signed in');
      return false;
    }
  }
}
