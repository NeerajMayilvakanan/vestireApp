import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vestire_app/utils/colors.dart';
import 'package:vestire_app/utils/utils.dart';

class CustomerSignupScreen extends StatefulWidget {
  const CustomerSignupScreen({Key? key}) : super(key: key);

  @override
  _CustomerSignupScreenState createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;
  int screenState = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bottom = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: mobileBackgroundColor,
          body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight / 8),
                      child: Column(
                        children: [
                          Text(
                            'JOIN US',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 8,
                            ),
                          ),
                          Text(
                            'Buy Today in this Smart World!',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: screenWidth / 30,
                            ),
                          ),
                        ],
                      ),
                    )),
                Align(alignment: Alignment.centerLeft, child: circle(5)),
                Transform.translate(
                  offset: const Offset(30, -30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: circle(4.5),
                  ),
                ),
                Center(
                  child: circle(3),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                      height: bottom > 0 ? screenHeight : screenHeight / 2,
                      width: screenWidth,
                      color: skyBlueColor,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth / 12,
                          right: screenWidth / 12,
                          top: bottom > 0 ? screenHeight / 12 : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            screenState == 0 ? stateRegister() : stateOTP(),
                            GestureDetector(
                              onTap: () {
                                if (customerNameController.text.isEmpty) {
                                  showSnackBar(
                                      'Customer Name is Still Empty!', context);
                                } else if (phoneController.text.isEmpty) {
                                  showSnackBar(
                                      'Phone number is still empty!', context);
                                } else {
                                  setState(() {
                                    screenState = 1;
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: screenWidth,
                                margin:
                                    EdgeInsets.only(bottom: screenHeight / 12),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                    child: Text(
                                  'CONTINUE',
                                  style: TextStyle(color: blackColor),
                                  // style: GoogleFonts.montserrat(
                                  //   color: Colors.black87,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                )),
                              ),
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          setState(() {
            screenState = 0;
          });
          return Future.value(false);
        });
  }

  Widget stateRegister() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Customer Name",
        style: TextStyle(color: blackColor),
        // style: GoogleFonts.montserrat(
        //   color: Colors.black87,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextFormField(
        controller: customerNameController,
        style: const TextStyle(color: blackColor),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: blackColor, width: 0.0),
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
      ),
      const SizedBox(
        height: 16,
      ),
      const Text(
        "Phone Number",
        style: TextStyle(color: blackColor),
        // style: GoogleFonts.montserrat(
        //   color: Colors.black87,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      IntlPhoneField(
        controller: phoneController,
        style: const TextStyle(color: blackColor),
        showCountryFlag: false,
        showDropdownIcon: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            )),
      )
    ]);
  }

  Widget stateOTP() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
                text: "We just sent a code to ",
                style: TextStyle(color: blackColor, fontSize: 18)),
            TextSpan(
                text: phoneController.text,
                style: const TextStyle(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const TextSpan(
                text: "\nEnter the code here and we can continue!",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 12,
                ))
          ])),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 12),
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          onChanged: (value) {},
          pinTheme: PinTheme(
              activeColor: blueColor,
              selectedColor: primaryColor,
              inactiveColor: blackColor),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          children: [
            const TextSpan(
              text: "Didn't receive the code? ",
              style: TextStyle(
                color: blackColor,
                fontSize: 12,
              ),
            ),
            WidgetSpan(
                child: GestureDetector(
              onTap: (() {
                setState(() {
                  screenState = 0;
                });
              }),
              child: const Text(
                "Resend",
                style: TextStyle(
                  color: blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          ],
        ),
      ]))
    ]);
  }

  Widget circle(double size) {
    return Container(
      height: screenHeight / size,
      width: screenHeight / size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: skyBlueColor,
      ),
    );
  }
}
