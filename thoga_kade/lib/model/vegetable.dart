class Vegetable {
  final String id;
  final String name;
  final double pricePerKg;
  double availableQuantity;
  final String category;
  final DateTime expiryDate;

  Vegetable({
    required this.id,
    required this.name,
    required this.pricePerKg,
    required this.availableQuantity,
    required this.category,
    required this.expiryDate,
  });

  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      id: json['id'],
      name: json['name'],
      pricePerKg: json['pricePerKg'],
      availableQuantity: json['availableQuantity'],
      category: json['category'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pricePerKg': pricePerKg,
      'availableQuantity': availableQuantity,
      'category': category,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }
}
