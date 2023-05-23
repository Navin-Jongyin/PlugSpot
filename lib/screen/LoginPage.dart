import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/screen/signupPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.montserrat(
                color: Palette.yellowTheme,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<bool> _logIn(String email, String password) async {
    const String apiUrl = 'https://plugspot.onrender.com/userAccount/login';
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        print(response.statusCode);
        return true; // Login successful
      } else {
        print('Failed, with: ${response.statusCode}');
        print(response.body);
        return false; // Login failed
      }
    } catch (e) {
      print('Error: $e');
      return false; // Error occurred
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 30, 25, 15),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Palette.yellowTheme,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                      RegExp(r"\s")), // Disallow spaces
                ],
                decoration: InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: _focusNode.hasFocus
                        ? Palette.backgroundColor
                        : Palette.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.backgroundColor),
                  ),
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                obscureText: _obscurePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                      RegExp(r"\s")), // Disallow spaces
                ],
                decoration: InputDecoration(
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: _focusNode.hasFocus
                        ? Palette.backgroundColor
                        : Palette.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.backgroundColor),
                  ),
                  prefixIcon: const Icon(
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
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    // Add your onTap logic here
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Palette.yellowTheme,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 25, right: 25),
                height: 60,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FloatingActionButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    bool logInSuccessful = await _logIn(email, password);

                    if (logInSuccessful) {
                      // Navigate to another page upon successful login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapSample()),
                      );
                    } else {
                      // Show an error message upon failed login
                      _showErrorMessage('Invalid Email or Password');
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Palette.yellowTheme,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.backgroundColor,
                    ),
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
              const SizedBox(width: 10),
              InkWell(
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Palette.yellowTheme,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SignUpPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
