import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/screen/booking_Confirmation.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
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
          icon: Icon(
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
              height: 250,
              color: Palette.greyColor,
              child: Center(
                child: Text("For image"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "College Town Ladkrabang",
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
                          "Address",
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
                          "0812345678",
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
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BookingConfirmation(),
              ),
            );
          },
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

  Widget _buildTimeSlots() {
    final startTime = TimeOfDay(hour: 8, minute: 0);
    final endTime = TimeOfDay(hour: 20, minute: 0);
    final timeSlots = [];

    final now = DateTime.now();
    final startDate = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endDate =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

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
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
          final formattedEndTime =
              '${time.hour + 1}:${time.minute.toString().padLeft(2, '0')}';

          return Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Palette.yellowTheme)),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              backgroundColor: Palette.whiteBackgroundColor,
              child: Center(
                child: Text(
                  '$formattedStartTime - $formattedEndTime',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Palette.backgroundColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
