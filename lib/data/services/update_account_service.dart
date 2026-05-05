import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UpdateAccountService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> updateField(UserModel currentUser, String key, String value) async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      throw Exception('Bạn chưa đăng nhập');
    }

    final String normalizedValue = value.trim();
    final Map<String, dynamic> updates = <String, dynamic>{key: normalizedValue};

    if (key == 'email' && normalizedValue.isNotEmpty) {
      await firebaseUser.verifyBeforeUpdateEmail(normalizedValue);
    }

    await _firestore.collection('users').doc(firebaseUser.uid).set(
          updates,
          SetOptions(merge: true),
        );

    switch (key) {
      case 'firstName':
        return currentUser.copyWith(firstName: normalizedValue);
      case 'lastName':
        return currentUser.copyWith(lastName: normalizedValue);
      case 'username':
        return currentUser.copyWith(username: normalizedValue);
      case 'email':
        return currentUser.copyWith(email: normalizedValue);
      case 'phone':
        return currentUser.copyWith(phone: normalizedValue);
      case 'gender':
        return currentUser.copyWith(gender: normalizedValue);
      case 'dateOfBirth':
        return currentUser.copyWith(dateOfBirth: normalizedValue);
      default:
        return currentUser;
    }
  }
}
