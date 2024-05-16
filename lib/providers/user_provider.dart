import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  String _profileImageUrl = '';

  String get username => _username;
  String get profileImageUrl => _profileImageUrl;

  void setUser(String username, String profileImageUrl) {
    _username = username;
    _profileImageUrl = profileImageUrl;
    notifyListeners();
  }

Future<void> fetchUser(String email) async {
  FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;
      setUser(data['username'], data['profileImageUrl']);
    } else {
      print('No user found with this email');
    }
  });
}
}
