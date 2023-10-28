import 'package:admin_shope/core/utils/theme_data.dart';
import 'package:admin_shope/features/home/peresntation/view/home_view.dart';
import 'package:admin_shope/features/search/presentation/manger/provider/product_provider.dart';
import 'package:admin_shope/features/search/presentation/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
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
                SearchView.kSearch: (context) => const SearchView(),
              },
            ),
          );
        },
      ),
    );
  }
}
