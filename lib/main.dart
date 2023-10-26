import 'package:admin_shope/features/home/peresntation/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.kHome,
      routes: {
        HomeView.kHome: (context) => const HomeView(),
      },
    );
  }
}
