import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridemate/Providers/Completeprofileprovider/completeprofileprovider.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/authtextform.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/view/Authentication/components/customrichtext.dart';
import 'package:ridemate/view/Authentication/view/Completeprofile/components/profilepic.dart';
import 'package:ridemate/view/Dialogueboxes/cnicscanner_dialog.dart';
import 'package:ridemate/widgets/customtext.dart';
import 'package:ridemate/widgets/spacing.dart';
import '../../../../widgets/custombutton.dart';

class Completeprofile extends StatelessWidget {
  final String phoneNumber;
  const Completeprofile({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: customappbar(context, title: 'Profile'),
          backgroundColor: Appcolors.scaffoldbgcolor,
          body: Form(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Profilepic(),
                addVerticalspace(height: 20),
                Customrichtext(texts: const [
                  'We will scan your cnic for gender confirmation.For any questions please ',
                  'Contact Support',
                ]),
                addVerticalspace(height: 20),
                Consumer<Completeprofileprovider>(
                  builder: (context, cnicprovider, child) => Authtextform(
                    hinttext: 'User Name',
                    readonly: true,
                    controller: cnicprovider.usernameController,
                  ),
                ),
                addVerticalspace(height: 20),
                Consumer<Completeprofileprovider>(
                  builder: (context, cnicprovider, child) => Authtextform(
                    hinttext: 'Gender',
                    readonly: true,
                    controller: cnicprovider.genderController,
                  ),
                ),
                const Spacer(),
                Custombutton(
                  text: 'Scan',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  borderRadius: 8,
                  ontap: () => cnicscannerdialogue(context, phoneNumber),
                ),
              ],
            ),
          )),
        ),
        Consumer<Completeprofileprovider>(
          builder: (context, profieprovider, child) {
            return profieprovider.loading
                ? const Opacity(
                    opacity: 0.80,
                    child: ModalBarrier(
                        dismissible: false, color: Appcolors.contentPrimary),
                  )
                : const SizedBox();
          },
        ),
        Consumer<Completeprofileprovider>(
          builder: (context, profileprovider, child) {
            return profileprovider.loading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(Appcolors.primaryColor),
                        ),
                        addVerticalspace(height: 8),
                        const Material(
                          color: Colors.transparent,
                          child: CustomText(
                            title: 'Loading...',
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox();
          },
        )
      ],
    );
  }
}
