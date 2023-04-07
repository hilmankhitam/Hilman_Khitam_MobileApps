part of 'models.dart';

class Cart extends Equatable {
  final List<ProductModel> products;

  const Cart({this.products = const <ProductModel>[]});

  @override
  List<Object?> get props => [products];

  Map productQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get total =>
      products.fold(0, (total, current) => total + current.price!);
}
