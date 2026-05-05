import '../models/bank_account_model.dart';

class BankAccountService {
  final List<BankAccountModel> _accounts = <BankAccountModel>[];

  List<BankAccountModel> getAll() => List<BankAccountModel>.from(_accounts);

  void add(BankAccountModel account) => _accounts.add(account);
}
