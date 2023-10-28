// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:new_shope/core/utils/widgets/title_text.dart';
// import 'package:new_shope/features/search/presentation/manger/model/product.model.dart';
// import 'package:new_shope/features/search/presentation/manger/provider/product_provider.dart';
// import 'package:provider/provider.dart';

// class TextFiledSearch extends StatefulWidget {
//   const TextFiledSearch({super.key});

//   @override
//   State<TextFiledSearch> createState() => _TextFiledSearchState();
// }

// class _TextFiledSearchState extends State<TextFiledSearch> {
//   late TextEditingController searchTextController;

//   @override
//   void initState() {
//     searchTextController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     searchTextController.dispose();
//     super.dispose();
//   }

//   List<ProductModel> productListSearch = [];

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     return Column(
//       children: [
//         TextField(
//           controller: searchTextController,
//           decoration: InputDecoration(
//             prefixIcon: Icon(
//               Icons.search,
//               color: Colors.grey.shade700,
//             ),
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 searchTextController.clear();
//                 FocusScope.of(context).unfocus();
//               },
//               child: const Icon(
//                 Icons.clear,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           onChanged: (value) {
//             setState(() {
//               productListSearch = productProvider.searchQuery(
//                   searchText: searchTextController.text);
//             });
//           },
//           onSubmitted: (value) {
//             setState(() {
//               productListSearch = productProvider.searchQuery(
//                   searchText: searchTextController.text);
//             });
//           },
//         ),
//         if (searchTextController.text.isNotEmpty &&
//             productListSearch.isEmpty) ...[
//           Center(
//               child: TitleTextAppCustom(
//                   label: "No results found", fontSize: 40.sp))
//         ]
//       ],
//     );
//   }
// }
