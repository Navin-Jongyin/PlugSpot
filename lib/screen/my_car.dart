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
                height: 350,
                width: 400,
                decoration: BoxDecoration(
                    color: Palette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Palette.greyColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 20, 10, 10),
                      child: Text(
                        "Car Brand",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Palette.whiteBackgroundColor,
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FloatingActionButton(
                          onPressed: () {},
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Palette.whiteBackgroundColor,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select Brand",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Palette.backgroundColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Palette.backgroundColor,
                                  size: 16,
                                )
                              ]),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 20, 10, 10),
                      child: Text(
                        "Car Model",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Palette.whiteBackgroundColor,
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: FloatingActionButton(
                          onPressed: () {},
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Palette.whiteBackgroundColor,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select Model",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Palette.backgroundColor),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Palette.backgroundColor,
                                  size: 16,
                                )
                              ]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: 250,
                          child: FloatingActionButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Palette.backgroundColor,
                            child: Text(
                              "Add Car",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Palette.yellowTheme,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    margin: EdgeInsets.only(top: 20),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Palette.yellowTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Palette.backgroundColor,
                              size: 25,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Add New Car",
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
