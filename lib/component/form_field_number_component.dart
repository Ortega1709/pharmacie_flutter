import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../style/color.dart';
import 'form_field_component.dart';

/// form field number component
class FormFieldNumber extends StatefulWidget {

  /// attributes
  final int max;
  final TextEditingController controller;
  final TextEditingController montantController;
  final int montant;

  const FormFieldNumber({Key? key, required this.max, required this.controller, required this.montant, required this.montantController})
      : super(key: key);

  @override
  State<FormFieldNumber> createState() => _FormFieldNumberState();
}

class _FormFieldNumberState extends State<FormFieldNumber> {

  @override
  void initState() {
    widget.controller.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

      FloatingActionButton(
          onPressed: () {

            setState(() {
              if (int.parse(widget.controller.text) > 1) {

                int n = int.parse(widget.controller.text);
                n--;

                int montant = widget.montant * n;

                widget.montantController.text = montant.toString();
                widget.controller.text = n.toString();
              }
            });

          },
          backgroundColor: AppColors.blue,
          child: const Icon(Icons.remove, color: AppColors.white)),

      SizedBox(
        width: 70,
        child: TextFormField(
          controller: widget.controller,
          style: GoogleFonts.inter(color: AppColors.blue),
          cursorColor: AppColors.blue,
          keyboardType: TextInputType.number,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none),
          ),
        ),
      ),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: widget.montantController,
              style: GoogleFonts.inter(color: AppColors.blue),
              cursorColor: AppColors.blue,
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),

      FloatingActionButton(
          onPressed: () {
            setState(() {
              if (int.parse(widget.controller.text) < widget.max) {
                int n = int.parse(widget.controller.text);
                n++;

                int montant = widget.montant * n;

                widget.montantController.text = montant.toString();
                widget.controller.text = n.toString();
              }
            });
          },
          backgroundColor: AppColors.blue,
          child: const Icon(Icons.add, color: AppColors.white))
    ]);
  }
}
