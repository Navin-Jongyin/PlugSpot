import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:http/http.dart' as http;

class StartCharging extends StatefulWidget {
  final Contract contract;

  StartCharging({required this.contract});

  @override
  State<StartCharging> createState() => _StartChargingState();
}

class _StartChargingState extends State<StartCharging> {
  int? providerId;

  Future<void> updateContract() async {
    final apiUrl = 'https://plugspot.onrender.com/contract/update';
    final cookie = await CookieStorage.getCookie();

    var data = {
      'providerId': providerId,
      'contractId': widget.contract.contractId,
      'status': "on Going",
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

  Future<void> getUserId() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );
    setState(() {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final id = responseData['message']['ID'];
        providerId = id;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
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
          "Start Charging",
          style: GoogleFonts.montserrat(
              fontSize: 18,
              color: Palette.backgroundColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            padding: EdgeInsets.all(25),
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
              color: Palette.whiteBackgroundColor,
              border: Border.all(
                color: Palette.greyColor,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 3),
                  blurRadius: 7,
                  color: Palette.greyColor,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("images/icon/charger.png"),
                        size: 25,
                        color: Palette.yellowTheme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.contract.stationName,
                        style: GoogleFonts.montserrat(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ImageIcon(
                        AssetImage("images/icon/charger.png"),
                        size: 25,
                        color: Palette.yellowTheme,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.contract.customerName,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.contract.timeSlot.toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      const ImageIcon(
                        AssetImage(
                          "images/icon/car.png",
                        ),
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.contract.carPlate,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
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
            updateContract();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Start Charging",
            style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Palette.backgroundColor),
          ),
          backgroundColor: Palette.yellowTheme,
        ),
      ),
    );
  }
}
