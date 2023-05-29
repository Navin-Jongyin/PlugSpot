import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/provider%20screen/myCharger.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EditCharger extends StatefulWidget {
  const EditCharger({Key? key}) : super(key: key);

  @override
  State<EditCharger> createState() => _EditChargerState();
}

class _EditChargerState extends State<EditCharger> {
  TextEditingController editLocationNameController = TextEditingController();
  TextEditingController editLocationDetailController = TextEditingController();
  File? _selectedImage;
  int? userId;

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    Navigator.of(context).pop(); // Close the modal bottom sheet
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    Navigator.of(context).pop(); // Close the modal bottom sheet
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<int?> getUserId() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON response
      final data = json.decode(response.body);
      final id = data['message']['ID'];
      userId = id;
      print(userId);
      return userId;
    } else {
      // If the call was not successful, throw an error or return null
      return null;
    }
  }

  Future<void> updateStation() async {
    final apiUrl = 'https://plugspot.onrender.com/station/update';
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    var request = http.MultipartRequest('PATCH', Uri.parse(apiUrl));
    request.headers['Cookie'] = cookie ?? '';

    try {
      request.fields['userId'] = userId.toString();
      request.fields['stationName'] = editLocationNameController.text;
      request.fields['stationDetail'] = editLocationDetailController.text;

      if (_selectedImage != null) {
        final file = await http.MultipartFile.fromPath(
          'stationImage',
          _selectedImage!.path,
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
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Palette.backgroundColor),
              ),
              content: Text(
                'Charger details updated successfully.',
                style: GoogleFonts.montserrat(
                    fontSize: 14, color: Palette.backgroundColor),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.yellowTheme),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context)
                        .pop(); // Navigate back to previous screen
                  },
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

  void _showImageSourceModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Image Source'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: _takePicture,
              child: Text('Take a Picture'),
            ),
            CupertinoActionSheetAction(
              onPressed: _selectImageFromGallery,
              child: Text('Choose from Gallery'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close the modal bottom sheet
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MyCharger(),
              ),
            );
          },
          color: Palette.backgroundColor,
        ),
        title: Text(
          "Edit Charger Details",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(25, 30, 25, 15),
            child: TextFormField(
              controller: editLocationNameController,
              keyboardType: TextInputType.text,
              cursorColor: Palette.yellowTheme,
              decoration: InputDecoration(
                labelText: "Location Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Palette.backgroundColor,
                ),
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
              controller: editLocationDetailController,
              keyboardType: TextInputType.text,
              cursorColor: Palette.yellowTheme,
              decoration: InputDecoration(
                labelText: "Location Detail",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Palette.backgroundColor,
                ),
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
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            width: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Location Image",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 250,
                  width: 400,
                  color: Palette.greyColor,
                  child: InkWell(
                    onTap: () => _showImageSourceModal(context),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.add_photo_alternate,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        height: 100,
        child: FloatingActionButton(
          onPressed: () {
            updateStation();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Save",
            style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Palette.backgroundColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
