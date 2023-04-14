import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/car_user_profile.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/screen/qrScanner.dart';
import 'package:plugspot/screen/wallet.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List widgetOptions = [MapSample(), Wallet(), QRScanner(), CarUserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        backgroundColor: Palette.backgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(top: 0), child: Icon(Icons.map)),
            label: "Maps",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Palette.yellowTheme,
        unselectedItemColor: Palette.whiteBackgroundColor,
        selectedLabelStyle: GoogleFonts.montserrat(fontSize: 14),
        unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 14),
      ),
    );
  }
}
