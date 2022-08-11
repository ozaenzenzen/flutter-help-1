import 'package:flutter/material.dart';

import '../shared/theme.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  MainButton({
    Key? key,
    required this.onPressed,
    this.text = 'Next',
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      margin: EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: regularTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: bgColor,
          ),
        ),
      ),
    );
  }
}
