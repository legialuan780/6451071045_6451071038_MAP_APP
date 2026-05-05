class AddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String addressLine;

  const AddressModel({required this.id, required this.fullName, required this.phone, required this.addressLine});

  Map<String, dynamic> toMap() => {
    'id': id,
    'fullName': fullName,
    'phone': phone,
    'addressLine': addressLine,
  };

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
    id: map['id'] as String? ?? '',
    fullName: map['fullName'] as String? ?? '',
    phone: map['phone'] as String? ?? '',
    addressLine: map['addressLine'] as String? ?? '',
  );
}
