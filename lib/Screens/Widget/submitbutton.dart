import 'package:flutter/material.dart';
import 'package:makkanmate/Const/colors.dart';

import '../../Const/fonts.dart';
import '../../Const/size.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? shadowColor;
  final BorderSide? borderSide;
  final Function onTap;
  const SubmitButton(
      {Key? key,
      required this.isLoading,
      required this.onTap,
      required this.title,
      this.color,
      this.borderSide,
      this.textColor,
      this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              onTap();
              FocusScope.of(context).unfocus();
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? MyColors.primaryCustom,
        disabledBackgroundColor: Colors.transparent,
        shadowColor: shadowColor,
        side: borderSide ?? BorderSide.none,
        minimumSize: Size(width(context), 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // <-- Radius
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              title,
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textColor ?? Colors.white),
            ),
    );
  }
}
