import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Signupprovider/signupprovider.dart';
import 'package:ridemate/routing/routing.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/authtextform.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/view/Authentication/components/customrichtext.dart';
import 'package:ridemate/view/Authentication/components/phonefield.dart';
import 'package:ridemate/view/Authentication/components/socialbutton.dart';
import 'package:ridemate/view/Authentication/view/Login/login.dart';
import 'package:ridemate/view/Authentication/view/phoneverifyotp/phoneverifyotp.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

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
                    addVerticalspace(height: 30),
                    CustomText(
                      title: 'Sign up ',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Appcolors.contentPrimary,
                    ),
                    addVerticalspace(height: 20),
                    Authtextform(
                      hinttext: 'Enter your email',
                    ),
                    addVerticalspace(height: 20),
                    const Phonefield(),
                    addVerticalspace(height: 20),
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
                            'By signing up. you agree to',
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
                      text: 'Sign Up',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      borderRadius: 8,
                      ontap: () {
                        navigateToScreen(context, const Phoneverifyotp());
                      },
                    ),
                    addVerticalspace(height: 20),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Appcolors.contentDisbaled,
                          height: 1,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: CustomText(
                            title: 'or',
                            color: Appcolors.contentDisbaled,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          color: Appcolors.contentDisbaled,
                          height: 1,
                        )),
                      ],
                    ),
                    addVerticalspace(height: 20),
                    const Socialbutton(
                      text: 'Signup with Google',
                    ),
                    addVerticalspace(height: 20),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Customrichtext(
                          texts: const ['Already have an account?', 'Sign in'],
                          onTap: () {
                            navigateToScreen(context, const Login());
                          },
                        )),
                    addVerticalspace(height: 10),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
