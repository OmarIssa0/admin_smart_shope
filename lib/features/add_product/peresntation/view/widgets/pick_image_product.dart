import 'dart:io';

import 'package:admin_shope/core/utils/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProductWidgets extends StatefulWidget {
  const PickImageProductWidgets({super.key});

  @override
  State<PickImageProductWidgets> createState() =>
      _PickImageProductWidgetsState();
}

class _PickImageProductWidgetsState extends State<PickImageProductWidgets> {
  XFile? pickImage;

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await AlertDialogMethods.imagePickerDialog(
      context: context,
      cameraFunction: () async {
        pickImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFunction: () async {
        pickImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
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
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            await localImagePicker();
          },
          child: Padding(
            padding: EdgeInsets.all(5.0.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: pickImage == null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(),
                      ),
                    )
                  : Image.file(
                      File(pickImage!.path),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.blue.shade500,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: () async {
                await localImagePicker();
              },
              child: Padding(
                padding: EdgeInsets.all(4.0.r),
                child: const Icon(
                  IconlyLight.image,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
