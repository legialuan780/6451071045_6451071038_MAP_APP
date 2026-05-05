import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/address_controller.dart';
import '../../data/models/address_model.dart';

class MyShippingAddressScreen extends StatelessWidget {
  const MyShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(title: const Text('Địa chỉ giao hàng')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.add(
            AddressModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              fullName: 'Nguyen Van A',
              phone: '0900000000',
              addressLine: 'TP HCM',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => ListView(
          children: controller.addresses
              .map(
                (e) => ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(e.fullName),
                  subtitle: Text('${e.phone} - ${e.addressLine}'),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
