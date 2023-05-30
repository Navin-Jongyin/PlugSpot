import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugspot/config/palette.dart';
import 'package:plugspot/provider%20screen/service.dart';

class EndCharging extends StatefulWidget {
  final Contract contract;

  const EndCharging({Key? key, required this.contract}) : super(key: key);

  @override
  State<EndCharging> createState() => _EndChargingState();
}

class _EndChargingState extends State<EndCharging> {
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
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        height: 220,
        width: double.infinity,
        color: Palette.greyColor,
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
            Text('Status: ${widget.contract.status}'),
          ],
        ),
      ),
    );
  }
}
