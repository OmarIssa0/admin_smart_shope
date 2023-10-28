import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/widgets/title_text.dart';
import '../../manger/provider/product_provider.dart';

class ProductWidgets extends StatefulWidget {
  const ProductWidgets({
    super.key,
    required this.productId,
  });

  final String productId;
  @override
  State<ProductWidgets> createState() => _ProductWidgetsState();
}

class _ProductWidgetsState extends State<ProductWidgets> {
  @override
  Widget build(BuildContext context) {
    // product provider
    final productProviderSearch = Provider.of<ProductProvider>(context);
    final getCurrentProduct =
        productProviderSearch.findByProductId(widget.productId);

    // mediaQuery
    Size size = MediaQuery.of(context).size;

    // Ui
    // اذا ال get null
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(14.r),
              onTap: () async {
                // Navigator.of(context).pushNamed(DetailsView.kDetails,
                //     arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.22,
                      boxFit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TitleTextAppCustom(
                          label: getCurrentProduct.productTitle,
                          fontSize: 18.sp,
                          maxLine: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TitleTextAppCustom(
                            label: "${getCurrentProduct.productPrice}\$",
                            fontSize: 18.sp,
                            color: Colors.blue.shade900,
                            // color: AppColor.kRedColorPrice,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
