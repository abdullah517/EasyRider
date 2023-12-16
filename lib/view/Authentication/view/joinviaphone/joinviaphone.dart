import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Signupprovider/signupprovider.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/view/Authentication/components/customrichtext.dart';
import 'package:ridemate/view/Authentication/components/phonefield.dart';
import 'package:ridemate/view/Authentication/view/phoneverifyotp/phoneverifyotp.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Joinviaphone extends StatelessWidget {
  const Joinviaphone({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.scaffoldbgcolor,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalspace(height: 24.h),
                    const Backappbar(),
                    CustomText(
                      title: 'Join our team via Phone Number',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Appcolors.contentPrimary,
                    ),
                    addVerticalspace(height: 20),
                    const Phonefield(),
                    addVerticalspace(height: 10),
                    Row(
                      children: [
                        Consumer<Signupprovider>(
                          builder: (context, checkstate, child) => Checkbox(
                            value: checkstate.ischecked,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    Appcolors.successColor),
                            onChanged: (value) {
                              checkstate.setcheckstate(value);
                            },
                            checkColor: Appcolors.scaffoldbgcolor,
                            shape: const CircleBorder(),
                          ),
                        ),
                        Expanded(
                            child: Customrichtext(
                          texts: const [
                            'By joining us. you agree to our',
                            'Terms of service',
                            ' and ',
                            'Privacy policy.'
                          ],
                          color: Appcolors.contentDisbaled,
                        )),
                      ],
                    ),
                    addVerticalspace(height: 20),
                    Custombutton(
                      text: 'Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      borderRadius: 8,
                      ontap: () async {
                        navigateToScreen(context, const Phoneverifyotp());
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
