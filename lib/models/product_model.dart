part of 'models.dart';

class ProductModel extends Equatable {
  final String? foodCode;
  final String? name;
  final String? picture;
  final String? pictureOri;
  final DateTime? createdAt;
  final double? price;
  final int? id;

  const ProductModel({
    this.foodCode,
    this.name,
    this.picture,
    this.pictureOri,
    this.createdAt,
    this.price,
    this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        foodCode: json['food_code'] ?? "FOODAYAM",
        name: json['name'] ?? "Ayam Bakar",
        picture: json['picture'] ??
            "https://asset.kompas.com/crops/nsueiJRoh-BTF94-Y71Nv0f3Zj0=/3x0:700x465/780x390/data/photo/2020/12/30/5fec5602f116e.jpg",
        pictureOri: json['picture_ori'],
        createdAt:
            DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
        price: double.parse(json['price'] != "" ? json['price'] : "12000"),
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'food_code': foodCode,
        'name': name,
        'picture': picture,
        'picture_ori': pictureOri,
        'created_at': "${DateTime.now()}",
        'price': "$price"
      };

  @override
  List<Object?> get props =>
      [foodCode, name, picture, pictureOri, price, createdAt, id];
}
