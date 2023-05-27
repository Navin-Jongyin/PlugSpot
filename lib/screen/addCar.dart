import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/carBrands.dart';
import 'package:plugspot/data/carModels.dart';
import 'package:plugspot/screen/my_car.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/cookie_storage.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String _selectedBrand = "Select Brand";
  String _selectedModel = "Select Model";
  int _selectedBrandIndex = 0;
  final TextEditingController _carPlateController = TextEditingController();
  String data = '';
  int statusCode = 0;
  String responseBody = '';

  int? userID;

  @override
  void dispose() {
    _carPlateController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final url = 'https://plugspot.onrender.com/userAccount/currentuser';
    try {
      final cookie = await CookieStorage.getCookie(); // Retrieve the cookie
      final response = await http.get(
        Uri.parse(url),
        headers: {'Cookie': cookie ?? ''},
      );

      setState(() {
        if (response.statusCode == 200) {
          // Request successful, parse the response body
          data = response.body;
          statusCode = response.statusCode;
          responseBody = response.body;
          final jsonData = jsonDecode(responseBody);
          final id = jsonData['message']['ID'];

          userID = id;
          print(userID);
        } else {
          // Request failed, store the error code
          statusCode = response.statusCode;
        }
      });
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
    }
  }

  Future<void> addCar() async {
    final apiUrl = 'https://plugspot.onrender.com/car/addnewcar';
    final prefs = await SharedPreferences.getInstance();
    final cookie = prefs.getString('cookie');

    final data = {
      'userId': userID,
      'carPlate': _carPlateController.text,
      'carBrand': _selectedBrand,
      'carModel': _selectedModel,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie ?? '',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        // Car saved successfully
        // Perform any additional actions or show a success message
        print('Car saved successfully');
        print(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Success',
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Car Added Succesfully!',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Palette.yellowTheme)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MyCar(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Palette.backgroundColor),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Failed to save car
        // Handle the error case, display an error message, etc.
        print('Failed to save car. Error: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      // Error occurred during the request
      print('Error saving car: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCar()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Palette.backgroundColor,
            )),
        backgroundColor: Palette.yellowTheme,
        iconTheme: IconThemeData(
          color: Palette.backgroundColor,
        ),
        title: Text(
          "My Car",
          style: GoogleFonts.montserrat(
            color: Palette.backgroundColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: Text(
                "Add Your Car",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 310,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.greyColor, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Car Brand",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: CarBrands.getBrands().length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(CarBrands.getBrands()[index]),
                                  onTap: () {
                                    setState(() {
                                      _selectedBrand =
                                          CarBrands.getBrands()[index];
                                      _selectedBrandIndex = index;
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedBrand,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Palette.backgroundColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Palette.yellowTheme,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Car Model",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            child: ListView.builder(
                              itemCount: CarBrands.getBrands().length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                      CarModels.getModels()[_selectedBrandIndex]
                                          [index]),
                                  onTap: () {
                                    setState(() {
                                      _selectedModel = CarModels.getModels()[
                                          _selectedBrandIndex][index];
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Palette.greyColor),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedModel,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Palette.backgroundColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Palette.yellowTheme,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Car Plate",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Palette.backgroundColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.only(
                      bottom: 15,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.greyColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _carPlateController,
                      cursorColor: Palette.yellowTheme,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "ex. 1กก1234",
                          hintStyle:
                              GoogleFonts.montserrat(color: Palette.greyColor)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        height: 50,
        width: 400,
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MyCar(),
            //   ),
            // );
            fetchData();
            addCar();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Save",
            style: GoogleFonts.montserrat(
                color: Palette.backgroundColor,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
