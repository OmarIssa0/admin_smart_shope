import 'package:admin_shope/features/add_product/peresntation/view/add_product_view.dart';
import 'package:admin_shope/features/all_order/presentation/view/all_order_view.dart';
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
          function: () {
            Navigator.of(context).pushNamed(AddProductView.kAddProduct);
          },
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
          function: () {
            Navigator.of(context).pushNamed(AllOrderView.kAllOrder);
          },
        ),
      ];
}
