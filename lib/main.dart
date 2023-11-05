import 'package:admin_shope/core/utils/theme_data.dart';
import 'package:admin_shope/core/utils/widgets/title_text.dart';
import 'package:admin_shope/features/add_product/peresntation/view/add_product_view.dart';
import 'package:admin_shope/features/home/peresntation/view/home_view.dart';
import 'package:admin_shope/features/search/presentation/manger/provider/product_provider.dart';
import 'package:admin_shope/features/search/presentation/view/search_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: TitleTextAppCustom(
                label: "An error has been occured ${snapshot.error}",
                fontSize: 14,
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ProductProvider(),
            ),
          ],
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                child: MaterialApp(
                  theme: Styles.themeData(context: context),
                  debugShowCheckedModeBanner: false,
                  initialRoute: HomeView.kHome,
                  routes: {
                    HomeView.kHome: (context) => const HomeView(),
                    AddProductView.kAddProduct: (context) =>
                        const AddProductView(),
                    SearchView.kSearch: (context) => const SearchView(),
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
