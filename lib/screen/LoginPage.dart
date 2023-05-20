import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/screen/signupPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

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
            print(response.statusCode);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              height: 180,
              width: 500,
              color: Palette.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SIGN IN TO YOUR",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      color: Palette.whiteBackgroundColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "ACCOUNT",
                    style: GoogleFonts.montserrat(
                        fontSize: 28,
                        color: Palette.yellowTheme,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Palette.yellowTheme,
                decoration: InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: _focusNode.hasFocus
                          ? Palette.backgroundColor
                          : Palette.greyColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: _focusNode.hasFocus
                          ? Palette.backgroundColor
                          : Palette.greyColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Palette.yellowTheme,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Palette.greyColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            Center(
              child: Align(
                alignment: Alignment.topRight, // or Alignment.bottomRight
                child: InkWell(
                  onTap: () {
                    // Add your onTap logic here
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Palette.yellowTheme),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                height: 60,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    getData();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Palette.yellowTheme,
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.yellowTheme,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SignUpPage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
