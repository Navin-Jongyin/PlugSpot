import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class Topup extends StatefulWidget {
  const Topup({Key? key}) : super(key: key);

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Top Up",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
              padding: EdgeInsets.all(15),
              height: 150,
              width: 363,
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Balance",
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          color: Palette.whiteBackgroundColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          ImageIcon(
                            AssetImage("images/icon/thaibaht.png"),
                            color: Palette.whiteBackgroundColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "0.00",
                            style: GoogleFonts.montserrat(
                                fontSize: 24,
                                color: Palette.whiteBackgroundColor),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 20, 20),
                  child: Text(
                    'Choose Amount',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 100,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Palette.whiteBackgroundColor,
                        elevation: 0,
                        child: Text(
                          '100',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Palette.backgroundColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 100,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Palette.whiteBackgroundColor,
                        elevation: 0,
                        child: Text(
                          '500',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Palette.backgroundColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 100,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Palette.whiteBackgroundColor,
                        elevation: 0,
                        child: Text(
                          '1000',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Palette.backgroundColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      height: 1.0,
                      color: Palette.backgroundColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR',
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1.0,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 30),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Palette.greyColor),
                  color: Palette.whiteBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 3),
                        blurRadius: 4,
                        spreadRadius: 2,
                        color: Palette.greyColor)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    cursorColor: Palette.yellowTheme,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      hintStyle: GoogleFonts.montserrat(fontSize: 18),
                      border: InputBorder.none,
                      hintTextDirection: TextDirection.rtl,
                    ),
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.montserrat(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        child: FloatingActionButton(
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Top Up",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Palette.backgroundColor),
          ),
        ),
      ),
    );
  }
}
