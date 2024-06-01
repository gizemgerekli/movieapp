import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';

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
  final databaseReference = FirebaseDatabase.instance.ref();
  // 'users' koleksiyonundan veriyi çek
  await databaseReference.child('users').orderByChild('email').equalTo(email).once().then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      // Veri bulunduysa kullanıcı bilgilerini ayarla
      final data = snapshot.value as Map<dynamic, dynamic>;
      setUser(data['username'], data['profileImageUrl']);
    } else {
      print('Bu e-posta ile ilişkilendirilmiş kullanıcı bulunamadı.');
    }
  } as FutureOr Function(DatabaseEvent value));
}
}
