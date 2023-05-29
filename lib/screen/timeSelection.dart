import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/data/cookie_storage.dart';

import 'package:http/http.dart' as http;

class TimeSelection extends StatefulWidget {
  final int? stationId;
  final String? stationName;
  final String? stationDetail;
  final String? providerPhone;
  final String? stationImageUrl;

  TimeSelection({
    this.stationId,
    this.providerPhone,
    this.stationDetail,
    this.stationName,
    this.stationImageUrl,
  });

  @override
  _TimeSelectionState createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  String baseUrl = 'https://plugspot.onrender.com';
  List<Map<String, dynamic>> timeSlots = [];
  TimeOfDay? selectedSlot;

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

  @override
  void initState() {
    super.initState();
    getAllStation();
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
          onPressed: () {},
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
