part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded({required this.products});
  @override
  List<Object?> get props => [];
}
