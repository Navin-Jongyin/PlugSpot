import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/screen/maps.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  bool isCarUserPressed = false;
  bool isChargerProviderPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Palette.yellowTheme, size: 25),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RichText(
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
                            fontSize: 40, color: Palette.whiteBackgroundColor))
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.all(25),
            height: 380,
            width: 400,
            decoration: BoxDecoration(
              color: Palette.whiteBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 25),
                  child: Text(
                    "Select Your Role",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isCarUserPressed = true;
                      isChargerProviderPressed = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    width: 400,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15),
                        color: isCarUserPressed
                            ? Palette.yellowTheme
                            : Palette.whiteBackgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Car User",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        ImageIcon(
                          AssetImage('images/icon/car.png'),
                          color: isCarUserPressed
                              ? Palette.backgroundColor
                              : Palette.yellowTheme,
                          size: 35,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isCarUserPressed = false;
                      isChargerProviderPressed = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    width: 400,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15),
                        color: isChargerProviderPressed
                            ? Palette.yellowTheme
                            : Palette.whiteBackgroundColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Charger Provider",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        ImageIcon(
                          AssetImage('images/icon/charger.png'),
                          color: isChargerProviderPressed
                              ? Palette.backgroundColor
                              : Palette.yellowTheme,
                          size: 35,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 60,
                  width: 400,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (isCarUserPressed) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapSample(),
                          ),
                        );
                      } else if (isChargerProviderPressed) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingQueue(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Error",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "Please Select a Role",
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.yellowTheme),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.backgroundColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: Palette.yellowTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
