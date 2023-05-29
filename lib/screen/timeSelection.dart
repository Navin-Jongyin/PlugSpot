import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';

import 'package:http/http.dart' as http;

import 'maps.dart';

class Car {
  final int id;
  final String plate;
  final String brand;
  final String model;
  final String status;

  Car({
    required this.id,
    required this.plate,
    required this.brand,
    required this.model,
    required this.status,
  });
}

class TimeSelection extends StatefulWidget {
  final int? stationId;
  final String? stationName;
  final String? stationDetail;
  final String? providerPhone;
  final String? stationImageUrl;
  final int? providerId;

  TimeSelection({
    this.stationId,
    this.providerPhone,
    this.stationDetail,
    this.stationName,
    this.stationImageUrl,
    this.providerId,
  });

  @override
  _TimeSelectionState createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  String baseUrl = 'https://plugspot.onrender.com';
  List<Map<String, dynamic>> timeSlots = [];
  TimeOfDay? selectedSlot;
  int? selectedTime;
  List<Car> carData = [];
  Car? selectedCar;
  String buttonText = "Select Car";
  int? customerId;
  int? selectedCarid;

  Future<int?> getUserId() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final userId = responseData['message']['ID'];
      customerId = userId;
      print(customerId);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> getAllStation() async {
    final apiUrl = 'https://plugspot.onrender.com/station/getallstation';
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData is List) {
        for (var item in responseData) {
          if (widget.stationId == item['ID']) {
            timeSlots = List<Map<String, dynamic>>.from(item['Timeslots']);
          }
        }
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
    setState(() {});
  }

  Future<String?> createContract() async {
    final apiUrl = 'https://plugspot.onrender.com/contract/createcontract';
    final cookie = await CookieStorage.getCookie();
    var data = {
      'customerId': customerId,
      'providerId': widget.providerId,
      'stationId': widget.stationId,
      'carId': selectedCarid,
      'timeSlot': selectedTime,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      // Contract creation successful
      final responseData = json.decode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Successful'),
            content: Text(responseData['message']),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MapSample(),
                    ),
                  );
                  // Add any additional actions after the dialog is closed
                },
              ),
            ],
          );
        },
      );
      timeSlotUpdate();
      updateCarStatus();
      return responseData[
          'message']; // Return a success message or relevant data
    } else {
      // Contract creation failed
      print('Request failed with status code: ${response.statusCode}');
      print(response.body);
      return null; // Return null or an error message
    }
  }

  Future<void> updateCarStatus() async {
    final apiUrl = "https://plugspot.onrender.com/car/update";
    final cookie = await CookieStorage.getCookie();
    var data = {
      'userId': customerId,
      'carId': selectedCarid,
      'carStatus': "in contract",
    };
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> timeSlotUpdate() async {
    final apiUrl = 'https://plugspot.onrender.com/station/timeslotupdate';
    final cookie = await CookieStorage.getCookie();
    var data = {
      'providerId': widget.providerId,
      'stationId': widget.stationId,
      'timeSlotNo': selectedTime,
      'status': "booked",
    };

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<List<Car>> getCarData() async {
    final apiUrl = "https://plugspot.onrender.com/car/getallusercars";
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<Car> cars = [];
      for (var carItem in responseData) {
        final id = carItem['carId'];
        final plate = carItem['carPlate'];
        final brand = carItem['carBrand'];
        final model = carItem['carModel'];
        final status = carItem['carStatus'];
        cars.add(Car(
          id: id,
          plate: plate,
          brand: brand,
          model: model,
          status: status,
        ));
      }
      return cars;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    getAllStation();
    getCarData().then((cars) {
      setState(() {
        carData = cars;
      });
    });
  }

  bool isSlotFree(int timeSlotNo) {
    for (var slot in timeSlots) {
      if (slot['TimeSlotNo'] == timeSlotNo && slot['Status'] == 'booked') {
        return false;
      }
    }
    return true;
  }

  Widget _buildTimeSlots() {
    final startTime = TimeOfDay(hour: 8, minute: 0);
    final endTime = TimeOfDay(hour: 20, minute: 0);
    final timeSlots = [];

    final now = DateTime.now();
    final startDate = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final endDate = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.hour,
      endTime.minute,
    );

    final interval = Duration(hours: 1);

    for (var dateTime = startDate;
        dateTime.isBefore(endDate);
        dateTime = dateTime.add(interval)) {
      final time = TimeOfDay.fromDateTime(dateTime);
      timeSlots.add(time);
    }

    return Column(
      children: timeSlots.map(
        (time) {
          final formattedStartTime =
              '${time.hour.toString().padLeft(2, '0')}:00';
          final formattedEndTime = '${time.hour + 1}:00';

          final slotNumber = timeSlots.indexOf(time) + 1;
          final isFree = isSlotFree(slotNumber);

          return GestureDetector(
            onTap: isFree
                ? () {
                    setState(() {
                      selectedSlot = time;
                      selectedTime = slotNumber;
                    });
                    final status = isFree ? 'free' : 'booked';
                    print(
                        'Selected Slot: $formattedStartTime - $formattedEndTime');
                    print('Status: $status');
                  }
                : null,
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedSlot == time
                    ? Palette.yellowTheme
                    : Palette.whiteBackgroundColor,
                border: Border.all(
                  color: isFree ? Palette.yellowTheme : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  '$formattedStartTime - $formattedEndTime',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: isFree ? Palette.backgroundColor : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  void _showCarSelectionModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: carData.length,
            itemBuilder: (BuildContext context, int index) {
              final car = carData[index];
              final statusColor =
                  car.status == 'free' ? Colors.green : Colors.red;

              return ListTile(
                title: Text(
                  '${car.brand} - ${car.model}',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Plate: ${car.plate}'),
                    Text(
                      'Status: ${car.status}',
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: car.status == 'free'
                    ? () {
                        setState(() {
                          selectedCar = car;
                          selectedCarid = car.id;
                          buttonText =
                              '${car.brand} - ${car.plate}'; // Update button text
                        });
                        Navigator.of(context).pop(); // Close the modal
                      }
                    : null,
              );
            },
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
        title: Text(
          "Booking",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Palette.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 200,
              color: Palette.greyColor,
              child: Center(
                child: Text(
                  baseUrl +
                      widget.stationImageUrl.toString().replaceFirst('.', ''),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stationName.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Palette.yellowTheme,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.stationDetail.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Palette.backgroundColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 25),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_iphone,
                          color: Palette.yellowTheme,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.providerPhone.toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Palette.backgroundColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        _showCarSelectionModal();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Palette.backgroundColor,
                      child: Text(
                        buttonText,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "Select Time",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: _buildTimeSlots(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        height: 80,
        color: Color(0xfff2f2f2),
        child: FloatingActionButton(
          onPressed: () {
            createContract();
            timeSlotUpdate();
            updateCarStatus();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "Continue",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.backgroundColor),
          ),
        ),
      ),
    );
  }
}
