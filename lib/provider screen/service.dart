import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/provider%20screen/bookingQueue.dart';

class Contract {
  final int contractId;
  final String customerName;
  final DateTime bookingDate;
  final String carPlate;
  final String status;

  Contract({
    required this.contractId,
    required this.customerName,
    required this.bookingDate,
    required this.carPlate,
    required this.status,
  });
}

class OnGoingService extends StatefulWidget {
  const OnGoingService({Key? key}) : super(key: key);

  @override
  State<OnGoingService> createState() => _OnGoingServiceState();
}

class _OnGoingServiceState extends State<OnGoingService> {
  List<Contract> contracts = [];

  @override
  void initState() {
    super.initState();
    getContract();
  }

  Future<void> getContract() async {
    final apiUrl = 'https://plugspot.onrender.com/contract/getusercontract';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      setState(() {
        contracts = responseData
            .map((item) => Contract(
                  contractId: item['contractId'],
                  customerName: item['customerName'],
                  bookingDate:
                      DateTime.tryParse(item['date']) ?? DateTime.now(),
                  carPlate: item['carPlate'],
                  status: item['status'].toLowerCase(),
                ))
            .where((contract) =>
                contract.status ==
                'on going') // Filter contracts with status 'on going'
            .toList();
      });
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
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BookingQueue(),
              ),
            );
          },
        ),
        title: Text(
          'On Going',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Palette.backgroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Add top padding
        child: ListView.builder(
          itemCount: contracts.length,
          itemBuilder: (context, index) {
            final contract = contracts[index];

            return Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${contract.customerName}',
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Car Plate: ${contract.carPlate}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Booking Date: ${contract.bookingDate.toString().substring(0, 10)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      '${contract.status.toUpperCase()}',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[500]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
