import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/addCar.dart';
import 'package:plugspot/screen/maps.dart';
import 'package:http/http.dart' as http;
import '../data/cookie_storage.dart';

class Car {
  final int carId;
  final String carPlate;
  final String carBrand;
  final String carModel;
  final String carStatus;

  Car({
    required this.carId,
    required this.carPlate,
    required this.carBrand,
    required this.carModel,
    required this.carStatus,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carId: json['carId'],
      carPlate: json['carPlate'],
      carBrand: json['carBrand'],
      carModel: json['carModel'],
      carStatus: json['carStatus'],
    );
  }
}

class MyCar extends StatefulWidget {
  const MyCar({Key? key}) : super(key: key);

  @override
  State<MyCar> createState() => _MyCarState();
}

class _MyCarState extends State<MyCar> {
  List<Car> carData = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<int?> fetchUserId() async {
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
        final id = jsonData['message']['ID'];
        userId = id; // Convert the id to int
        print('$id');
        print(response.body);
        await fetchCarData();

        return userId;
      } else {
        // Handle the error case if the request fails
        print('Failed to fetch user ID. Error: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      // Error occurred during the request
      print('Error fetching data: $error');
    }

    return null; // Return null if the user ID retrieval fails
  }

  Future<void> fetchCarData() async {
    final apiUrl = 'https://plugspot.onrender.com/car/getallusercars';
    final cookie = await CookieStorage.getCookie();
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Cookie': cookie ?? ''}, // Include the cookie in the headers
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final cars = jsonData.map((carJson) => Car.fromJson(carJson)).toList();

        setState(() {
          carData = cars;
        });
      } else {
        // Handle the case when the request fails
        print('Failed to fetch car data. Error: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      // Handle any exceptions that occur during the request
      print('Error: $error');
    }
  }

  Future<void> deleteCar(int carId) async {
    final apiUrl = 'https://plugspot.onrender.com/car/deleteusercar';
    final cookie = await CookieStorage.getCookie();
    final data = {
      'userId': userId,
      'carId': carId,
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Car",
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to delete this car?",
            style: GoogleFonts.montserrat(
              fontSize: 14,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Palette.yellowTheme)),
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Palette.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                'Delete',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Palette.whiteBackgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                try {
                  final response = await http.delete(
                    Uri.parse(apiUrl),
                    headers: {'Cookie': cookie ?? ''},
                    body: json.encode(data),
                  );
                  if (response.statusCode == 200) {
                    // Car deleted successfully
                    print('Car deleted successfully');

                    // Refresh car data
                    setState(() {
                      carData.removeWhere((car) => car.carId == carId);
                    });
                  } else {
                    // Handle the case when the request fails
                    print(
                        'Failed to delete car. Error: ${response.statusCode}');
                    print(response.body);
                    print('delete fail');
                  }
                } catch (error) {
                  // Handle any exceptions that occur during the request
                  print('Error: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteBackgroundColor,
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
                    MapSample(),
              ),
            );
          },
        ),
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "My Car",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Palette.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: carData.length,
        itemBuilder: (context, index) {
          final car = carData[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Palette.whiteBackgroundColor,
              border: Border.all(color: Palette.greyColor),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Palette.greyColor.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'images/${car.carBrand.toLowerCase()}_logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.carBrand}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${car.carModel}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Car Plate: ${car.carPlate}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Car Status: ${car.carStatus}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => deleteCar(car.carId),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(25),
        height: 50,
        width: 400,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCar(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage("images/icon/car.png"),
                color: Palette.backgroundColor,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Add New Car",
                style: GoogleFonts.montserrat(
                  color: Palette.backgroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
