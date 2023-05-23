import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/screen/LoginPage.dart';
import 'dart:convert';
import '../config/palette.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _textFieldFocusNode = FocusNode();
  bool _obscurePassword = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final phoneNumberFormatter = FilteringTextInputFormatter.digitsOnly;

  List<String> _items = [
    'Car User',
    'Charger Provider',
  ];

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void initState() {
    super.initState();
    roleController.text = '';
  }

  Future<void> createUser(
    String name,
    String email,
    String password,
    String confirmPassword,
    int phoneNumber,
    String role,
  ) async {
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Error!",
            style: GoogleFonts.montserrat(
              color: Palette.yellowTheme,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Password does not match",
            style: GoogleFonts.montserrat(
              color: Palette.backgroundColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Palette.yellowTheme,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    const String apiUrl = 'https://plugspot.onrender.com/userAccount/signup';
    final Map<String, dynamic> userData = {
      'fullname': name,
      'email': email,
      'password': password,
      'phonenumber': phoneNumber,
      'role': role.replaceAll(" ", "").toLowerCase(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('User created successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginPage(),
                  ),
                );
                // Navigate to another screen or perform any desired action
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print(response.statusCode);
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to create user.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 30, 25, 10),
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
                        : Palette.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: emailController,
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
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: passwordController,
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
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  prefixIcon: const Icon(
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
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                obscureText: _obscurePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                      RegExp(r"\s")), // Disallow spaces
                ],
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: _focusNode.hasFocus
                        ? Palette.backgroundColor
                        : Palette.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  prefixIcon: const Icon(
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
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                cursorColor: Palette.yellowTheme,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  phoneNumberFormatter,
                ],
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: _focusNode.hasFocus
                        ? Palette.backgroundColor
                        : Palette.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Palette.backgroundColor,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.phone_iphone,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                controller: roleController,
                onTap: () {
                  FocusScope.of(context).requestFocus(_textFieldFocusNode);
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _items[index],
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    roleController.text = _items[index];
                                    Navigator.pop(context);

                                    print(roleController.text);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                showCursor: false,
                decoration: InputDecoration(
                  labelText: 'Role',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: roleController.text.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  prefixIcon: const Icon(
                    Icons.phone_iphone,
                    color: Palette.yellowTheme,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                height: 60,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FloatingActionButton(
                  heroTag: 'signup',
                  onPressed: () {
                    int phoneNumber =
                        int.tryParse(phoneNumberController.text) ?? 0;
                    createUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        phoneNumber,
                        roleController.text);
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
                      color: Palette.backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Palette.backgroundColor,
              ),
            ),
            const SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
