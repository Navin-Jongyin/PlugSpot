import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/user_profile.dart';

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
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First Name",
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Name",
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        height: 50,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Palette.yellowTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.save,
              color: Palette.backgroundColor,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Save",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Palette.backgroundColor,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}
