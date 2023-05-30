import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/provider%20screen/myCharger.dart';
import 'package:plugspot/provider%20screen/onGoing.dart';
import 'package:plugspot/provider%20screen/service.dart';
import 'package:plugspot/screen/LoginPage.dart';
import '../config/palette.dart';
import '../screen/user_profile.dart';

class ProviderSidebar extends StatefulWidget {
  const ProviderSidebar({Key? key}) : super(key: key);

  @override
  State<ProviderSidebar> createState() => _ProviderSidebarState();
}

class _ProviderSidebarState extends State<ProviderSidebar> {
  String? fullName;
  String? userEmail;
  String? imageUrl;
  String baseUrl = "https://plugspot.onrender.com";
  String? endPointUrl;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    const apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    setState(() {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final name = responseData['message']['Fullname'];
        final mail = responseData['message']['Email'];
        final image = responseData['message']['ProfileImage'];
        fullName = name;
        userEmail = mail;
        imageUrl = image;
        endPointUrl = baseUrl + imageUrl.toString().replaceFirst('.', '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              fullName.toString(),
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteBackgroundColor),
            ),
            accountEmail: Text(
              userEmail.toString(),
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteBackgroundColor),
            ),
            currentAccountPicture: ClipOval(
                child: Image.network(
              endPointUrl.toString(),
              fit: BoxFit.cover,
            )),
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
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UserProfile(),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.ev_station,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'My Charger',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCharger(),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.electrical_services,
                color: Palette.yellowTheme,
                size: 35,
              ),
              title: Text(
                'On Going Service',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        OnGoing(),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
                size: 35,
              ),
              title: Text(
                'Log Out',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Palette.backgroundColor,
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
