class BankAccountModel {
  final String id;
  final String bankName;
  final String accountNumber;
  final String ownerName;

  const BankAccountModel({required this.id, required this.bankName, required this.accountNumber, required this.ownerName});

  Map<String, dynamic> toMap() => {
    'id': id,
    'bankName': bankName,
    'accountNumber': accountNumber,
    'ownerName': ownerName,
  };

  factory BankAccountModel.fromMap(Map<String, dynamic> map) => BankAccountModel(
    id: map['id'] as String? ?? '',
    bankName: map['bankName'] as String? ?? '',
    accountNumber: map['accountNumber'] as String? ?? '',
    ownerName: map['ownerName'] as String? ?? '',
  );
}
