import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';

import '../data/cookie_storage.dart';
import 'package:http/http.dart' as http;

class OnGoing extends StatefulWidget {
  const OnGoing({Key? key}) : super(key: key);

  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  List<Map<String, dynamic>> contracts = [];

  Future<void> getContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/getusercontract";
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        contracts = List<Map<String, dynamic>>.from(responseBody);
      });
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    getContract();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "On Going",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor),
        ),
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
      ),
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];
          final contractId = contract['contractId'];
          final customerName = contract['customerName'];
          final bookingDate = contract['date'];
          final contractStatus = contract['status'];

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text('Contract ID: $contractId'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Name: $customerName'),
                  Text('Booking Date: $bookingDate'),
                  Text('Contract Status: $contractStatus'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
