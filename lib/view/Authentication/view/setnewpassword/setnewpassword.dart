import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/authtextform.dart';
import 'package:ridemate/view/Authentication/components/backappbar.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';
import '../../../../Providers/newpasswordprovider/newpasswordprovider.dart';
import '../../../../widgets/custombutton.dart';

class Setnewpassword extends StatelessWidget {
  const Setnewpassword({super.key});

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
                Center(
                  child: CustomText(
                    title: 'Set New password',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Appcolors.contentSecondary,
                  ),
                ),
                addVerticalspace(height: 12),
                Center(
                  child: CustomText(
                    title: 'Set your new password',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Appcolors.neutralgrey,
                  ),
                ),
                addVerticalspace(height: 30),
                Consumer<Newpasswordprovider>(
                  builder: (context, newpassprovider, child) => Authtextform(
                    hinttext: 'Enter Your New Password',
                    visibility: newpassprovider.visibility1,
                    suffixIcon: IconButton(
                      onPressed: newpassprovider.changevisibility1,
                      icon: newpassprovider.visibility1
                          ? const Icon(
                              Icons.visibility_off,
                              color: Appcolors.contentDisbaled,
                            )
                          : const Icon(Icons.visibility),
                      color: Appcolors.contentDisbaled,
                    ),
                  ),
                ),
                addVerticalspace(height: 20),
                Consumer<Newpasswordprovider>(
                  builder: (context, newpassprovider, child) => Authtextform(
                    hinttext: 'Confirm Password',
                    visibility: newpassprovider.visibility2,
                    suffixIcon: IconButton(
                      onPressed: newpassprovider.changevisibility2,
                      icon: newpassprovider.visibility2
                          ? const Icon(
                              Icons.visibility_off,
                              color: Appcolors.contentDisbaled,
                            )
                          : const Icon(Icons.visibility),
                      color: Appcolors.contentDisbaled,
                    ),
                  ),
                ),
                addVerticalspace(height: 10),
                CustomText(
                  title: 'Atleast 1 number or a special character',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffA6A6A6),
                ),
                addVerticalspace(height: 40),
                Custombutton(
                  text: 'Save',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
