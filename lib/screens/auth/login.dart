import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/screens/auth/register.dart';


import '../../provider.dart';
import '../../widgets/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_input_field.dart';
import '../../widgets/my_text.dart';
import '../../widgets/show_snackbar.dart';
import '../../widgets/validator.dart';
import '../profile_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: MyText(
                        'Log In',
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      InputField(
                        inputController: _emailTextController,
                        isPassword: false,
                        hintText: 'Email Address',
                        hasSuffixIcon: false,
                        keyBoardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: validateEmail,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InputField(
                        inputController: _passwordTextController,
                        isPassword: true,
                        hintText: 'Password',
                        hasSuffixIcon: true,
                        keyBoardType: TextInputType.text,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        validator: validatePassword,
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      MyButton(
                        height: 50,
                        color: mainred,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _isLoading = true;

                            setState(() {});
                            Duration waitTime = const Duration(seconds: 4);
                            Future.delayed(waitTime, () {
                              if (mounted) {
                                _isLoading = false;
                              }
                              setState(() {});
                            });

                            var payload = {
                              "password": _passwordTextController.text,
                              "email": _emailTextController.text
                            };
                            try {
                              await data.postLogin(payload).then((value) {
                                if (data.postLoginResponse.statusCode == 200) {

                                  _passwordTextController.clear();
                                  _emailTextController.clear();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfilePage()));
                                } else {
                                  showSnackBar(context, Colors.grey,
                                      'status code: ${data.postLoginResponse.statusCode}\n${data.errorMessage}');
                                }
                              });
                            } catch (e, s) {
                              print(e);
                              print(s);
                            }
                          }
                        },
                        child: _isLoading == false
                            ? MyText(
                                'Log In',
                                color: white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: mainBlue,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText('Don\'t have an Account ? ',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: white),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: MyText(
                            'Sign Up',
                            color: mainBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
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
