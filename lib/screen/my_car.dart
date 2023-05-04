import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/addCar.dart';
import 'package:plugspot/screen/maps.dart';

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Palette.backgroundColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapSample(),
                ),
              );
            },
          ),
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
          margin: EdgeInsets.all(25),
          height: 50,
          width: 400,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCar(),
                ),
              );
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
                  color: Palette.backgroundColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Add New Car",
                  style: GoogleFonts.montserrat(
                      color: Palette.backgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ));
  }
}
