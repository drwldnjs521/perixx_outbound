import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

class CustomTheme {
  static BoxDecoration get customBox {
    return BoxDecoration(
      color: Colors.white,
      // border: Border.all(
      //     color: const Color.fromARGB(255, 182, 182, 183),
      //     width: 1.0,
      //     style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static BoxDecoration get customBox1 {
    return BoxDecoration(
      color: Colors.blueAccent,
      // border: Border.all(
      //     color: const Color.fromARGB(255, 182, 182, 183),
      //     width: 1.0,
      //     style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static ThemeData get theme {
    return ThemeData(
      textTheme: TextTheme(
        labelSmall: GoogleFonts.notoSans(
          fontSize: SizeConfig.safeHorizontal * 0.04,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: GoogleFonts.notoSans(
          fontSize: SizeConfig.safeHorizontal * 0.045,
          color: const Color.fromARGB(255, 61, 70, 75),
        ),
      ),
    );
  }
}
