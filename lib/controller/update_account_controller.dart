import 'package:get/get.dart';
import 'login_controller.dart';
import '../data/models/user_model.dart';
import '../data/services/update_account_service.dart';

class UpdateAccountController extends GetxController {
  final UpdateAccountService _service = UpdateAccountService();
  final AuthController _authController = Get.find<AuthController>();

  Future<void> updateField(String key, String value) async {
    final UserModel? user = _authController.currentUser;
    if (user == null) {
      throw Exception('Không tìm thấy tài khoản đăng nhập');
    }
    final UserModel updatedUser = await _service.updateField(user, key, value);
    _authController.setCurrentUser(updatedUser);
  }
}
