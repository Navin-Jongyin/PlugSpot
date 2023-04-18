import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  String brandValue = 'Select Brand';
  String modelValue = 'Select Model';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "My Car",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        iconTheme: IconThemeData(color: Palette.backgroundColor),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Text(
                      "Add New Car",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    color: Palette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          color: Palette.greyColor,
                          blurRadius: 7,
                          spreadRadius: 3),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        "Car Brand",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
