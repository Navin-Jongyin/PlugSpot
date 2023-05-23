import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/config/textStyle.dart';
import 'package:plugspot/provider%20screen/add_charger.dart';

class ChargerDetail extends StatefulWidget {
  const ChargerDetail({super.key});

  @override
  State<ChargerDetail> createState() => _ChargerDetailState();
}

class _ChargerDetailState extends State<ChargerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddCharger(),
              ),
            );
          },
        ),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Charger Details",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: TextFormField(
              keyboardType: TextInputType.text,
              cursorColor: Palette.yellowTheme,
              decoration: InputDecoration(
                labelText: "Location Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                    fontSize: 20, color: Palette.backgroundColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.backgroundColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Palette.backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
