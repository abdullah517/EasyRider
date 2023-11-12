import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ridemate/widgets/spacing.dart';

class Custompinput extends StatelessWidget {
  const Custompinput({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 48,
      textStyle: const TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(65, 65, 65, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(7.1),
        border: Border.all(color: const Color.fromRGBO(208, 208, 208, 1)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(7.1),
      border: Border.all(color: const Color.fromRGBO(246, 205, 86, 1)),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(255, 253, 231, 1),
        borderRadius: BorderRadius.circular(7.1),
        border: Border.all(color: const Color.fromRGBO(246, 205, 86, 1)),
      ),
    );
    return Pinput(
      cursor: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 9),
          width: 22,
          height: 1,
          color: const Color.fromRGBO(246, 205, 86, 1),
        ),
      ),
      defaultPinTheme: defaultPinTheme,
      length: 5,
      separatorBuilder: (index) => addHorizontalspace(width: 8),
      validator: (value) {
        return value == '22222' ? null : 'wrong otp';
      },
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
    );
  }
}
