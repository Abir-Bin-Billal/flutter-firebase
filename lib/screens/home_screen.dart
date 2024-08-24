import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/email_password.dart';

class HomeScreen extends StatefulWidget {
  String? username;
   HomeScreen({super.key,this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailPassword()));
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Text(widget.username! , style: TextStyle(fontSize: 50),),
      ),
    );
  }
}
