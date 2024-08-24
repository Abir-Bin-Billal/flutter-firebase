import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices{
  static saveUser(String name , email , uid) async{
    await FirebaseFirestore.instance.collection('user').doc(uid).set({"email" : email , "name" : name});
  }
}