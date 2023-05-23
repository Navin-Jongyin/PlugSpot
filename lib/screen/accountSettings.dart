import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/user_profile.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    UserProfile(),
              ),
            );
          },
        ),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Account Settings",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
        iconTheme: IconThemeData(color: Palette.backgroundColor),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 50,
                  width: 400,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    borderRadius: BorderRadius.circular(15),
                    color: Palette.yellowTheme,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 7,
                        color: Palette.greyColor,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    "Nicky220245@gmail.com",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Palette.backgroundColor.withOpacity(0.3),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Change Password",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Password",
                  style: GoogleFonts.montserrat(color: Palette.backgroundColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Palette.backgroundColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Password",
                  style: GoogleFonts.montserrat(color: Palette.backgroundColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Palette.backgroundColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 15, 25, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm New Password",
                  style: GoogleFonts.montserrat(color: Palette.backgroundColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.greyColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Palette.backgroundColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 400,
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Palette.yellowTheme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    color: Palette.backgroundColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Save",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Palette.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 400,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: FloatingActionButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Palette.whiteBackgroundColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Delete Account",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Palette.whiteBackgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
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
