import '../models/address_model.dart';

class AddressService {
  final List<AddressModel> _items = <AddressModel>[];

  List<AddressModel> getAll() => List<AddressModel>.from(_items);

  void add(AddressModel address) => _items.add(address);
}
