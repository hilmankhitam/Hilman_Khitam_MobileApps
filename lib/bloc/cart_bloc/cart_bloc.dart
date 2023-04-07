import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilman_mobile_apps/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<StartCart>((event, emit) async {
      emit(CartLoading());

      emit(const CartLoaded());
    });

    on<AddProductCart>((event, emit) {
      final state = this.state;
      emit(CartLoading());

      if (state is CartLoaded) {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)..add(event.product))));
      }
    });
    on<RemoveProductCart>((event, emit) {
      final state = this.state;
      emit(CartLoading());

      if (state is CartLoaded) {
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)
                  ..remove(event.product))));
      }
    });
    on<CheckoutCart>((event, emit) {
      final state = this.state;
      emit(CartLoading());

      if (state is CartLoaded) {
        emit(const CartLoaded(cart: Cart(products: [])));
      }
    });
  }
}
