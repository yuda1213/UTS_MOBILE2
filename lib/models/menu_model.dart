class MenuModel {
  final String id;
  final String name;
  final int price;
  final String category;
  final double discount; // 0–1 (misal 0.2 berarti diskon 20%)

  MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.discount,
  });

  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }

  MenuModel copyWith({
    String? id,
    String? name,
    int? price,
    String? category,
    double? discount,
  }) {
    return MenuModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      discount: discount ?? this.discount,
    );
  }

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      discount: (json['discount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'discount': discount,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
