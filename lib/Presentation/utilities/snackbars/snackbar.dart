import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perixx_outbound/Presentation/size_config.dart';

void openSnackbar({
  required String title,
  required String message,
}) {
  Get.snackbar(
    title,
    message,
    icon: Padding(
      padding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.03),
      child: FaIcon(
        FontAwesomeIcons.triangleExclamation,
        size: SizeConfig.safeHorizontal * 0.065,
        color: const Color.fromARGB(255, 49, 118, 236),
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    forwardAnimationCurve: Curves.elasticInOut,
    reverseAnimationCurve: Curves.easeOut,
    margin: EdgeInsets.all(SizeConfig.safeHorizontal * 0.02),
    padding: EdgeInsets.all(SizeConfig.safeHorizontal * 0.04),
    titleText: Text(
      title,
      style: GoogleFonts.notoSans(
        fontSize: SizeConfig.safeHorizontal * 0.045,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 251, 106, 106),
      ),
    ),
    messageText: Text(
      message,
      style: GoogleFonts.notoSans(
        fontSize: SizeConfig.safeHorizontal * 0.04,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 97, 97, 97),
      ),
    ),
    duration: const Duration(seconds: 5),
  );
}
