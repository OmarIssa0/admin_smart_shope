import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/widgets/title_text.dart';

class DashboardBottomWidget extends StatelessWidget {
  const DashboardBottomWidget({
    super.key,
    required this.title,
    required this.lottiePath,
    required this.function,
  });

  final String title, lottiePath;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Card(
        elevation: 0,
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottiePath,
              height: 85,
              width: 85,
            ),
            SizedBox(
              height: 15.h,
            ),
            TitleTextAppCustom(label: title, fontSize: 15.sp),
          ],
        ),
      ),
    );
  }
}
