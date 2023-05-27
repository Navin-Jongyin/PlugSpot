import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/LoginPage.dart';
import 'package:plugspot/screen/user_profile.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String data = '';
  int statusCode = 0;
  String responseBody = '';
  String userEmail = '';
  int? userID;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final url = 'https://plugspot.onrender.com/userAccount/currentuser';
    try {
      final cookie = await CookieStorage.getCookie(); // Retrieve the cookie
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie ?? ''},
      );

      setState(() {
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          data = response.body;
          statusCode = response.statusCode;
          responseBody = response.body;
          final jsonData = jsonDecode(responseBody);
          final email = jsonData['message']['Email'];
          final id = jsonData['message']['ID'];
          userEmail = email ?? '';
          userID = id;
          print(userID);
        } else {
          // Request failed, store the error code
          statusCode = response.statusCode;
        }
      });
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
    }
  }

  Future<void> resetPassword() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/resetpassword';
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    final data = {
      'userId': userID,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Password Not Match',
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'New password is not match',
              style: GoogleFonts.montserrat(fontSize: 14),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.yellowTheme)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Palette.backgroundColor),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {'Cookie': cookie ?? ''},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        print('Password reset successful: $message');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Password changed!',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Palette.yellowTheme)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            UserProfile(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Palette.backgroundColor),
                  ),
                ),
              ],
            );
          },
        );
        // Perform any additional actions or show success message to the user
      } else if (response.statusCode == 400) {
        // Password mismatch error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Current password is not correct',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Palette.yellowTheme)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Palette.backgroundColor),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        final errorMessage = response.body;
        print('Failed to reset password. Error: $errorMessage');
        print(userID);
        print(response.statusCode);

        // Show error message to the user or perform error handling
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future<void> deleteAccount() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/deleteaccount';
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');
    final data = {
      'userId': userID,
    };

    try {
      final response = await http.delete(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookie ?? '',
            // Add any additional headers as needed
          },
          body: json.encode(data));

      if (response.statusCode == 200) {
        // Deletion successful
        print('Item deleted successfully');
        await prefs.clear();
        // Perform any additional actions or show a success message
      } else {
        print('Failed to delete item. Error: ${response.statusCode}');
        print(response.body);
        // Handle the error case, display an error message, etc.
      }
    } catch (e) {
      print('Error: $e');
      // Handle any exceptions that occur during the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => UserProfile(),
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
        iconTheme: const IconThemeData(color: Palette.backgroundColor),
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
                    "$userEmail",
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
                    controller: _oldPasswordController,
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
                    controller: _newPasswordController,
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
                    controller: _confirmPasswordController,
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
              onPressed: resetPassword,
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
              onPressed: () {
                deleteAccount();
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      LoginPage(),
                ));
              },
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
