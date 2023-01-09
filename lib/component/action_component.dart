import 'package:flutter/material.dart';
import 'package:pharmacie/utils/custom_actions.dart';

import '../style/color.dart';
import '../style/text.dart';

class ActionComponent extends StatefulWidget {

  // texte param
  final String text;

  const ActionComponent({Key? key, required this.text}) : super(key: key);

  @override
  State<ActionComponent> createState() => _ActionComponentState();
}

class _ActionComponentState extends State<ActionComponent> {
  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: widget.text == CustomActions.connexion
            ? AppColors.green
            : widget.text == CustomActions.deconnexion
                ? AppColors.red
                : AppColors.blue,
        label: SecondaryText(text: widget.text));
  }
}
