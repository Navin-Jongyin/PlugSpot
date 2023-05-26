import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider screen/bookingQueue.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:plugspot/screen/signupPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? _userRole;

  String cookieString = '';

  @override
  void initState() {
    super.initState();
    _loadCookie();
  }

  Future<void> _loadCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('cookie');
    setState(() {
      cookieString = cookie ?? '';
      print('$cookieString');
    });
  }

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
        _userRole = responseData['role'];

        String? cookie = response.headers['set-cookie'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('cookie', cookie ?? '');
        String? storedCookie = prefs.getString('cookie');
        print('Cookie: $storedCookie');

        bool apiSuccess = await _performAuthenticatedRequest(storedCookie);

        return apiSuccess;
      } else {
        print('Failed, with: ${response.statusCode}');
        print(response.body);
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> _performAuthenticatedRequest(String? cookie) async {
    const String apiEndpoint =
        'https://plugspot.onrender.com/userAccount/currentuser';

    try {
      final response = await http.get(
        Uri.parse(apiEndpoint),
        headers: {
          'Cookie':
              cookie ?? '', // Pass the stored cookie in the request headers
        },
      );

      if (response.statusCode == 200) {
        // Process the response data
        final responseData = jsonDecode(response.body);
        print(responseData);
        return true; // API request successful
      } else {
        print('API request failed, with: ${response.statusCode}');
        print(response.body);
        return false; // API request failed
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
                      if (_userRole == 'customer') {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MapSample(),
                          ),
                        );
                      } else if (_userRole == 'provider') {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    BookingQueue(),
                          ),
                        );
                      }
                    } else {
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
