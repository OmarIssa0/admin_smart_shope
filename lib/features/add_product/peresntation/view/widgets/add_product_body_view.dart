import 'package:admin_shope/features/add_product/peresntation/view/widgets/pick_image_product.dart';
import 'package:flutter/material.dart';

class AddProductBodyView extends StatelessWidget {
  const AddProductBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.width * 0.4,
          width: size.width * 0.4,
          child: const PickImageProductWidgets(),
        ),
      ],
    );
  }
}
