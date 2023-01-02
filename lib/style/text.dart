import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

/// primary text style
class PrimaryText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  const PrimaryText(
      {super.key,
        required this.text,
        this.color = AppColors.blue,
        this.fontWeight = FontWeight.w700,
        this.fontSize = 19.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),
    );
  }
}

/// secondary text style
class SecondaryText extends StatelessWidget {

  final String? text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  const SecondaryText(
      {super.key,
        required this.text,
        this.color = AppColors.white,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight
      ),
    );
  }
}

/// third text style
class ThirdText extends StatelessWidget {

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  const ThirdText(
      {super.key,
        required this.text,
        this.color = Colors.grey,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}