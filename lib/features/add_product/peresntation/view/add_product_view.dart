import 'package:admin_shope/features/add_product/peresntation/view/widgets/add_product_body_view.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  static const kAddProduct = '/kAddProduct';
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddProductBodyView(),
    );
  }
}
