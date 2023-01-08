import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../style/color.dart';

/// search bar component
class SearchBar extends StatelessWidget {

  /// attribute
  final String hintText;
  final void Function(String)? onChange;

  const SearchBar({Key? key, required this.hintText, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.inter(color: AppColors.blue),
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: const Icon(
            CupertinoIcons.search,
            color: AppColors.blue),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: AppColors.grey),
      ),
    );
  }
}
