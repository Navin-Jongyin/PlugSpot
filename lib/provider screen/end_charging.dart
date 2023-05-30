import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/provider%20screen/service.dart';
import 'package:http/http.dart' as http;

class EndCharging extends StatefulWidget {
  final Contract contract;

  const EndCharging({Key? key, required this.contract}) : super(key: key);

  @override
  State<EndCharging> createState() => _EndChargingState();
}

class _EndChargingState extends State<EndCharging> {
  TextEditingController timeController = TextEditingController();
  double? electricPrice;
  String getTimeRange(int timeSlot) {
    int startHour = 7 + timeSlot;
    int endHour = 8 + timeSlot;

    String startTime = startHour.toString().padLeft(2, '0') + ":00";
    String endTime = endHour.toString().padLeft(2, '0') + ":00";

    return "$startTime - $endTime";
  }

  double calculatePrice(double timeUsed) {
    double elecPrice = 7.0 * timeUsed;
    electricPrice = elecPrice;
    return elecPrice;
  }

  Future<void> updateContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/update";
    final cookie = await CookieStorage.getCookie();
    var data = {
      'contractId': widget.contract.contractId,
      'status': "complete",
      'totalPrice': electricPrice,
    };
    final response = await http.patch(Uri.parse(apiUrl),
        headers: {'Cookie': cookie ?? ''}, body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response.body);
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
              MaterialPageRoute(
                builder: (context) => OnGoingService(),
              ),
            );
          },
        ),
        title: Text(
          "Finish Charging",
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
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.greyColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Customer Name: ${widget.contract.customerName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Booking Date: ${widget.contract.bookingDate.toString().substring(0, 10)}',
                ),
                SizedBox(height: 10),
                Text('Car Plate: ${widget.contract.carPlate}'),
                SizedBox(height: 10),
                Text('Time: ${getTimeRange(widget.contract.timeSlot)}'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: timeController,
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
              cursorColor: Palette.yellowTheme,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Palette.greyColor),
                  ),
                  labelText: "Enter Time Used (MINUTE)",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.backgroundColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: GoogleFonts.montserrat(
                      fontSize: 14, color: Palette.backgroundColor)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        height: 100,
        width: double.infinity,
        child: FloatingActionButton(
          onPressed: () {
            print(calculatePrice(double.parse(timeController.text)));
            updateContract();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Palette.yellowTheme,
          child: Text(
            "End Charging",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Palette.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
