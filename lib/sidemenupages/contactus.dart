import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';
import 'package:ridemate/widgets/custombutton.dart';
import 'package:ridemate/widgets/customtext.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _messageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context,
          title: 'Contact Us', backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    title: 'Contact us for Ride share',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    textAlign: TextAlign.center,
                    color: Appcolors.contentPrimary,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    title: 'Address',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    textAlign: TextAlign.center,
                    color: Appcolors.contentPrimary,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    title: '123 Easy Rider Street,\nCityville, Country 12345',
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    color: Appcolors.neutralgrey,
                  ),
                  const SizedBox(height: 20),
                  const CustomText(
                    title:
                        'Call: +1 (800) 123-4567\nEmail: support@easyrider.com',
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    color: Appcolors.neutralgrey,
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                    title: 'Send Message',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    textAlign: TextAlign.center,
                    color: Appcolors.contentPrimary,
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    cursorColor:
                        Appcolors.primaryColor, // Change cursor color here
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                      ),
                      labelText: 'Enter your name',
                      labelStyle: TextStyle(
                          color: Appcolors
                              .primaryColor), // Use custom color from Appcolors
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    cursorColor:
                        Appcolors.primaryColor, // Change cursor color here
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                      ),
                      labelText: 'Enter your email',
                      labelStyle: TextStyle(color: Appcolors.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    cursorColor: Appcolors.primaryColor,
                    maxLines: 5, // Set maxLines to null for unlimited lines
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                      ),
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(
                          color: Appcolors
                              .primaryColor), // Change hint text color here
                      labelStyle: TextStyle(
                          color: Appcolors
                              .primaryColor), // Change label text color here
                    ),
                  ),
                  const SizedBox(height: 20),
                  IntlPhoneField(
                    cursorColor: Appcolors.primaryColor,
                    controller: _phoneNumberController,
                    dropdownTextStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      //color: Appcolors.primaryColor
                    ),
                    decoration: const InputDecoration(
                      //labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        color: Appcolors.primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.primaryColor),
                      ),
                    ),
                    initialCountryCode: 'PK',
                    onChanged: (phone) {
                      //print(phone.completeNumber);
                    },
                  ),
                  const SizedBox(height: 20),
                  Custombutton(
                    text: 'Submit',
                    fontSize: 16,
                    height: 50,
                    width: double.infinity,
                    fontWeight: FontWeight.w500,
                    borderRadius: 8,
                    ontap: () {
                      // Handle submission here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
