import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'blocs/category_cubit.dart';
import 'pages/order_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderCubit()),
        BlocProvider(create: (_) => CategoryCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Aplikasi Order Kasir",
        theme: ThemeData(
          primarySwatch: Colors.orange,
          brightness: Brightness.light,
          fontFamily: 'Roboto',
          cardTheme: CardThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          fontFamily: 'Roboto',
        ),
        themeMode: ThemeMode.system,
        home: OrderHomePage(),
      ),
    );
  }
}
