import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/data/cookie_storage.dart';
import 'package:intl/intl.dart';

import 'maps.dart';

class Contract {
  final int contractId;
  final String stationName;
  final DateTime date;
  final String carPlate;
  final String status;
  final int customerId;
  final int providerId;
  final int timeSlot;
  final int stationId;
  final int carId;

  Contract({
    required this.contractId,
    required this.stationName,
    required this.date,
    required this.carPlate,
    required this.status,
    required this.customerId,
    required this.providerId,
    required this.timeSlot,
    required this.stationId,
    required this.carId,
  });
}

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  List<Contract> contracts = [];

  @override
  void initState() {
    super.initState();
    getContract();
  }

  Future<void> getContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/getusercontract";
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        contracts = List<Contract>.from(
          responseData.map((item) => Contract(
                contractId: item['contractId'],
                stationName: item['stationName'],
                date: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .parse(item['date']),
                carPlate: item['carPlate'] ?? 'N/A',
                status: item['status'],
                customerId: item['customerId'],
                providerId: item['providerId'],
                timeSlot: item['timeSlot'],
                stationId: item['stationId'],
                carId: item['carId'],
              )),
        );
      });
    }
  }

  Future<void> updateCarStatus(int customerId, int carId) async {
    final apiUrl = "https://plugspot.onrender.com/car/update";
    final cookie = await CookieStorage.getCookie();
    var data = {'userId': customerId, 'carId': carId, 'carStatus': "free"};

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Car status updated');
    } else {
      print('Failed to update car status');
      print(response.body);
      print(carId);
    }
  }

  Future<void> deleteContract(int contractId, int customerId, int carId) async {
    final apiUrl = "https://plugspot.onrender.com/contract/deletecontract";
    final cookie = await CookieStorage.getCookie();

    final data = {
      'contractId': contractId,
      'customerId': customerId,
    };

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      setState(() {
        contracts.removeWhere((contract) => contract.contractId == contractId);
      });
      print(response.body);

      // Call updateCarStatus after successful deletion
      updateCarStatus(customerId, carId);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> showConfirmationDialog(int contractId, int customerId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Cancellation',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              'Are you sure you want to cancel this booking?',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Palette.yellowTheme),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Palette.backgroundColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                if (contracts.isNotEmpty) {
                  final contract = contracts.firstWhere(
                      (contract) => contract.contractId == contractId);
                  await deleteContract(contractId, customerId, contract.carId);
                  updateTimeSlot(contract);
                } else {
                  // Handle the case when contracts list is empty
                  // Display an error message or handle it accordingly
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateTimeSlot(Contract contract) async {
    final apiUrl = "https://plugspot.onrender.com/station/timeslotupdate";
    final cookie = await CookieStorage.getCookie();
    var data = {
      'providerId': contract.providerId,
      'stationId': contract.stationId,
      'timeSlotNo': contract.timeSlot,
      'status': "free",
    };
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        title: Text(
          "My Booking",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
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
      ),
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];
          final formattedDate = DateFormat.yMd().add_jm().format(contract.date);

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Station: ${contract.stationName}',
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Date: $formattedDate',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Car Plate: ${contract.carPlate}',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        if (contract.status == 'in queue')
                          Text(
                            'Status: ${contract.status}',
                            style: GoogleFonts.montserrat(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else if (contract.status == 'on going')
                          Text(
                            'Status: ${contract.status}',
                            style: GoogleFonts.montserrat(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (contract.status == 'on going')
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        showConfirmationDialog(
                            contract.contractId, contract.customerId);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
