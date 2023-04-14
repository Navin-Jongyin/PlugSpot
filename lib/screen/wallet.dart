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
        automaticallyImplyLeading: true,
        backgroundColor: Palette.greyColor,
        title: Text(
          "My Wallet",
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 25,
            right: 27,
            left: 27,
            child: Container(
                height: 200,
                width: 340,
                decoration: BoxDecoration(
                    color: Palette.backgroundColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      child: RichText(
                        text: TextSpan(
                            text: "Plug",
                            style: GoogleFonts.audiowide(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Palette.yellowTheme,
                            ),
                            children: [
                              TextSpan(
                                  text: "Spot",
                                  style: GoogleFonts.audiowide(
                                      fontSize: 25,
                                      color: Palette.whiteBackgroundColor)),
                              TextSpan(
                                  text: " Wallet",
                                  style: GoogleFonts.audiowide(
                                      fontSize: 25,
                                      color: Palette.whiteBackgroundColor))
                            ]),
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 250,
            left: 120,
            right: 120,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Topup()));
              },
              backgroundColor: Palette.yellowTheme,
              foregroundColor: Palette.backgroundColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Top Up",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor),
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
