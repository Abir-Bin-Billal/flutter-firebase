import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Auth/firebaseFunction.dart';

class AuthService {
  static Future<void> signup(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with name and email (if necessary)
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);

      // Save user data to Firestore
      await FireStoreServices.saveUser(name, email, userCredential.user!.uid);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up successful")));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password is too weak")));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email already in use")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  static Future<String> signInUser(
      String email, String password, BuildContext context) async {
    try {
      // Attempt to sign in with Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in successfully!")));

      return "Success"; // Indicate success
    } catch (e) {
      String errorMessage = "An unknown error occurred";

      if (e is FirebaseAuthException) {
        // Handle specific Firebase authentication errors
        switch (e.code) {
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          case 'user-disabled':
            errorMessage = "The user account has been disabled.";
            break;
          case 'user-not-found':
            errorMessage = "No user found with this email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password.";
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Invalid Credintials")));
        }
      } else {
        // Handle other types of exceptions
        errorMessage = e.toString();
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)));

      return errorMessage; // Return error message
    }
  }
}
