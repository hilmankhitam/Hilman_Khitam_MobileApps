part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class StartCart extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddProductCart extends CartEvent {
  final ProductModel product;

  const AddProductCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveProductCart extends CartEvent {
  final ProductModel product;

  const RemoveProductCart({required this.product});

  @override
  List<Object?> get props => [product];
}

class CheckoutCart extends CartEvent {
  @override
  List<Object?> get props => [];
}
