import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xff2C96F1);
Color secondaryColor = Color(0xFFF2A62C);
Color textColor = Color(0xff1E293B);
Color bgColor = Color(0xffF5FAFF);
Color warningColor = Color(0xffFFC700);
Color successColor = Color(0xff4CBE4C);
Color errorColor = Color(0xffE83121);

FontWeight medium = FontWeight.w500;
FontWeight bold = FontWeight.w700;
FontWeight light = FontWeight.w300;
FontWeight semibold = FontWeight.w600;
FontWeight normal = FontWeight.w400;

TextStyle regularTextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: textColor,
);
TextStyle titleTextStyle = GoogleFonts.poppins(
  fontSize: 32,
  // fontWeight: FontWeight.w700,
  color: textColor,
);
TextStyle subtitleTextStyle = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: textColor,
);

double defaultMargin = 32;
