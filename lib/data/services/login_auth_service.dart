import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> loginWithEmailPassword(String email, String password) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Không tìm thấy người dùng');
      }

      if (!firebaseUser.emailVerified) {
        await firebaseUser.sendEmailVerification();
        throw Exception('EMAIL_NOT_VERIFIED');
      }

      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) {
        final String emailValue = firebaseUser.email ?? email;
        final String username = emailValue.split('@').first;
        final UserModel newUser = UserModel(
          id: firebaseUser.uid,
          firstName: username,
          lastName: '',
          username: username,
          email: emailValue,
          phone: firebaseUser.phoneNumber ?? '',
        );
        await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toMap());
        return newUser;
      }

      final Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      final UserModel userModel = UserModel.fromMap(data);
      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Email không tồn tại');
      }
      if (e.code == 'wrong-password') {
        throw Exception('Mật khẩu không đúng');
      }
      if (e.code == 'invalid-email') {
        throw Exception('Email không hợp lệ');
      }
      if (e.code == 'user-disabled') {
        throw Exception('Tài khoản đã bị vô hiệu hóa');
      }
      throw Exception('Đăng nhập thất bại');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        final User? currentUser = _auth.currentUser;
        if (currentUser != null) {
          final String emailValue = currentUser.email ?? email;
          final String username = emailValue.split('@').first;
          return UserModel(
            id: currentUser.uid,
            firstName: username,
            lastName: '',
            username: username,
            email: emailValue,
            phone: currentUser.phoneNumber ?? '',
          );
        }
        throw Exception(
          'Tài khoản đã đăng nhập nhưng chưa có quyền đọc dữ liệu người dùng trên Firestore.',
        );
      }
      throw Exception('Lỗi dữ liệu: ${e.message ?? e.code}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
