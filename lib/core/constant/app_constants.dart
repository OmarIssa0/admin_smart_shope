import 'package:flutter/material.dart';

class AppConstants {
  static const String productImageUrl =
      "https://eshop.sa.zain.com/wp-content/uploads/2023/09/iPhone_15_Pro_Max_Blue_Titanium_Pure_Back_iPhone_15_Pro_Max_Blue_Titanium_Pure_Front_2up_Screen__USEN.png";

  static List<String> categoriesList = [
    "Phones",
    "Laptops",
    "Electronics",
    "Watches",
    "Clothes",
    "Shoes",
    "Books",
    "Cosmetics",
    "Accessories",
  ];
  static List<DropdownMenuItem<String>>? get categoriesDropDownList {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      categoriesList.length,
      (index) => DropdownMenuItem(
        value: categoriesList[index],
        child: Text(
          categoriesList[index],
        ),
      ),
    );

    return menuItem;
  }
}
