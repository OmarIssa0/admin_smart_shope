import 'package:admin_shope/core/utils/widgets/title_text.dart';
import 'package:admin_shope/features/home/peresntation/view/widgets/home_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const kHome = '/kHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleTextAppCustom(label: 'Dashboard View', fontSize: 16.sp),
      ),
      body: const HomeViewBody(),
    );
  }
}
