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
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        title: Text(
          "Wallet",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        backgroundColor: Palette.yellowTheme,
      ),
      body: Stack(
        children: [
          Column(
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
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 180,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Topup(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Palette.yellowTheme,
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 25,
                        color: Palette.backgroundColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Top Up",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.backgroundColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
                    child: Text(
                      "Transactions",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Palette.backgroundColor,
                      ),
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
