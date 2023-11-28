import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Loginprovider/loginprovider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/authtextform.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/view/Authentication/components/customrichtext.dart';
import 'package:ridemate/view/Authentication/components/socialbutton.dart';
import 'package:ridemate/view/Authentication/view/Signup/signup.dart';
import 'package:ridemate/view/Authentication/view/sendverification/sendverification.dart';
import 'package:ridemate/view/Homepage/homepage.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';

import '../../../../routing/routing.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.scaffoldbgcolor,
        body: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalspace(height: 24.h),
                const Backappbar(),
                addVerticalspace(height: 30),
                CustomText(
                  title: 'Sign in ',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Appcolors.contentPrimary,
                ),
                addVerticalspace(height: 24),
                Authtextform(
                  hinttext: 'Email or Phone Number',
                ),
                addVerticalspace(height: 20),
                Consumer<LoginProvider>(
                  builder: (context, loginprovider, child) => Authtextform(
                    hinttext: 'Enter Your Password',
                    visibility: loginprovider.visibility,
                    suffixIcon: IconButton(
                      onPressed: loginprovider.changevisibility,
                      icon: loginprovider.visibility
                          ? const Icon(
                              Icons.visibility_off,
                              color: Appcolors.contentSecondary,
                            )
                          : const Icon(Icons.visibility),
                      color: Appcolors.contentSecondary,
                    ),
                  ),
                ),
                addVerticalspace(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () =>
                        navigateToScreen(context, const Sendverification()),
                    child: CustomText(
                      title: 'Forget password?',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Appcolors.errorColor,
                    ),
                  ),
                ),
                addVerticalspace(height: 40),
                Custombutton(
                  text: 'Sign In',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                  ontap: () => navigateToScreen(context, const Homepage()),
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
                  text: 'Login with Google',
                ),
                addVerticalspace(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Customrichtext(
                    texts: const ["Don't have an account?", "Sign Up"],
                    onTap: () {
                      navigateToScreen(context, const Signup());
                    },
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
