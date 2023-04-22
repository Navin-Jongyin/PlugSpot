import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/login_signup.dart';

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
            icon: Icon(Icons.logout),
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
      body: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('images/nicky.png'),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Navin Jongyin",
                      style: GoogleFonts.montserrat(
                          color: Palette.backgroundColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "nicky220245@gmail.com",
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
