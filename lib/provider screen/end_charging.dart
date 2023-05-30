import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plugspot/provider%20screen/bookingQueue.dart';
import 'package:plugspot/provider%20screen/onGoing.dart';

class EndCharging extends StatefulWidget {
  final String contractId;
  final String customerName;
  final DateTime bookingDate;
  final String contractStatus;

  const EndCharging({
    Key? key,
    required this.contractId,
    required this.customerName,
    required this.bookingDate,
    required this.contractStatus,
  }) : super(key: key);

  @override
  State<EndCharging> createState() => _EndChargingState();
}

class _EndChargingState extends State<EndCharging> {
  TextEditingController timeController = TextEditingController();
  double? electricPrice;
  String? paymentMethod;

  Future<void> updateContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/update";
    final cookie = await CookieStorage.getCookie();
    final providerId = await getUserId();
    final totalPrice = electricPrice! * 7;

    final data = {
      'providerId': providerId,
      'contractId': int.parse(widget.contractId),
      'status': "complete",
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod ?? '',
    };

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ''},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      await updateTimeSlot();
      await updateCarStatus();
    } else {
      print(response.body);
      print(providerId);
      //await updateTimeSlot();
      //await updateCarStatus();
    }
  }

  Future<void> updateTimeSlot() async {
    final apiUrl = "https://plugspot.onrender.com/station/timeslotupdate";
    final cookie = await CookieStorage.getCookie();
    final providerId = await getUserId();

    final data = {
      'providerId': providerId.toString(),
      'stationId': widget.contractId,
      'timeSlotNo': widget.contractId,
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

  Future<void> updateCarStatus() async {
    final apiUrl = "https://plugspot.onrender.com/car/update";
    final cookie = await CookieStorage.getCookie();

    final data = {
      'userId': widget.contractId,
      'carId': widget.contractId,
      'carStatus': "free",
    };

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
    }
  }

  Future<int> getUserId() async {
    final apiUrl = 'https://plugspot.onrender.com/userAccount/currentuser';
    final cookie = await CookieStorage.getCookie();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Cookie': cookie ?? ""},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final id = responseData['message']['ID'];
      return id;
    } else {
      print(response.statusCode);
      print(response.body);
      return 0;
    }
  }

  void sendValues(String method) {
    setState(() {
      paymentMethod = method;
    });
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canEndCharging =
        paymentMethod != null && timeController.text.isNotEmpty;

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
                builder: (context) => OnGoing(),
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
                  'Customer Name: ${widget.customerName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Booking Date: ${widget.bookingDate.toString().substring(0, 10)}',
                ),
                SizedBox(height: 10),
                Text('Car Plate: ${widget.contractId}'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: timeController,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Palette.yellowTheme,
              textAlign: TextAlign.right,
              onChanged: (value) {
                setState(() {
                  electricPrice = double.tryParse(value);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Palette.greyColor),
                ),
                labelText: "Enter Time Used (MINUTE)",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.backgroundColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Palette.backgroundColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total Price",
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              electricPrice != null
                  ? "Total Price: \$${(electricPrice! * 7).toStringAsFixed(2)}"
                  : "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Methods",
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      sendValues("Cash");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: paymentMethod == 'Cash'
                          ? Colors.grey
                          : Palette.yellowTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money,
                          color: Palette.backgroundColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Cash",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Palette.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      sendValues("QR Code");
                    },
                    style: ElevatedButton.styleFrom(
                      primary: paymentMethod == 'QR Code'
                          ? Colors.grey
                          : Palette.yellowTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Palette.backgroundColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "QR Code",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Palette.backgroundColor,
                          ),
                        ),
                      ],
                    ),
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
        child: ElevatedButton(
          onPressed: canEndCharging
              ? () {
                  if (canEndCharging) {
                    // Perform the updateContract function here
                    updateContract();

                    // Navigate to the BookingQueue page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingQueue()),
                    );
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            primary: canEndCharging ? Palette.yellowTheme : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
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
