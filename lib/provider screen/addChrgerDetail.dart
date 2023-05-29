import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:plugspot/provider%20screen/add_charger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/cookie_storage.dart';
import 'package:plugspot/config/palette.dart';

import 'myCharger.dart';

class ChargerDetail extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const ChargerDetail({
    this.latitude,
    this.longitude,
  });

  @override
  State<ChargerDetail> createState() => _ChargerDetailState();
}

class _ChargerDetailState extends State<ChargerDetail> {
  TextEditingController locationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int? userId;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    locationNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<int?> getUserId() async {
    final apiUrl = "https://plugspot.onrender.com/userAccount/currentuser";
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

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> addCharger() async {
    final apiUrl =
        Uri.parse("https://plugspot.onrender.com/station/addnewstation");
    final request = http.MultipartRequest('POST', apiUrl);
    final cookie = await CookieStorage.getCookie();
    if (cookie != null) {
      request.headers['Cookie'] = cookie;
    }

    request.fields['userId'] = userId.toString();
    request.fields['stationName'] = locationNameController.text;
    request.fields['stationDetail'] = addressController.text;
    if (widget.latitude != null && widget.longitude != null) {
      request.fields['longitude'] = widget.longitude.toString();
      request.fields['latitude'] = widget.latitude.toString();
    }
    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'stationImage',
        _selectedImage!.path,
        contentType: MediaType('image', 'jpg'),
      ));
    }
    final response = await request.send();

    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Success",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Palette.backgroundColor),
            ),
            content: Text(
              "Charger added successfully",
              style: GoogleFonts.montserrat(
                  fontSize: 14, color: Palette.backgroundColor),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Palette.yellowTheme)),
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Palette.backgroundColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyCharger()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Error ${response.statusCode}');
      print(responseData);
      print(widget.latitude);
      print(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddCharger(),
              ),
            );
          },
        ),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "Charger Details",
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
            margin: EdgeInsets.fromLTRB(25, 35, 10, 25),
            child: TextFormField(
              controller: locationNameController,
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
            margin: EdgeInsets.fromLTRB(25, 10, 10, 25),
            child: TextFormField(
              controller: addressController,
              keyboardType: TextInputType.text,
              cursorColor: Palette.yellowTheme,
              decoration: InputDecoration(
                labelText: "Address Details",
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
                  "Add Location Image",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 250,
                  width: 400,
                  color: Palette.greyColor,
                  child: InkWell(
                    onTap: _selectImage,
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
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        height: 100,
        width: 500,
        child: FloatingActionButton(
          onPressed: () {
            addCharger();
            print(widget.latitude);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Add Charger",
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
