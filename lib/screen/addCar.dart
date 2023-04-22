import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({super.key});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
        title: Text(
          "Add New Car",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Palette.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
