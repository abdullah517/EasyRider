import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ridemate/view/Authentication/components/hinttextstyle.dart';

class Phonefield extends StatelessWidget {
  const Phonefield({super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Your mobile number',
        labelStyle: gethintstyle(),
        border: OutlineInputBorder(),
      ),
      initialCountryCode: 'PK',
      onChanged: (phone) {},
    );
  }
}
