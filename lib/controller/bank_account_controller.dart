import 'package:get/get.dart';
import '../data/models/bank_account_model.dart';
import '../data/services/bank_account_service.dart';

class BankAccountController extends GetxController {
  final BankAccountService _service = BankAccountService();
  final RxList<BankAccountModel> accounts = <BankAccountModel>[].obs;

  void add(BankAccountModel account) {
    _service.add(account);
    accounts.assignAll(_service.getAll());
  }
}
