import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product.model.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _products = [];
  List<ProductModel> get getProducts {
    return _products;
  }

  // راح نرجع ال
  // product id
  ProductModel? findByProductId(String productId) {
    // اذا حصلنا اي منتج داخل ال List
    if (_products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    // اول وحدة بترجع
    return _products.firstWhere((element) => element.productId == productId);
  }

  // Navigator category
  List<ProductModel> findByCategory({required String categoryName}) {
    List<ProductModel> categoryList = _products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  // Search Product
  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final productDB = FirebaseFirestore.instance.collection("products");
  Future<List<ProductModel>> fetchProducts() async {
    try {
      await productDB
          // .orderBy("createAt", descending: false)
          .get()
          .then((productsSnapshot) {
        _products.clear();
        for (var element in productsSnapshot.docs) {
          _products.insert(0, ProductModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return _products;
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchProductStream() {
    try {
      return productDB.snapshots().map((snapshot) {
        _products.clear();
        for (var element in snapshot.docs) {
          _products.insert(0, ProductModel.fromFirestore(element));
        }
        return _products;
      });
    } catch (e) {
      rethrow;
    }
  }
}
