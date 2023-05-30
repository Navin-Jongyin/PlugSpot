import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/cookie_storage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? userId;
  Uint8List? userIdUint;
  int? userIdInt;
  String? imageUrl;
  String baseUrl = 'https://plugspot.onrender.com';
  String? endpointUrl;

  Future<void> _getImageFromDevice(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Change Profile Picture'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _getImageFromDevice(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Text('Take a Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _getImageFromDevice(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Text('Choose from Gallery'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            isDefaultAction: true,
          ),
        );
      },
    );
  }

  Future<String?> fetchUserId() async {
    final apiUrl =
        'https://plugspot.onrender.com/userAccount/currentuser'; // Replace with your API URL
    final cookie = await CookieStorage.getCookie(); // Retrieve the cookie

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Cookie': cookie ?? ''}, // Include the cookie in the headers
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final id = jsonData['message']['ID'].toString();
        final imageUrl = jsonData['message']['ProfileImage'];
        setState(() {
          this.imageUrl = endpointUrl;
        });
        endpointUrl = baseUrl + imageUrl.toString().replaceFirst('.', '');

        print('$id');
        print('$imageUrl');
        print(response.body);
        userId = id;
        userIdUint = Uint8List.fromList(utf8.encode(userId!));
        return userId;
      } else {
        // Handle the error case if the request fails
        print('Failed to fetch user ID. Error: ${response.statusCode}');
      }
    } catch (error) {
      // Error occurred during the request
      print('Error fetching data: $error');
    }

    return null; // Return null if the user ID retrieval fails
  }

  Future<void> updateUserProfile() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/update';

    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
    request.headers['Cookie'] = cookie ?? '';

    try {
      // Add form fields
      request.fields['userId'] = userId!;
      if (_nameController.text.isNotEmpty)
        request.fields['fullname'] = _nameController.text;
      if (_phoneController.text.isNotEmpty)
        request.fields['phoneNumber'] = _phoneController.text;

      // Add image file
      if (_image != null) {
        final file = await http.MultipartFile.fromPath(
          'profileImage',
          _image!.path,
          contentType: MediaType(
              'image', 'jpeg'), // Replace with the appropriate content type
        );
        request.files.add(file);
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        print(responseData);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Profile Updated'),
              content: Text('Your profile has been updated successfully.'),
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
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to update profile. Error: ${response.statusCode}');
        print(responseData);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    // Clean up the text controllers when the widget is disposed
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchUserId(); // Call fetchUserId to populate the userIdUint
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
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
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  Positioned(
                    top: -900,
                    left: -500,
                    right: -500,
                    child: Container(
                      height: 1000,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Palette.yellowTheme,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 7.0,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(0, 20),
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Palette.backgroundColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 7.0,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "images/avatarimage.png",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: FloatingActionButton(
                onPressed: _showImageOptions,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Palette.yellowTheme,
                child: Text(
                  "Edit Picture",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Palette.backgroundColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                decoration: InputDecoration(
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 20, color: Palette.backgroundColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.text,
                cursorColor: Palette.yellowTheme,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 20, color: Palette.backgroundColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Palette.backgroundColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        height: 50,
        child: FloatingActionButton(
          onPressed: updateUserProfile,
          backgroundColor: Palette.yellowTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                color: Palette.backgroundColor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Save",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Palette.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
