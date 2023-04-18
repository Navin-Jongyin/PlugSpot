import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor),
        ),
      ),
      body: Stack(
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: 30,
            left: 30,
            child: Container(
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First Name",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "First Name",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 14, color: Palette.greyColor)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Last Name",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Last Name",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 14, color: Palette.greyColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Email",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 14, color: Palette.greyColor)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mobile No.",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Palette.backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Mobile No.",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: 14, color: Palette.greyColor)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48,
                        width: 200,
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Palette.yellowTheme,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Palette.backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
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
