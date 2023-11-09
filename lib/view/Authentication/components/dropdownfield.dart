import 'package:flutter/material.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

class Dropdownfield extends StatelessWidget {
  final List<String> mylist;
  const Dropdownfield({super.key, required this.mylist});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: 'Gender',
        hintStyle: gethintstyle(),
        border: OutlineInputBorder(),
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
