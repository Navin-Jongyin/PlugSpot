import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/screen/maps.dart';

class Contract {
  final int contractId;
  final String stationName;
  final DateTime date;
  final String paymentMethod;
  final double totalPrice;
  final String status;

  Contract({
    required this.contractId,
    required this.stationName,
    required this.date,
    required this.paymentMethod,
    required this.totalPrice,
    required this.status,
  });
}

class ChargingHistory extends StatefulWidget {
  const ChargingHistory({Key? key}) : super(key: key);

  @override
  State<ChargingHistory> createState() => _ChargingHistoryState();
}

class _ChargingHistoryState extends State<ChargingHistory> {
  List<Contract> contracts = [];

  @override
  void initState() {
    super.initState();
    getContract();
  }

  Future<void> getContract() async {
    final url = "https://plugspot.onrender.com/contract/getusercontract";
    final cookie = await CookieStorage.getCookie();

    final response = await http.get(
      Uri.parse(url),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        contracts = List<Contract>.from(
          responseBody.map((item) => Contract(
                contractId: item['contractId'],
                stationName: item['stationName'],
                date: DateTime.tryParse(item['date']) ?? DateTime.now(),
                paymentMethod: item['paymentMethod'],
                totalPrice: item['totalPrice'].toDouble(),
                status: item['status'],
              )),
        ).where((contract) => contract.status == 'complete').toList();
      });
    } else {
      print(response.statusCode);
      print(response.body);
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
                    MapSample(),
              ),
            );
          },
        ),
        title: Text(
          "Charging History",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: Palette.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.yellowTheme,
      ),
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];

          final formattedDate =
              DateFormat('MMM dd, yyyy - hh:mm a').format(contract.date);

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
              title: Text(
                "Station: ${contract.stationName}",
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: $formattedDate',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method: ${contract.paymentMethod}',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '฿ ${contract.totalPrice}',
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status: ${contract.status}',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
