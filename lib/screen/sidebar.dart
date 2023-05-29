import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';

import 'package:plugspot/screen/LoginPage.dart';
import 'package:plugspot/screen/chargingHistory.dart';
import 'package:plugspot/screen/myBooking.dart';
import 'package:plugspot/screen/my_car.dart';
import 'package:plugspot/provider screen/bookingQueue.dart';

import 'package:plugspot/screen/user_profile.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Navin Jongyin',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteBackgroundColor),
            ),
            accountEmail: Text(
              '63011210@kmitl.ac.th',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteBackgroundColor),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'images/nicky.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backgroundheader.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(
                Icons.person,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'User Profile',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const ImageIcon(
                AssetImage("images/icon/appointment.png"),
                size: 35,
                color: Palette.yellowTheme,
              ),
              title: Text(
                'My Booking',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyBooking()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const ImageIcon(
                AssetImage('images/icon/car.png'),
                size: 35,
                color: Palette.yellowTheme,
              ),
              title: Text(
                'My Car',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyCar()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(
                Icons.history,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'Charging History',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChargingHistory(),
                  ),
                );
              },
            ),
          ),
          Container(
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                size: 35,
                color: Colors.red,
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
