import 'package:flutter/material.dart';

import '../style/color.dart';
import '../style/text.dart';

/// header dialog component
class HeaderDialog extends StatelessWidget {

  /// attribute
  final String title;
  const HeaderDialog({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(text: title, color: AppColors.blue),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.blue,
          ),
        )
      ],
    );
  }
}
