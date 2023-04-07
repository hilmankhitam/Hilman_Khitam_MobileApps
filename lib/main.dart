import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hilman_mobile_apps/bloc/cart_bloc/cart_bloc.dart';
import 'package:hilman_mobile_apps/bloc/product_bloc/product_bloc.dart';
import 'package:hilman_mobile_apps/pages/pages.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(
            productServices: di.locator(),
          )..add(FetchProduct()),
        ),
        BlocProvider(
          create: (_) => CartBloc()..add(StartCart()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hilman Mobile Apps',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const HomePage(),
      ),
    );
  }
}
