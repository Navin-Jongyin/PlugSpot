import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;

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
          onPressed: () {},
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
