import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/sign_up.dart';
import '../Auth/auth_service.dart';

class EmailPassword extends StatefulWidget {
  const EmailPassword({super.key});

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email please";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  label: const Text(
                    "Enter your email",
                    style: TextStyle(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your password please";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                  label: const Text(
                    "Password",
                    style: TextStyle(color: Colors.grey),
                  ),
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    String result = await AuthService.signInUser(email, password, context);
                    if (result == "Success") {
                      // Navigate to the next screen or handle success
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen(username: email,)));// Example
                    }

                  }
                },
                child: Text("Login"),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
