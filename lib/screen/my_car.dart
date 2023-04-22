import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/addCar.dart';

class MyCar extends StatefulWidget {
  const MyCar({super.key});

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "My Car",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
        child: Container(
          height: 50,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewCar()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Palette.yellowTheme,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage("images/icon/car.png"),
                  size: 25,
                  color: Palette.backgroundColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add New EV",
                  style: GoogleFonts.montserrat(
                      color: Palette.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
