import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilman_mobile_apps/models/models.dart';
import 'package:hilman_mobile_apps/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices productServices;
  ProductBloc({required this.productServices}) : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      List<ProductModel> products = await productServices.getProducts();
      emit(ProductInitial());

      emit(ProductLoaded(products: products));
    });
  }
}
