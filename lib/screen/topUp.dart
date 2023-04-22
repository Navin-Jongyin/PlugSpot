import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class Topup extends StatefulWidget {
  const Topup({super.key});

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        title: Text(
          "Top up",
          style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              padding: EdgeInsets.all(15),
              height: 150,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Palette.backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Plug",
                            style: GoogleFonts.audiowide(
                              fontSize: 26,
                              color: Palette.yellowTheme,
                            ),
                          ),
                          TextSpan(
                            text: "Spot",
                            style: GoogleFonts.audiowide(
                              fontSize: 26,
                              color: Palette.whiteBackgroundColor,
                            ),
                          ),
                          TextSpan(
                            text: " Wallet",
                            style: GoogleFonts.audiowide(
                              fontSize: 26,
                              color: Palette.whiteBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Balance",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Palette.whiteBackgroundColor),
                        ),
                      ),
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage("images/icon/thaibaht.png"),
                            color: Palette.whiteBackgroundColor,
                            size: 20,
                          ),
                          Text(
                            "0.00",
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Palette.whiteBackgroundColor),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 15, left: 25),
              child: Text(
                "Choose Amount",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    color: Palette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          color: Palette.greyColor,
                          blurRadius: 3,
                          spreadRadius: 1),
                    ],
                  ),
                  child: InkWell(
                    child: Text(
                      "100",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Palette.backgroundColor),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    color: Palette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          color: Palette.greyColor,
                          blurRadius: 3,
                          spreadRadius: 1),
                    ],
                  ),
                  child: InkWell(
                    child: Text(
                      "500",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Palette.backgroundColor),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    color: Palette.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 3),
                          color: Palette.greyColor,
                          blurRadius: 3,
                          spreadRadius: 1),
                    ],
                  ),
                  child: InkWell(
                    child: Text(
                      "1000",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, color: Palette.backgroundColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                  width: 150,
                  child: Divider(
                    color: Palette.backgroundColor.withOpacity(0.7),
                  ),
                ),
                Text(
                  "or",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Palette.backgroundColor),
                ),
                SizedBox(
                  height: 10,
                  width: 150,
                  child: Divider(
                    color: Palette.backgroundColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Amount",
                style: GoogleFonts.montserrat(
                    color: Palette.backgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.greyColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("images/icon/thaibaht.png"),
                        size: 20,
                        color: Palette.yellowTheme,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Amount",
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Palette.greyColor,
                            ),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
        child: Container(
          height: 50,
          child: FloatingActionButton(
            heroTag: 'uniqueTag',
            onPressed: () {},
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
