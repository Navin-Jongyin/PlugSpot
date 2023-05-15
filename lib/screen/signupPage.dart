import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/LoginPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> createUser(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    const String apiUrl = 'https://plugspot.onrender.com/userAccounts';
    final Map<String, dynamic> userData = {
      'fullname': name,
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('User created successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to another screen or perform any desired action
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print(response.statusCode);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create user.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
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
              height: 550,
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
                      "Sign Up",
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  //Email TextBox
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 15),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        labelText: 'Name',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Palette.yellowTheme,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextField(
                      controller: emailController,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        labelText: 'Email',
                        helperStyle: GoogleFonts.montserrat(
                            fontSize: 12, color: Colors.red),
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor),
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Palette.yellowTheme,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        labelText: 'Create Password',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Palette.yellowTheme,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        labelText: 'Confirm Password',
                        helperStyle: GoogleFonts.montserrat(
                            fontSize: 12, color: Colors.red),
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Palette.yellowTheme,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: phoneNumberController,
                      obscureText: false,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Palette.greyColor)),
                        labelText: 'Phone Number',
                        helperStyle: GoogleFonts.montserrat(
                            fontSize: 12, color: Colors.red),
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Palette.yellowTheme,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 60,
                    width: 400,
                    child: FloatingActionButton(
                      backgroundColor: Palette.yellowTheme,
                      onPressed: () {
                        createUser(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          confirmPasswordController.text,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "SIGN UP",
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.backgroundColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Palette.whiteBackgroundColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Palette.yellowTheme,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
