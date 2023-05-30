import 'dart:convert';
import 'dart:ffi';

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
  String? paymentMethod;
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

  @override
  void initState() {
    super.initState();
    getUserId(); // Call getUserId function when the widget is initialized
  }

  @override
  void dispose() {
    timeController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  int? providerId;
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
        print(providerId);
      }
    });
  }

  Future<void> updateContract() async {
    final apiUrl = "https://plugspot.onrender.com/contract/update";
    final cookie = await CookieStorage.getCookie();
    var data = {
      'providerId': providerId,
      'contractId': widget.contract.contractId,
      'status': "complete",
      'totalPrice': electricPrice,
      'paymentMedthod': paymentMethod,
    };
    final response = await http.patch(Uri.parse(apiUrl),
        headers: {'Cookie': cookie ?? ''}, body: jsonEncode(data));
    if (response.statusCode == 200) {
      print(response.body);
      updateTimeSlot();
      updateCarStatus();
    } else {
      print(response.body);
      updateTimeSlot();
      updateCarStatus();
    }
  }

  Future<void> updateTimeSlot() async {
    final apiUrl = "https://plugspot.onrender.com/station/timeslotupdate";
    final cookie = await CookieStorage.getCookie();
    var data = {
      'providerId': providerId,
      'stationId': widget.contract.stationId,
      'timeSlotNo': widget.contract.timeSlot,
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
    var data = {
      'userId': widget.contract.customerId,
      'carId': widget.contract.carId,
      'carStatus': "free"
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

  void sendValues(String method) {
    // Use the 'method' parameter to determine which value was selected
    print('Selected payment method: $method');
    // Perform actions based on the selected value
    setState(() {
      paymentMethod = method;
    });
    print(paymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    bool canEndCharging = paymentMethod != null &&
        timeController.text
            .isNotEmpty; // Check if payment method is selected and timeController is not empty

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
                    OnGoingService(),
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
              onChanged: (value) {
                setState(() {
                  electricPrice = calculatePrice(double.parse(value));
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
                      fontSize: 14, color: Palette.backgroundColor)),
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
                  ? "Total Price: \$${electricPrice!.toStringAsFixed(2)}"
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
                          borderRadius: BorderRadius.circular(10)),
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
                              color: Palette.backgroundColor),
                        )
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
                          borderRadius: BorderRadius.circular(10)),
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
                              color: Palette.backgroundColor),
                        )
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
              ? updateContract
              : null, // Disable the button if payment method or timeController is not selected
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
