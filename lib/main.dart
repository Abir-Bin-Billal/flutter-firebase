import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/email_password.dart';
import 'package:flutter_firebase/screens/sign_up.dart';
import 'package:flutter_firebase/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAfWnKcEYyu0jL4Vk9s4pp0llpTx7hqBvY",
      appId: "1:402374155666:android:995bd39f2f64a6f219754b",
      messagingSenderId: "402374155666",
      projectId: "flutter-firebase-61805",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(username: snapshot.data!.email.toString(),);
          } else {
            return EmailPassword();
          }
        },
      ),
    );
  }
}
