import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/bank_account_controller.dart';
import '../../data/models/bank_account_model.dart';

class MyBankAccountScreen extends StatelessWidget {
  const MyBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BankAccountController controller = Get.put(BankAccountController());
    return Scaffold(
      appBar: AppBar(title: const Text('Tài khoản ngân hàng')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.add(
            BankAccountModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              bankName: 'Vietcombank',
              accountNumber: '****1234',
              ownerName: 'User',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => ListView(
          children: controller.accounts
              .map(
                (e) => ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: Text(e.bankName),
                  subtitle: Text('${e.ownerName} - ${e.accountNumber}'),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
