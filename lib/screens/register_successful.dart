

import 'package:flutter/material.dart';
import 'package:technical_test/screens/auth/login.dart';

import '../widgets/colors.dart';
import '../widgets/my_text.dart';

class RegisterSuccessful extends StatefulWidget {
  const RegisterSuccessful({Key? key}) : super(key: key);

  @override
  State<RegisterSuccessful> createState() => _RegisterSuccessfulState();
}

class _RegisterSuccessfulState extends State<RegisterSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage('images/successful.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 46),
                    child: MyText(
                      'Registration Successful',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>  LoginPage()),
                              (route) => false);
                    },
                    child: MyText(
                      'Click to Login',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: mainBlue,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
