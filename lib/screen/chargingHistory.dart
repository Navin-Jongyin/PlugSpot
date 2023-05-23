import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/textStyle.dart';
import 'package:plugspot/screen/maps.dart';

import '../config/palette.dart';

class ChargingHistory extends StatefulWidget {
  const ChargingHistory({super.key});

  @override
  State<ChargingHistory> createState() => _ChargingHistoryState();
}

class _ChargingHistoryState extends State<ChargingHistory> {
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
                    const MapSample(),
              ),
            );
          },
        ),
        title: Text(
          "Charging History",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Palette.yellowTheme,
      ),
    );
  }
}
