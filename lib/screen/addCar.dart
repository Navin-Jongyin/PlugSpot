import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({super.key});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  String _selectedButton = 'Select Car Brand';
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
      body: Container(
        margin: EdgeInsets.all(30),
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.whiteBackgroundColor,
          border: Border.all(
            color: Palette.greyColor,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 3),
              blurRadius: 7,
              spreadRadius: 2,
              color: Palette.greyColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Car Brand",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(50),
                            height: 300.0,
                            color: Colors.white,
                            child: ListWheelScrollView(
                              itemExtent: 50,
                              children: [
                                Container(
                                  color: Palette.yellowTheme,
                                  child: Text("Test"),
                                ),
                                Container(
                                  color: Palette.yellowTheme,
                                  child: Text("Test"),
                                ),
                                Container(
                                  color: Palette.yellowTheme,
                                  child: Text("Test"),
                                ),
                                Container(
                                  color: Palette.yellowTheme,
                                  child: Text("Test"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 400,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Palette.greyColor),
                          color: Palette.whiteBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 3),
                              color: Palette.greyColor,
                              blurRadius: 4,
                              spreadRadius: 1.5,
                            ),
                          ]),
                      child: Text(
                        _selectedButton,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Palette.backgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
