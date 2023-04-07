import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

Color blackColor = const Color(0xFF000000);
Color whiteColor = const Color.fromARGB(255, 255, 255, 255);
Color mainColor = const Color.fromARGB(255, 18, 21, 204);

TextStyle blackTextFont =
    GoogleFonts.poppins(color: blackColor, fontWeight: reguler);
TextStyle blueTextFont =
    GoogleFonts.poppins(color: mainColor, fontWeight: reguler);
TextStyle whiteTextFont =
    GoogleFonts.poppins(color: whiteColor, fontWeight: reguler);
