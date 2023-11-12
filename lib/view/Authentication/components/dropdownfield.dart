import 'package:flutter/material.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

import '../../../utils/appcolors.dart';

class Dropdownfield extends StatelessWidget {
  final List<String> mylist;
  final String hinttext;
  const Dropdownfield(
      {super.key, required this.mylist, this.hinttext = 'Gender'});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: gethintstyle(),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.neutralgrey200)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.primaryColor)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: List.generate(
          mylist.length,
          (index) => DropdownMenuItem(
                value: mylist[index],
                child: Text(mylist[index]),
              )),
      onChanged: (value) {},
    );
  }
}
