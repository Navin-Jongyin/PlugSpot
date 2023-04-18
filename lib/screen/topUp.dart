import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class Topup extends StatefulWidget {
  const Topup({Key? key}) : super(key: key);

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Top Up",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
      ),
    );
  }
}
