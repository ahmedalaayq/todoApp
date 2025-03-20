import 'package:flutter/material.dart';

showCustomSnackBar({required BuildContext context,required String text , Color ?color})
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 4.0,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: 30,
              left: 16,
              right: 16), 
          padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: color ?? Colors.green,
            content: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )));
}