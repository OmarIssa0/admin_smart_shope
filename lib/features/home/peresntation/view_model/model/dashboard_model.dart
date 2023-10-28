import 'package:admin_shope/features/search/presentation/view/search_view.dart';
import 'package:flutter/material.dart';

class DashboardBottomModel {
  final String text, lottiePath;
  final Function function;

  DashboardBottomModel({
    required this.text,
    required this.lottiePath,
    required this.function,
  });

  static List<DashboardBottomModel> dashboardBottomList(BuildContext context) =>
      [
        DashboardBottomModel(
          text: "Add a new product",
          lottiePath: 'assets/lottie/add.json',
          function: () {},
        ),
        DashboardBottomModel(
          text: "inspect all product",
          lottiePath: 'assets/lottie/inspect.json',
          function: () {
            Navigator.of(context).pushNamed(SearchView.kSearch);
          },
        ),
        DashboardBottomModel(
          text: "View Orders",
          lottiePath: 'assets/lottie/all_order.json',
          function: () {},
        ),
      ];
}
