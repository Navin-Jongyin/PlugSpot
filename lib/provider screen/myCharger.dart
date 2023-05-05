import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class MyCharger extends StatefulWidget {
  const MyCharger({super.key});

  @override
  State<MyCharger> createState() => _MyChargerState();
}

class _MyChargerState extends State<MyCharger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Charger",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        backgroundColor: Palette.yellowTheme,
      ),
    );
  }
}
