import 'package:get/get.dart';
import '../data/services/update_account_service.dart';

class UpdateAccountController extends GetxController {
  final UpdateAccountService _service = UpdateAccountService();

  Future<void> updateField(String key, String value) async {
    await _service.updateField(key, value);
  }
}
