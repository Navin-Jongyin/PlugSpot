import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/maps.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 120),
              height: 380,
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
              ),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Plug",
                      style: GoogleFonts.audiowide(
                        fontSize: 40,
                        color: Palette.yellowTheme,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Spot",
                          style: GoogleFonts.audiowide(
                              fontSize: 40,
                              color: Palette.whiteBackgroundColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 30,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.yellowTheme,
                )),
          ),
          Positioned(
            top: 200,
            left: 25,
            right: 25,
            child: Container(
              height: 330,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Palette.whiteBackgroundColor,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Your Role",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Palette.yellowTheme,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 3),
                              color: Palette.greyColor,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Car User",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.backgroundColor,
                                  ),
                                ),
                                Text(
                                  "Find EV charger via PlugSpot",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Palette.backgroundColor),
                                )
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        )),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Palette.yellowTheme,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 3),
                              color: Palette.greyColor,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: InkWell(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Charger Provider",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            ),
                            Text(
                              "Become charger provider \nwith PlugSpot",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, color: Palette.backgroundColor),
                            )
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )),
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
