import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/accountSettings.dart';
import 'package:plugspot/screen/edit_profile.dart';
import 'package:plugspot/screen/login_signup.dart';
import 'package:plugspot/screen/payment.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Palette.yellowTheme,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginSignupScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: -900,
                  left: -500,
                  right: -500,
                  child: Container(
                    height: 1000,
                    width: 1000,
                    decoration: BoxDecoration(
                      color: Palette.yellowTheme,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0, 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 7.0,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image(
                              image: AssetImage("images/nicky.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "Navin Jongyin",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Palette.backgroundColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
            padding: EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.whiteBackgroundColor,
                border: Border.all(color: Palette.greyColor)),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Palette.yellowTheme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.yellowTheme,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
            padding: EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.whiteBackgroundColor,
                border: Border.all(color: Palette.greyColor)),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountSetting()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Palette.yellowTheme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Account Settings",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.yellowTheme,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
            padding: EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.whiteBackgroundColor,
                border: Border.all(color: Palette.greyColor)),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Payment()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Palette.yellowTheme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Payment",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.yellowTheme,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
