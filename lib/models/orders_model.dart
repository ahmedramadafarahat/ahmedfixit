class OrderModel {
  final String address;
  final String date;
  final String description;
  final String name;
  final String payment;
  final String phone;
  final String status;
  final String id;

  OrderModel({
    required this.address,
    required this.date,
    required this.description,
    required this.name,
    required this.payment,
    required this.phone,
    required this.status,
    required this.id,
  });

  factory OrderModel.fromFirestore(Map<String, dynamic> data, String id) {
    return OrderModel(
      address: data['address'] ?? '',
      date: data['date'] ?? '',
      description: data['description'] ?? '',
      name: data['name'] ?? '',
      payment: data['payment'] ?? '',
      phone: data['phone'] ?? '',
      status: data['status'] ?? '',
      id: id,
    );
  }
}
