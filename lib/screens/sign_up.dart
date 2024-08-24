import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/email_password.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import '../Auth/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";
  bool login = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register account"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formkey,
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
                  onSaved: (value) {
                    email = value ?? "";
                  },
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    label: const Text("Enter your email"),
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
                  ),
                ),
              SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your name please";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    username = value ?? "";
                  },
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    label: const Text("Username"),
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
                  ),
                ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your password please";
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value ?? "";
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  label: const Text("Password"),
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    print('Email: $email, Password: $password'); // Debugging line
                      await AuthService.signup(email, password, username, context);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(username: username.toString(),)) );

                  }
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
