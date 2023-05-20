import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/screen/LoginPage.dart';
import 'package:plugspot/screen/selectRole.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/palette.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _focusNode = FocusNode();
  bool _obscurePassword = true;
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
          title: Text(
            "Error!",
            style: GoogleFonts.montserrat(
                color: Palette.yellowTheme, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Password do not match",
            style: GoogleFonts.montserrat(color: Palette.backgroundColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Palette.yellowTheme,
                    fontWeight: FontWeight.bold),
              ),
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
    _focusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              height: 145,
              width: 500,
              color: Palette.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CREATE YOUR",
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
              margin: EdgeInsets.fromLTRB(25, 30, 25, 10),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                decoration: InputDecoration(
                  labelText: "Full Name",
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
                    Icons.person,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: emailController,
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
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: passwordController,
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
                    Icons.password,
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
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                    Icons.password,
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
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Palette.yellowTheme,
                decoration: InputDecoration(
                  labelText: "Phone Numer",
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
                    Icons.phone_iphone,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                height: 60,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: FloatingActionButton(
                  heroTag: 'signup',
                  onPressed: () {
                    createUser(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Palette.yellowTheme,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LoginPage(),
                  ),
                );
              },
              child: Text(
                "Sign In",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Palette.yellowTheme,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
