import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/car_user_profile.dart';
import 'package:plugspot/screen/login_signup.dart';
import 'package:plugspot/screen/wallet.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isSwitchedOn = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
                    MaterialPageRoute(builder: (context) => CarUserProfile()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.wallet_outlined,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'Wallet',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Wallet()));
              },
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
              onTap: () => null,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: ImageIcon(
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
              onTap: () => null,
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(
              bottom: 140,
            ),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: 35,
                color: Palette.yellowTheme,
              ),
              title: Text(
                "Account Setting",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Switch Mode",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 10,
                ),
                CupertinoSwitch(
                    trackColor: Palette.yellowTheme,
                    activeColor: Palette.yellowTheme,
                    value: _isSwitchedOn,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchedOn = value;
                      });
                      if (value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Wallet()));
                      }
                    }),
              ],
            ),
          ),
          Divider(),
          Container(
            child: ListTile(
              leading: Icon(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginSignupScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}