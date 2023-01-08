

import 'package:flutter/material.dart';

import 'colors.dart';
import 'my_text.dart';


void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: MyText(
        message,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
        textColor: white,
      ),
    ),
  );
}