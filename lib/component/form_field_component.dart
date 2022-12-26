import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/color.dart';

/// custom form field
class CostumFormField extends StatelessWidget {

  /// attributes
  final String hintText;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CostumFormField({Key? key,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: AppColors.blue),
      cursorColor: AppColors.blue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: Icon(
          icon!,
          color: AppColors.blue,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: AppColors.grey),
      ),
    );
  }
}