import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/data/cookie_storage.dart';

class Contract {
  final int contractId;
  final String stationName;
  final String customerName;
  final String providerName;
  final String date;
  final int timeSlot;
  final String status;
  final int totalPrice;
  final String paymentMethod;

  Contract({
    required this.contractId,
    required this.stationName,
    required this.customerName,
    required this.providerName,
    required this.date,
    required this.timeSlot,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractId: json['contractId'],
      stationName: json['stationName'],
      customerName: json['customerName'],
      providerName: json['providerName'],
      date: json['date'],
      timeSlot: json['timeSlot'],
      status: json['status'],
      totalPrice: json['totalPrice'],
      paymentMethod: json['paymentMethod'],
    );
  }

  String get formattedDate {
    final dateTime = DateTime.parse(date);
    final formattedDate = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    return formattedDate;
  }
}

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  Future<List<Contract>> getContract() async {
    final apiUrl = 'https://plugspot.onrender.com/contract/getusercontract';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ''},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(response.body);
      final contracts =
          List<Contract>.from(responseData.map((x) => Contract.fromJson(x)));
      return contracts;
    } else {
      throw Exception('Failed to fetch contracts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellowTheme,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Palette.backgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Booking',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.backgroundColor,
          ),
        ),
      ),
      body: FutureBuilder<List<Contract>>(
        future: getContract(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final contracts = snapshot.data!;
            return ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final contract = contracts[index];
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
                  child: ListTile(
                    title: Text('Station: ${contract.stationName}'),
                    subtitle: Text('Date: ${contract.formattedDate}'),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        // Perform action on button press
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No contracts found'),
            );
          }
        },
      ),
    );
  }
}
