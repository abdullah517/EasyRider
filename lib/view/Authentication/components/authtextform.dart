import 'package:flutter/material.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

import '../../../utils/appcolors.dart';

class Authtextform extends StatelessWidget {
  final String? hinttext;
  final Widget? suffixIcon;
  final bool readonly;
  final TextEditingController? controller;
  const Authtextform({
    super.key,
    this.hinttext,
    this.suffixIcon,
    this.readonly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolors.primaryColor,
      readOnly: readonly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: gethintstyle(),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.neutralgrey200)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.primaryColor)),
      ),
    );
  }
}
