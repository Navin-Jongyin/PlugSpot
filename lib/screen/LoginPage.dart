import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plugspot/screen/maps.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void getData() async {
    final url = Uri.parse("https://plugspot.onrender.com/userAccounts");

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData is List && responseData.isNotEmpty) {
          var firstItem = responseData[0];
          var email = firstItem['email'];
          var password = firstItem['password'];

          if (email != null &&
              email.toString() == _emailController.text &&
              password != null &&
              password.toString() == _passwordController.text) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MapSample(),
                transitionDuration: Duration(seconds: 5),
              ),
            );
          } else {
            showErrorMessage('Invalid email or password.');
          }
        } else {
          print('Invalid API response format.');
        }
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (error) {
      print("API request failed with error: $error");
    }
  }

  void showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50, bottom: 30),
                child: RichText(
                  text: TextSpan(
                    text: "Plug",
                    style: GoogleFonts.audiowide(
                        fontSize: 35, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Spot',
                        style: GoogleFonts.audiowide(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Palette.yellowTheme),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 350,
              width: 400,
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Palette.whiteBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  //Email TextBox
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Palette.yellowTheme,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.greyColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.greyColor)),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Palette.greyColor),
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: Palette.yellowTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _passwordController,
                          obscureText: false,
                          cursorColor: Palette.yellowTheme,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.greyColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.greyColor)),
                            labelText: 'Password',
                            helperStyle: GoogleFonts.montserrat(
                                fontSize: 12, color: Colors.red),
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Palette.greyColor),
                            prefixIcon: const Icon(
                              Icons.email_rounded,
                              color: Palette.yellowTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 400,
                    child: FloatingActionButton(
                      backgroundColor: Palette.yellowTheme,
                      onPressed: getData,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "SIGN IN",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.backgroundColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
