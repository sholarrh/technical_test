import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class InputField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final bool hasSuffixIcon;
  final TextEditingController inputController;
  final bool isPassword;
  final Function? validator;
  final Function? onSaved;
  final Function? onChanged;
  final TextInputType keyBoardType;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatters;

  const InputField(
      {Key? key,
      required this.inputController,
      required this.isPassword,
      this.prefixIcon,
      required this.hintText,
      required this.hasSuffixIcon,
      this.validator,
      this.onSaved,
      this.onChanged,
      required this.keyBoardType,
      this.inputFormatters,
      this.textInputAction})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 50,
      child: TextFormField(
        //65autovalidateMode: AutovalidateMode.always,
        validator: (value) => widget.validator!(value),
        controller: widget.inputController,
        onChanged: (value) {},
        keyboardType: widget.keyBoardType,
        autocorrect: true,
        textCapitalization: TextCapitalization.words,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onSaved: (value) => widget.onSaved!(value),
        style: const TextStyle(
            fontSize: 16,
            color: Color(0xff212121),
            fontWeight: FontWeight.w400),
        showCursor: true,
        decoration: InputDecoration(
          fillColor: white,
          // errorMaxLines: 1,
          // errorText: '',
          //  errorStyle: const TextStyle(
          //    fontSize: 6,
          //  ),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
          filled: true,
          focusColor: Colors.red,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.75),
              fontSize: 10,
              fontWeight: FontWeight.bold),
          suffixIcon: widget.hasSuffixIcon == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: _obscureText
                      ? const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 20,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          size: 20,
                        ),
                )
              : null,
          suffixIconColor: mainBlue,

          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.7),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainBlue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //gapPadding: 0,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //gapPadding: 0,
          ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}
