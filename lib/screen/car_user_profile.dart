import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class CarUserProfile extends StatefulWidget {
  const CarUserProfile({Key? key}) : super(key: key);

  @override
  State<CarUserProfile> createState() => _CarUserProfileState();
}

class _CarUserProfileState extends State<CarUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "User Profile",
          style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: 30,
            right: 30,
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                color: Palette.whiteBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 2),
                    blurRadius: 7.0,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/nicky.png"),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Palette.yellowTheme,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Name",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("Sample Firstname"),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Palette.yellowTheme,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Last Name",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("Sample Lastname"),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail,
                                color: Palette.yellowTheme,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Email",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("sample@email.com"),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Palette.yellowTheme,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Phone",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text("Sample Lastname"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 490,
            left: 60,
            right: 60,
            child: Container(
              child: FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Palette.backgroundColor,
                child: Text(
                  "Edit Profile",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
