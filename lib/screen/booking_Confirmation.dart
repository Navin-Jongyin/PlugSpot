import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/timeSelection.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({super.key});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
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
                    TimeSelection(),
              ),
            );
          },
        ),
        title: Text(
          "Comfirm Booking",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        backgroundColor: Palette.yellowTheme,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            height: 220,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.greyColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Booking Confirmation",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "SELECTED LOCATION",
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Palette.backgroundColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                      Text(
                        "8:00",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                      Text(
                        "9:00",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1.5,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Booking Fee",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                      Text(
                        "20 Baht",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Confirm Booking",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.backgroundColor),
          ),
        ),
      ),
    );
  }
}
