import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vestire_app/res/auth_methods.dart';
import 'package:vestire_app/utils/colors.dart';
import 'package:vestire_app/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _userType = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  String dropDownValue = "Salesman";
  var items = ["Salesman", "Biller", "Dispatch", "StockAdder"];
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _name.dispose();
    _userType.dispose();
    _phoneNumber.dispose();
  }
  void selectImage(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //png shop name
                        Image.asset(
                          'asset/images/vestire.png',
                          color: primaryColor,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        //Circular Widget to accept and show our selected file
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1666003913960-a7fcbd9fd920?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80'),
                            ),
                            Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //Text Field Name
                        TextFieldInput(
                            textEditingController: _name,
                            hintText: "Enter your name",
                            textInputType: TextInputType.text),
                        SizedBox(
                          height: 30,
                        ),
                        // Text Field Email
                        TextFieldInput(
                            textEditingController: _emailController,
                            hintText: "Enter your email",
                            textInputType: TextInputType.emailAddress),
                        SizedBox(
                          height: 30,
                        ),
                        // Phone Number
                        TextFieldInput(
                            textEditingController: _phoneNumber,
                            hintText: "Enter your Phone Number",
                            textInputType: TextInputType.number),
                        SizedBox(
                          height: 30,
                        ),
                        // Work of emolyee
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: const Text('Choose Type : '),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            DropdownButton(
                                value: dropDownValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDownValue = newValue!;
                                  });
                                })
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Password
                        TextFieldInput(
                            textEditingController: _passwordController,
                            isPass: true,
                            hintText: "Enter your password",
                            textInputType: TextInputType.text),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            String res = await AuthMethods().signUpUser(
                                name: _name.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumber.text,
                                workingType: dropDownValue,
                                password: _passwordController.text);
                          },
                          child: Container(
                            child: const Text('Create Account'),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                color: blueColor),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ))),
    );
  }
}
