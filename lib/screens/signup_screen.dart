import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  String dropDownValue = "Salesman";
  var items = ["Salesman", "Biller", "Dispatch", "StockAdder", "Customer"];
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _name.dispose();
    _userType.dispose();
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
                        //svg
                        SvgPicture.asset(
                          'asset/ic_instagram.svg',
                          color: primaryColor,
                          height: 64,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        TextFieldInput(
                            textEditingController: _name,
                            hintText: "Enter your name",
                            textInputType: TextInputType.text),
                        SizedBox(
                          height: 30,
                        ),
                        TextFieldInput(
                            textEditingController: _emailController,
                            hintText: "Enter your email",
                            textInputType: TextInputType.emailAddress),
                        SizedBox(
                          height: 30,
                        ),
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
                        TextFieldInput(
                            textEditingController: _passwordController,
                            isPass: true,
                            hintText: "Enter your password",
                            textInputType: TextInputType.text),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {},
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
                          height: 15,
                        ),
                      ]),
                ),
              ))),
    );
  }
}
