import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vestire_app/res/auth_methods.dart';
import 'package:vestire_app/utils/colors.dart';
import 'package:vestire_app/utils/utils.dart';
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
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _address = TextEditingController();

  String dropDownValue = "Salesman";
  var items = ["Salesman", "Biller", "Dispatch", "StockAdder"];
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _name.dispose();
    _userType.dispose();
    _phoneNumber.dispose();
    _salary.dispose();
    _address.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        name: _name.text,
        email: _emailController.text,
        phoneNumber: _phoneNumber.text,
        workingType: dropDownValue,
        password: _passwordController.text,
        salary: _salary.text,
        address: _address.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
    }
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
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
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
                            textInputType: TextInputType.phone),
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
                        //Salary
                        TextFieldInput(
                            textEditingController: _salary,
                            hintText: "Enter the employee salary ",
                            textInputType: TextInputType.number),
                        SizedBox(
                          height: 30,
                        ),
                        //Address
                        TextFieldInput(
                            textEditingController: _address,
                            hintText: "Enter the employee address ",
                            textInputType: TextInputType.streetAddress),
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
                          onTap: SignUpUser,
                          child: Container(
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  )
                                : const Text('Create Account'),
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
