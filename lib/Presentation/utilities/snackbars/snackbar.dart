import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void openSnackbar({
  required String title,
  required String message,
}) {
  Get.snackbar(
    title,
    message,
    icon: const Padding(
      padding: EdgeInsets.all(20),
      child: FaIcon(
        FontAwesomeIcons.triangleExclamation,
        size: 50,
        color: Color.fromARGB(255, 49, 118, 236),
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    forwardAnimationCurve: Curves.elasticInOut,
    reverseAnimationCurve: Curves.easeOut,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(50),
    titleText: Text(
      title,
      style: GoogleFonts.notoSans(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 251, 106, 106),
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.notoSans(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 97, 97, 97),
      ),
    ),
    duration: const Duration(seconds: 4),
  );
}
