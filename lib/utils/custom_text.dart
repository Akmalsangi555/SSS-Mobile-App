
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final bool useJostStyle;

  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.useJostStyle = false,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: useJostStyle ? 1.18 : 1.25,
        letterSpacing: useJostStyle ? -0.2 : 0.0,
        fontFamily: useJostStyle ? 'sans-serif' : null,
      ),
    );
  }
}
