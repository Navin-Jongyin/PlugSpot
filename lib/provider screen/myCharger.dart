import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/add_charger.dart';

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            width: 500,
            height: 70,
            child: FloatingActionButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCharger()));
              },
              backgroundColor: Palette.yellowTheme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add New Charger',
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),

                  ),
                ],
              ),
              ),
            ),
        ],
      ),
    );
  }
}
