import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/screen/login_signup.dart';

import '../config/palette.dart';
import '../screen/user_profile.dart';

class ProviderSidebar extends StatefulWidget {
  const ProviderSidebar({Key? key}) : super(key: key);

  @override
  State<ProviderSidebar> createState() => _ProviderSidebarState();
}

class _ProviderSidebarState extends State<ProviderSidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Yanapat Emdee',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteBackgroundColor),
            ),
            accountEmail: Text(
              'test.email.com',
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backgroundheader.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfile()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.ev_station,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'My Charger',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'Notification',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              // onTap: () => null,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.electrical_services,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'Services',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              // onTap: () => null,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
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
              // onTap: () => null,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
                size: 35,
              ),
              title: Text(
                'Log Out',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginSignupScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
