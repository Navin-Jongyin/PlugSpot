import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
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
          Positioned(
            top: 60,
            right: 30,
            left: 30,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Palette.greyColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text("My Car"),
                  ),
                  ImageIcon(
                    AssetImage("images/icon/car.png"),
                    size: 30,
                    color: Palette.yellowTheme,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        hintStyle: GoogleFonts.audiowide(fontSize: 18)),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
