import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/screen/accountSettings.dart';
import 'package:plugspot/screen/edit_profile.dart';
import 'package:plugspot/screen/LoginPage.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BookingQueue(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Palette.backgroundColor,
            )),
        backgroundColor: Palette.yellowTheme,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
        iconTheme: const IconThemeData(
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
                    decoration: const BoxDecoration(
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
                    offset: const Offset(0, 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 130,
                          width: 130,
                          decoration: const BoxDecoration(
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
                          child: const ClipOval(
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
            margin: const EdgeInsets.fromLTRB(25, 30, 25, 15),
            padding: const EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.whiteBackgroundColor,
                border: Border.all(color: Palette.greyColor)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const EditProfile(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Palette.yellowTheme,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.yellowTheme,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 0, 25, 15),
            padding: const EdgeInsets.all(15),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.whiteBackgroundColor,
                border: Border.all(color: Palette.greyColor)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AccountSetting(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        color: Palette.yellowTheme,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Account Settings",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Palette.backgroundColor),
                      ),
                    ],
                  ),
                  const Icon(
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
