import 'package:flutter/material.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

import '../../../utils/appcolors.dart';

// ignore: must_be_immutable
class Authtextform extends StatelessWidget {
  String? hinttext;
  Widget? suffixIcon;
  bool visibility;
  Authtextform(
      {super.key, this.hinttext, this.suffixIcon, this.visibility = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolors.primaryColor,
      obscureText: visibility,
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
