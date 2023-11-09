import 'package:admin_shope/features/all_order/presentation/view/widgets/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/widgets/title_text.dart';
import '../view_model/model/order_model.dart';
import '../view_model/provider/order_provider.dart';

class AllOrderView extends StatefulWidget {
  static const kAllOrder = '/kAllOrder';
  const AllOrderView({super.key});

  @override
  State<AllOrderView> createState() => _AllOrderViewState();
}

class _AllOrderViewState extends State<AllOrderView> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TitleTextAppCustom(label: "All Order", fontSize: 20.sp),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconlyLight.arrow_left_2,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: orderProvider.fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child:
                  SelectableText("An error has been occured ${snapshot.error}"),
            );
          } 
          // else if (!snapshot.hasData || orderProvider.getOrders.isEmpty) {
          //   return EmptyWidgets(
          //     title: 'Whoops!',
          //     subTitle: 'No orders has been placed yet',
          //     titleBottom: 'Shope Now',
          //     function: () {
          //       Navigator.of(context).pushNamed(RootView.kRoot);
          //     },
          //   );
          
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidgetFree(
                  orderModel: orderProvider.getOrders[index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
