import 'package:flutter/material.dart';
import 'package:plugspot/config/palette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/screen/homepage.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/screen/wallet.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 97),
              height: 380,
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
              ),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Plug",
                        style: GoogleFonts.audiowide(
                          fontSize: 40,
                          color: Palette.yellowTheme,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Spot",
                              style: GoogleFonts.audiowide(
                                  fontSize: 40,
                                  color: Palette.whiteBackgroundColor))
                        ]),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            top: 200,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: EdgeInsets.all(20),
              height: isSignupScreen ? 500 : 330,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Palette.whiteBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGN IN",
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: !isSignupScreen
                                      ? Palette.backgroundColor
                                      : Palette.greyColor,
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Palette.yellowTheme,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                            isSignupScreen = true;
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGN UP",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isSignupScreen
                                        ? Palette.backgroundColor
                                        : Palette.greyColor),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Palette.yellowTheme,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            top: isSignupScreen ? 620 : 450,
            right: 0,
            left: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapSample()));
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Palette.yellowTheme,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: isSignupScreen ? 'Sign Up' : "Sign In",
                          style: GoogleFonts.montserrat(
                            color: Palette.backgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail, "Email", false, true),
          buildTextField(Icons.lock, "Password", true, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.backgroundColor,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text(
                    "Remember Me",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forget Password?",
                  style:
                      GoogleFonts.montserrat(color: Colors.red, fontSize: 12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(
            Icons.person,
            "Full Name",
            false,
            false,
          ),
          buildTextField(
            Icons.mail,
            "Email",
            false,
            true,
          ),
          buildTextField(
            Icons.lock,
            "Password",
            true,
            false,
          ),
          buildTextField(
            Icons.lock,
            "Confirm Password",
            true,
            false,
          ),
          buildTextField(
            Icons.phone,
            "Phone Number",
            false,
            false,
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Palette.greyColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greyColor),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greyColor),
                borderRadius: BorderRadius.circular(15)),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
              color: Palette.greyColor,
              fontSize: 14,
            )),
      ),
    );
  }
}
