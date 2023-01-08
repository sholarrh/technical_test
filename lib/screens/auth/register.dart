
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/screens/register_successful.dart';


import '../../provider.dart';
import '../../widgets/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_input_field.dart';
import '../../widgets/my_text.dart';
import '../../widgets/show_snackbar.dart';
import '../../widgets/validator.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   TextEditingController _fullnameTextController = TextEditingController();
   TextEditingController _passwordTextController = TextEditingController();
   TextEditingController _emailTextController = TextEditingController();
   TextEditingController _confirmPasswordTextController = TextEditingController();

   bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back,
                          color: white,)),
                  ),

                  const SizedBox(height: 70,),

                  Align(
                    alignment: Alignment.topLeft,
                    child: MyText(
                      'Register',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: white,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  InputField(
                    inputController: _fullnameTextController,
                    isPassword: false,
                    hintText: 'Enter Full Name',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: validateFullName,
                  ),

                  const SizedBox(
                    height: 40,),

                  InputField(
                    inputController: _emailTextController,
                    isPassword: false,
                    hintText: 'Enter your Email',
                    hasSuffixIcon: false,
                    keyBoardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
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
                    height: 40,
                  ),

                  InputField(
                    inputController: _confirmPasswordTextController,
                    isPassword: true,
                    hintText: 'Confirm Password',
                    hasSuffixIcon: true,
                    keyBoardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    validator: (value) {
                      if (value != _passwordTextController.text) {
                        return 'Password and confirm password must be the same';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: MyButton(
                        height: 50,
                        color: mainred,
                        child: _isLoading == false ? MyText('Sign Up',
                          color: white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ):
                        const Center(
                          child: CircularProgressIndicator(
                            color: mainBlue,
                          ),
                        ),
                        onTap:  () async {
                          if (_formKey.currentState!.validate()){
                            _isLoading = true;
                            setState(() {
                            });

                            Duration waitTime = const Duration(seconds: 4);
                            Future.delayed(waitTime, (){
                              if (mounted) {
                                _isLoading = false;
                              }
                              setState(() {});
                            });

                            try {
                              var payload = {"name": _fullnameTextController.text,
                                "password": _passwordTextController.text,
                                "email": _emailTextController.text
                              };
                              await data.postRegister(payload)
                                  .then((value)
                              {
                                if (data.signUpResponse.statusCode == 200
                                    || data.signUpResponse.statusCode == 202
                                ){
                                  _fullnameTextController.clear();
                                  _emailTextController.clear();
                                  _confirmPasswordTextController.clear();
                                  _passwordTextController.clear();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const RegisterSuccessful()),
                                  );
                                }else {
                              showSnackBar(context, white,
                              'status code: ${data.signUpResponse.statusCode}\n${data.errorMessage}');
                              }
                                }
                              );
                            }catch (e, s) {
                              print(e);
                              print(s);
                            }
                          }
                        }),
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