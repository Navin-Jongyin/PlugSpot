import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/maps.dart';

class CheckIn extends StatefulWidget {
  final String code;
  final String qrData;

  const CheckIn({Key? key, required this.qrData, required this.code})
      : super(key: key);

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Check In Page",
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MapSample()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
        ),
        backgroundColor: Palette.yellowTheme,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                alignment: Alignment.center,
                height: 100,
                width: 400,
                color: Palette.greyColor,
                child: Text(
                  "Charger ID: ${widget.qrData.substring(9)}",
                  style: GoogleFonts.montserrat(fontSize: 25),
                )),
          ),
        ],
      ),
    );
  }
}
