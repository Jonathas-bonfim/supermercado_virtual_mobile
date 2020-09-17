import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.name});
  String id;
  String name;
  String email;
  String password;

  String confirmPassword;

  Future<void> saveData() async {
    await Firestore.instance.collection('users').document(id).setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
