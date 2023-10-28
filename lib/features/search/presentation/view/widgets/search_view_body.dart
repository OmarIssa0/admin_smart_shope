import 'package:admin_shope/features/search/presentation/view/widgets/product_widgets.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/widgets/title_text.dart';
import '../../manger/model/product.model.dart';
import '../../manger/provider/product_provider.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final passedCategory = ModalRoute.of(context)!.settings.arguments;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(
            categoryName: passedCategory.toString());

    // Ui
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: productList.isEmpty
          ? Center(
              child: TitleTextAppCustom(
                label: 'No product found',
                fontSize: 20.sp,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade700,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      productListSearch = productProvider.searchQuery(
                        searchText: searchTextController.text,
                        passedList: productList,
                      );
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      productListSearch = productProvider.searchQuery(
                        searchText: searchTextController.text,
                        passedList: productList,
                      );
                    });
                  },
                ),
                // const TextFiledSearch(),
                SizedBox(
                  height: 15.h,
                ),
                if (searchTextController.text.isNotEmpty &&
                    productListSearch.isEmpty) ...[
                  Center(
                    child: TitleTextAppCustom(
                      label: "No results found",
                      fontSize: 27.sp,
                    ),
                  ),
                ],
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: searchTextController.text.isNotEmpty
                        ? productListSearch.length
                        : productList.length,
                    builder: ((context, index) {
                      return ProductWidgets(
                        productId: searchTextController.text.isNotEmpty
                            ? productListSearch[index].productId
                            : productList[index].productId,
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
    );
  }
}
