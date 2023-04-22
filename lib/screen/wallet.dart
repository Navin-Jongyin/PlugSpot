import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/topUp.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
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
                            fontSize: 20, color: Palette.whiteBackgroundColor),
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
          SizedBox(
            height: 50,
            width: 200,
            child: FloatingActionButton(
              backgroundColor: Palette.yellowTheme,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Topup()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 18,
                    color: Palette.backgroundColor,
                  ),
                  Text(
                    "Top Up",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(
            color: Palette.greyColor,
            thickness: 0.5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Transactions",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Palette.backgroundColor),
            ),
          )
        ],
      ),
    );
  }
}
