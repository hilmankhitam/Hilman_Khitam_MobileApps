import 'package:get_it/get_it.dart';
import 'package:hilman_mobile_apps/bloc/product_bloc/product_bloc.dart';
import 'package:hilman_mobile_apps/services/product_services.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => ProductBloc(
      productServices: locator(),
    ),
  );

  //services
  locator.registerLazySingleton<ProductServices>(() => ProductServices());
}
