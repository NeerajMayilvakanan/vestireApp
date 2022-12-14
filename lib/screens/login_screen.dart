import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vestire_app/res/auth_methods.dart';

import 'package:vestire_app/utils/colors.dart';
import 'package:vestire_app/utils/utils.dart';
import 'package:vestire_app/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),

          Image.asset(
            'asset/images/vestire.png',
            color: primaryColor,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
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
            onTap: loginUser,
            child: Container(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text('Log in'),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: blueColor),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       child: const Text("Don't have an account?"),
          //       padding: const EdgeInsets.symmetric(vertical: 8),
          //     ),
          //     GestureDetector(
          //       onTap: () {},
          //       child: Container(
          //         // onTap: () {},
          //         child: const Text(
          //           "Sign up.",
          //           style: TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //       ),
          //     )
          //   ],
          // )
        ]),
      )),
    );
  }
}
