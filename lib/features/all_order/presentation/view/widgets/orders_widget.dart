import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/title_text.dart';
import '../../view_model/model/order_model.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.30,
              width: size.width * 0.25,
              imageUrl: widget.orderModel.imageUrl,
              boxFit: BoxFit.contain,
              // 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitleTextAppCustom(
                          label: widget.orderModel.productTitle,
                          maxLine: 2,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const TitleTextAppCustom(
                        label: 'Price:  ',
                        fontSize: 15,
                      ),
                      Flexible(
                        child: TitleTextAppCustom(
                          label: "${widget.orderModel.price}\$",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TitleTextAppCustom(
                    label: "Qty: ${widget.orderModel.quantity}",
                    fontSize: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TitleTextAppCustom(
                          label: 'name user : ${widget.orderModel.userName} ',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
