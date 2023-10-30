// import 'package:admin_shope/core/utils/widgets/title_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconly/iconly.dart';

// class BottomNavigationBarAddProductView extends StatelessWidget {
//   const BottomNavigationBarAddProductView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         MaterialButton(
//           shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r)),
//           color: Colors.red.shade300,
//           onPressed: () {},
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               children: [
//                 const Icon(
//                   IconlyLight.delete,
//                   color: Colors.white,
//                 ),
//                 SizedBox(
//                   width: 12.w,
//                 ),
//                 TitleTextAppCustom(
//                   label: "Clear",
//                   fontSize: 18.sp,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         MaterialButton(
//           shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r)),
//           color: Colors.blue.shade300,
//           onPressed: () {},
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               children: [
//                 const Icon(
//                   IconlyLight.upload,
//                   color: Colors.white,
//                 ),
//                 SizedBox(
//                   width: 12.w,
//                 ),
//                 TitleTextAppCustom(
//                   label: "Upload Product",
//                   fontSize: 18.sp,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
