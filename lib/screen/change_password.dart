import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.backgroundColor),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Change Password",
          style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 40, 10),
            child: Text(
              "Current Password",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Current Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 40, 10),
            child: Text(
              "New Password",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 40, 10),
            child: Text(
              "Confirm New Password",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 170,
                child: FloatingActionButton(
                  backgroundColor: Palette.yellowTheme,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Save',
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
    );
  }
}
