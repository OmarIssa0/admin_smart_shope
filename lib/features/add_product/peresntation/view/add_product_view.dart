import 'dart:io';

import 'package:admin_shope/core/utils/widgets/alert_dialog.dart';
import 'package:admin_shope/core/utils/widgets/title_text.dart';
import 'package:admin_shope/features/add_product/peresntation/view_model/model/product_model.dart';
import 'package:admin_shope/loading_manger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../core/constant/my_validators.dart';
import '../../../../core/utils/app_image.dart';

class AddProductView extends StatefulWidget {
  static const kAddProduct = '/kAddProduct';
  const AddProductView({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  // key
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  String? productNetworkImage;
  XFile? pickImage;

  // dropDown Bottom
  String? _categoryValue;

  bool _isLoading = false;

  String? productImageUrl;

// controller
  late TextEditingController _titleController,
      _priceController,
      _descriptionController,
      _quantityController;

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      _categoryValue = widget.productModel!.productCategory;
    }
    _titleController =
        TextEditingController(text: widget.productModel?.productTitle);
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    _descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _quantityController.clear();
    removePikerImage();
  }

  void removePikerImage() {
    setState(() {
      pickImage = null;
      productNetworkImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_categoryValue == null) {
      AlertDialogMethods.showDialogWaring(
        context: context,
        titleBottom: "Ok",
        subtitle: "Category is empty",
        lottileAnimation: "assets/lottie/error.json",
        function: () {
          Navigator.of(context).pop();
        },
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child("productsImages")
            .child("${_titleController.text.trim()}.jpg");

        await ref.putFile(File(pickImage!.path));
        productImageUrl = await ref.getDownloadURL();

        final productID = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("products")
            .doc(productID)
            .set({
          'productId': productID,
          'productTitle': _titleController.text,
          'productPrice': _priceController.text,
          'productImage': productImageUrl,
          'productCategory': _categoryValue,
          'productDescription': _descriptionController.text,
          'productQuantity': _quantityController.text,
          'createdAt': Timestamp.now(),
        });
        Fluttertoast.showToast(
          msg: "Product has been added",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        await AlertDialogMethods.showDialogWaring(
          isError: false,
          context: context,
          subtitle: "Clear form?",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kQuestion,
          // lottileAnimation: MangerImage.kError,
          function: () {
            clearForm();
            Navigator.of(context).pop();
          },
        );
      } on FirebaseException catch (error) {
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has been occured${error.message}.",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kError,
          function: () {
            // Navigator.of(context).pop
          },
        );
      } catch (error) {
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has been occured $error",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kError,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickImage == null && productNetworkImage == null) {
      AlertDialogMethods.showDialogWaring(
        context: context,
        subtitle: "Please pick up an image",
        titleBottom: "Ok",
        lottileAnimation: "assets/lottie/error.json",
        function: () {
          Navigator.pop(context);
        },
      );
      return;
    }
    if (_categoryValue == null) {
      AlertDialogMethods.showDialogWaring(
        context: context,
        subtitle: "Category is empty",
        titleBottom: "Ok",
        lottileAnimation: "assets/lottie/error.json",
        function: () {
          Navigator.pop(context);
        },
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });

        final productID = const Uuid().v4();
        if (pickImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("productsImages")
              .child("$productID.jpg");

          await ref.putFile(File(pickImage!.path));
          productImageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection("products")
            .doc(widget.productModel!.productId)
            .update({
          'productId': widget.productModel!.productId,
          'productTitle': _titleController.text,
          'productPrice': _priceController.text,
          'productImage': productImageUrl ?? productNetworkImage,
          'productCategory': _categoryValue,
          'productDescription': _descriptionController.text,
          'productQuantity': _quantityController.text,
          'createdAt': widget.productModel!.createdAt,
        });
        Fluttertoast.showToast(
          msg: "Product has been edited",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        await AlertDialogMethods.showDialogWaring(
          isError: false,
          context: context,
          subtitle: "Clear form?",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kQuestion,
          // lottileAnimation: MangerImage.kError,
          function: () {
            clearForm();
            Navigator.of(context).pop();
          },
        );
      } on FirebaseException catch (error) {
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has been occured${error.message}.",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kError,
          function: () {
            // Navigator.of(context).pop
          },
        );
      } catch (error) {
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has been occured $error",
          titleBottom: "Ok",
          lottileAnimation: MangerImage.kError,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await AlertDialogMethods.imagePickerDialog(
      context: context,
      cameraFunction: () async {
        pickImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          productImageUrl = null;
        });
      },
      galleryFunction: () async {
        pickImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          productImageUrl = null;
        });
      },
      removeFunction: () {
        setState(() {
          pickImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingMangerView(
      isLoading: _isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: TitleTextAppCustom(
                label: "Upload a new product", fontSize: 20.sp),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                IconlyLight.arrow_left_2,
                color: Colors.black,
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: Colors.red.shade300,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          IconlyLight.delete,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        TitleTextAppCustom(
                          label: "Clear",
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: Colors.blue.shade300,
                  onPressed: () {
                    if (isEditing) {
                      _editProduct();
                    } else {
                      _uploadProduct();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          IconlyLight.upload,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        TitleTextAppCustom(
                          label: isEditing ? "Edit Product" : "Upload Product",
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.r),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    if (isEditing && productNetworkImage != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          productNetworkImage!,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                    ] else if (pickImage == null) ...[
                      GestureDetector(
                        onTap: () {
                          localImagePicker();
                        },
                        child: SizedBox(
                          width: size.width * 0.4 + 10,
                          height: size.width * 0.4,
                          child: DottedBorder(
                              color: Colors.blue,
                              radius: const Radius.circular(12),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image_outlined,
                                      size: 80,
                                      color: Colors.blue,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        localImagePicker();
                                      },
                                      child: Text(
                                        "Pick Product image",
                                        style: TextStyle(
                                            color: Colors.blue.shade800),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ] else ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(
                            pickImage!.path,
                          ),
                          // width: size.width * 0.7,
                          height: size.width * 0.5,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                    if (pickImage != null || productNetworkImage != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              localImagePicker();
                            },
                            child: Text("Pick another image",
                                style: TextStyle(color: Colors.grey.shade600)),
                          ),
                          TextButton(
                            onPressed: () {
                              removePikerImage();
                            },
                            child: const Text(
                              "Remove image",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      )
                    ],
                    SizedBox(
                      height: 25.h,
                    ),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      hint: Text(_categoryValue ?? "Select Category"),
                      value: _categoryValue,
                      items: AppConstants.categoriesDropDownList,
                      onChanged: (String? value) {
                        setState(() {
                          _categoryValue = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextFormField(
                      controller: _titleController,
                      key: const ValueKey("Title"),
                      maxLength: 80,
                      minLines: 1,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: "Product Title",
                      ),
                      validator: (value) {
                        return MyValidators.uploadProductTexts(
                          value: value,
                          toBeReturnedString: "Please enter a valid title",
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _priceController,
                            key: const ValueKey('Price \$'),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}'),
                              ),
                            ],
                            decoration: InputDecoration(
                              prefix: TitleTextAppCustom(
                                label: "\$",
                                fontSize: 14.sp,
                                color: Colors.blue,
                              ),
                              hintText: "Price",
                            ),
                            validator: (value) {
                              return MyValidators.uploadProductTexts(
                                value: value,
                                toBeReturnedString: "Price is missing",
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Flexible(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: _quantityController,
                            key: const ValueKey("Quantity"),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Qty",
                            ),
                            validator: (value) {
                              return MyValidators.uploadProductTexts(
                                value: value,
                                toBeReturnedString: "Quantity is missed",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      key: const ValueKey("Description"),
                      maxLength: 1000,
                      minLines: 3,
                      maxLines: 8,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: "Product description",
                      ),
                      validator: (value) {
                        return MyValidators.uploadProductTexts(
                          value: value,
                          toBeReturnedString: "Description is missed",
                        );
                      },
                    ),
                    const SizedBox(
                      height: kBottomNavigationBarHeight + 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
