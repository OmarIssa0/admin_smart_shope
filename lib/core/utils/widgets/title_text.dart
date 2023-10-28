import 'package:flutter/material.dart';

class TitleTextAppCustom extends StatelessWidget {
  const TitleTextAppCustom({
    super.key,
    required this.label,
    this.color = const Color(0xff0C1A30),
    required this.fontSize,
    this.maxLine = 1,
    this.fontWeight = FontWeight.normal,
    this.decoration = TextDecoration.none,
  });

  final String label;
  final Color color;
  final double fontSize;
  final int maxLine;
  final FontWeight fontWeight;
  final TextDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
