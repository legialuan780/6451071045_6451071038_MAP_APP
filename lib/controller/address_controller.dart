import 'package:get/get.dart';
import '../data/models/address_model.dart';
import '../data/services/address_service.dart';

class AddressController extends GetxController {
  final AddressService _service = AddressService();
  final RxList<AddressModel> addresses = <AddressModel>[].obs;

  void add(AddressModel address) {
    _service.add(address);
    addresses.assignAll(_service.getAll());
  }
}
