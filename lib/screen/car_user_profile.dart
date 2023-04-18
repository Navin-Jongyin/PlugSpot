import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/edit_profile.dart';
import 'package:plugspot/screen/login_signup.dart';

class CarUserProfile extends StatefulWidget {
  const CarUserProfile({Key? key}) : super(key: key);

  @override
  State<CarUserProfile> createState() => _CarUserProfileState();
}

class _CarUserProfileState extends State<CarUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -800,
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
                  ]),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(0, 120),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Palette.backgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 7.0,
                            spreadRadius: 1,
                          ),
                        ]),
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 30,
            child: GestureDetector(
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.backgroundColor,
                  size: 25,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 30,
            child: GestureDetector(
              child: InkWell(
                child: Icon(
                  Icons.logout,
                  color: Palette.backgroundColor,
                  size: 28,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LoginSignupScreen())));
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(0, 300),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Palette.yellowTheme,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "First Name :",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Test Name",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Palette.backgroundColor),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Palette.yellowTheme,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Last Name :",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Test Last Name",
                          style: GoogleFonts.montserrat(
                              fontSize: 16, color: Palette.backgroundColor),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.mail,
                              color: Palette.yellowTheme,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Email :",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Test@gmail.com",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Palette.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Palette.yellowTheme,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Mobile No. :",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Palette.backgroundColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "0812345678",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Palette.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
          Positioned(
            top: 700,
            left: 100,
            right: 100,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              },
              elevation: 10,
              backgroundColor: Palette.yellowTheme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Edit Profile",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
