import 'package:admin_shope/core/utils/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class AlertDialogMethods {
  // static Future<void> showDialogWaring({
  //   required BuildContext context,
  //   required String titleBottom,
  //   String? subtitle,
  //   required String lottileAnimation,
  //   required Function function,
  //   bool isError = true,
  // }) async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.grey.shade900.withOpacity(.75),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             LottieBuilder.asset(
  //               lottileAnimation,
  //             ),
  //             TitleTextAppCustom(
  //               label: subtitle ?? '',
  //               fontSize: 18.sp,
  //               color: Colors.white,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 12),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       function();
  //                       // Navigator.of(context).pop();
  //                     },
  //                     child: TitleTextAppCustom(
  //                       label: titleBottom,
  //                       fontSize: 16.sp,
  //                       // color: AppColor.kRedColorPrice,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10.w,
  //                   ),
  //                   Visibility(
  //                     visible: !isError,
  //                     child: TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: TitleTextAppCustom(
  //                         label: 'Cancel',
  //                         fontSize: 16.sp,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // static Future<void> showDialogForgotPassword({
  //   required BuildContext context,
  //   required String titleBottom,
  //   String? subtitle,
  //   required String lottileAnimation,
  //   required Function function,
  //   bool isError = true,
  // }) async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.grey.shade900.withOpacity(.75),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: LottieBuilder.asset(
  //                 lottileAnimation,
  //               ),
  //             ),
  //             TitleTextAppCustom(
  //               label: subtitle ?? '',
  //               fontSize: 18.sp,
  //               color: Colors.white,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 12),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       function();
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: TitleTextAppCustom(
  //                       label: titleBottom,
  //                       fontSize: 16.sp,
  //                       // color: AppColor.kRedColorPrice,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10.w,
  //                   ),
  //                   Visibility(
  //                     visible: !isError,
  //                     child: TextButton(
  //                       onPressed: () {},
  //                       child: TitleTextAppCustom(
  //                         label: 'Cancel',
  //                         fontSize: 16.sp,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFunction,
    required Function galleryFunction,
    required Function removeFunction,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Center(
            child: TitleTextAppCustom(
              label: 'Choose option',
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(children: [
              SizedBox(
                height: 20.h,
              ),
              TextButton.icon(
                onPressed: () {
                  cameraFunction();
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(IconlyLight.camera),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  galleryFunction();
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(IconlyLight.image),
                label: const Text("Gallery"),
              ),
              TextButton.icon(
                onPressed: () {
                  removeFunction();
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(IconlyLight.delete),
                label: const Text("Remove"),
              ),
            ]),
          ),
        );
      },
    );
  }
}
