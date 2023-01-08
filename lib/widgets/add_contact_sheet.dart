import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/widgets/show_snackbar.dart';
import 'package:technical_test/widgets/validator.dart';

import '../provider.dart';
import '../screens/profile_page.dart';
import 'colors.dart';
import 'my_button.dart';
import 'my_input_field.dart';
import 'my_text.dart';

class AddContactSheet extends StatefulWidget {
  const AddContactSheet({Key? key}) : super(key: key);

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _type = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  inputController: _email,
                  isPassword: false,
                  hintText: 'Email Address',
                  hasSuffixIcon: false,
                  keyBoardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  inputController: _name,
                  isPassword: true,
                  hintText: 'Full Name',
                  hasSuffixIcon: false,
                  keyBoardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: validateFullName,
                ),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  inputController: _phone,
                  isPassword: false,
                  hintText: 'Phone Number',
                  hasSuffixIcon: false,
                  keyBoardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.contacts),
                  validator: validatePhoneNumber,
                ),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                  inputController: _type,
                  isPassword: false,
                  hintText: 'Type',
                  hasSuffixIcon: false,
                  keyBoardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.work),
                  validator: validateFullName,
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  height: 50,
                  color: mainBlue,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _isLoading = true;

                      if (!mounted) {
                        setState(() {});
                      }

                      Duration waitTime = const Duration(seconds: 4);
                      Future.delayed(waitTime, () {
                        if (!mounted) {
                          _isLoading = false;
                          setState(() {});
                        }

                      });

                      var payload = {
                        "name": _name.text,
                        "email": _email.text,
                        "type": _type.text,
                        "phone": _phone.text,
                      };

                      try {
                        await data.addContact(payload).then((value) {
                          if (data.addContactResponse.statusCode == 200) {
                            _type.clear();
                            _email.clear();
                            _name.clear();
                            _phone.clear();
                            Navigator.pop(context);
                          } else {
                            showSnackBar(context, Colors.grey,
                                'status code: ${data.addContactResponse.statusCode}\n${data.errorMessage}');
                            Navigator.pop(context);
                          }
                        });
                      } catch (e, s) {
                        print(e);
                        print(s);
                      }
                    }
                  },
                  child:
                  _isLoading == false ?
                  MyText(
                          'Add Contact',
                          color: white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
